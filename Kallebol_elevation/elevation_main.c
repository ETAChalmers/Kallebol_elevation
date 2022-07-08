/*
 * File:   elevation_main.c
 * Author: David Johansson
 *
 * Created on July 21, 2021, 1:19 PM
 */


 /*
  * UART communication
  * 
  * UART is done without a controll bit at 9600 Baud with 2 8-bit packets (16bit)
  * The package stucture is as follows.
  * 0b CCCD DDDD DDDD DDDD
  * C is command
  * D is the payload
  * 
  * Some commands ignore payload
  * 
     Avalible commands
     * 000 - reserved
     * 001 - unused 
     * 010 - unused
     * 011 - Set current position accoring to the following data
     * 100 - Goto position accoring to the following data
     * 101 - Turn off LED1
     * 110 - Turn on  LED1
     * 111 - Home the elevation controll
     * 
     
     */


#include <xc.h>
#include <stdint.h>


#define _XTAL_FREQ 16000000 // 16'000'000Hz

#define LED1                PORTEbits.RE1
#define LED1_TRIS           TRISEbits.TRISE1
#define LED2                PORTEbits.RE0
#define LED2_TRIS           TRISEbits.TRISE0

#define Limit               PORTDbits.RD0
#define Home                PORTDbits.RD1

#define PW1                 PORTDbits.RD2    //PW1=1,PW2=0   Retract
#define PW1_TRIS            TRISDbits.TRISD2
#define PW2                 PORTDbits.RD3    //PW1=0,PW2=1   Extend
#define PW2_TRIS            TRISDbits.TRISD3
#define PW_port             PORTD
#define Encode_dir          PORTBbits.RB1
#define Encode_dir_TRIS     TRISBbits.TRISB1

#pragma config FOSC = XT        // Oscillator Selection bits (RC oscillator)
#pragma config WDTE = OFF        // Watchdog Timer Enable bit (WDT enabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config CP = OFF         // FLASH Program Memory Code Protection bits (Code protection off)
#pragma config BOREN = ON       // Brown-out Reset Enable bit (BOR enabled)
#pragma config LVP = OFF        // Low Voltage ZIn-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
#pragma config CPD = OFF        // Data EE Memory Code Protection (Code Protection off)
#pragma config WRT = OFF        // FLASH Program Memory Write Enable (Unprotected program memory may not be written to by EECON control)

int16_t position = 0;
int16_t deadspace = 10;
int16_t goto_pos = 0;
uint8_t recived_data = 0;
uint16_t input_command = 0;

uint8_t wait_for_UART = 0; //If this flag is high the MCU waits for another UART package 
uint8_t homing = 0; //If this flag is high, the machine will home and set the zero position.



void check_target(){
    
    if(!homing){   
        if(position > goto_pos){ //If position is greater than goto
            PW1 = 0;
            PW2 = 1;

           }else if(position < goto_pos){ //If position is 
               PW2 = 0;
               PW1 = 1;   

           }else{
               PW1 = 0;
               PW2 = 0;

           }
    }else{  //if homing sequence is active
        
        PW1 = 1; //Make sure this direction is correct,
        PW2 = 0; //This should be retracting
    }
    
    
    if(Home){
        PORTD = PORTD && 0b11110111; //ONLY disallow retraction
        position = 0;
        homing = 0;
    }
    
    if(Limit){
        PORTD = PORTD && 0b11111011; //ONLY disallow extention
    }
}

void interrupt isr()
{
      
    if (RCIF){ 
        if(wait_for_UART){
            input_command = (recived_data<<8) || RCREG;
            recived_data = 0;
            wait_for_UART = 0;
        }else{  //If just the first part of the command the MCU will wait for another byte
            recived_data = RCREG;
            wait_for_UART = 1;
        }
        RCREG = 0; 

        
        update_machinestate();
    }
    
    if(INTF){
        INTCONbits.INTF = 0;
        __delay_ms(1);
        if(Encode_dir){
            position++;
        }else{
            position--;
    }
        
                    
    }
    check_target();
}

void update_machinestate(){

    if(input_command){
            //Only the top 3 bits are avalible for different commands
            uint8_t command = ((input_command && 0xE000) >> 13);
            uint16_t command_data = input_command && 0x1FFF;
            
            if(command == 0b00000100){ //Command to initiate movment
                goto_pos = command_data;         
                
            } else if(command == 0b00000011) { //
                position = command_data;
                
            } else if(command == 0b00000111) { //Command to home the device
                homing = 1;
                
            } else if(command == 0b00000110) { //Command to turn on LED1, useful for debug
                LED1 = 1;
                
            } else if(command == 0b00000101) { //Command to home the device
                LED1 = 0;
            }
        command_data = 0;
        command = 0;
        input_command = 0;
    }
}



void main(void) {
    TRISA = 0xFF;   //set all digital I/O to inputs
    TRISB = 0xFF;
    TRISC = 0xFF;

    LED1_TRIS = 0;      //LED1 is an output
    LED2_TRIS = 0;      //LED2 is an output
    PW1_TRIS = 0;       //Halfbridge powerpin 1
    PW2_TRIS = 0;       //Halfbridge powerpin 2
    Encode_dir_TRIS = 1; //The flag for wich way the encoder is spinning
    PW1 = 0;
    PW2 = 0;
    
    BRGH = 0;  // High-Speed Baud Rate
    SPBRG = 25; // Set The Baud Rate To Be 9615 baud (datasheet Table 10.4)
    
    SYNC = 0; //Async mode
    SPEN = 1; //Enable serialport on RC7 and RC6

    INTEDG = 1;      //interrupt on the rising edge
    INTE = 1;        //enable the external interrupt
    
    RCIE = 1;  // UART Receving Interrupt Enable Bit
    PEIE = 1;  // Peripherals Interrupt Enable Bit
    GIE = 1;         //set the Global Interrupt Enable
    RX9 = 0;
    CREN = 1;  // Enable UART Data Reception
    
    //RCIF = 0;        //reset the UART interrupt flag
    INTF = 0;        //reset the external interrupt flag
    LED1 =0 ;
    LED2 =0;


    

    
//    while(1)
//    {  
//        
//    }
    return;
}
