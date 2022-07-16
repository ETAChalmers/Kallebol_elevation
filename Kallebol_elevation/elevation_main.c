/*
 * File:   elevation_main.c
 * Author: David Johansson
 *
 * Created on July 21, 2021, 1:19 PM
 */


 /*
  * UART communication
  * 
  * UART is done without a controll bit at 9600 Baud with 3 8-bit packets (24bit)
  * The first byte indicates what command is sent
  * The following bytes are optional and only used if a 0b1xxxxxxx command is sent,
  * A command that requires additional input
  * 
     Avalible commands
     * 0b00000000 - No operation, can be used to flush a desync, Reserved
     * 
     * 
     * 0b10000011 - Set current position accoring to the following data
     * 0b10000100 - Goto position accoring to the following data
     * 0b00000101 - Turn off LED1
     * 0b00000110 - Turn on  LED1
     * 0b00000111 - Home the elevation control
     * 0b00001000 - abort homing
     
     */


#include <xc.h>
#include <stdint.h>


#define _XTAL_FREQ 16000000 // 16'000'000Hz

#define LED1                PORTEbits.RE1 //Hardware designation = D3 on pin 10
#define LED1_TRIS           TRISEbits.TRISE1
#define LED2                PORTEbits.RE0 //Hardware designation = D1 on pin 9
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

#define bitset(var, bitno) ((var) |= 1UL << (bitno))
#define bitclr(var, bitno) ((var) &= ~(1UL << (bitno)))

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
uint16_t recived_data = 0;
uint8_t input_command = 0;

uint8_t wait_for_UART_data = 0; //If this flag is high the MCU waits for another UART package 
uint8_t awaiting_command = 1;
uint8_t homing = 0; //If this flag is high, the machine will home and set the zero position.

//Using latch registers as recomended by XC8 manual 3.7.4
uint8_t PORTE_latch =0x00; 
uint8_t PORTD_latch =0x00;
//uint8_t PORTB_latch =0x00;


void check_target(){
    
    if(!homing){
        if(position > goto_pos){ //If position is greater than goto
            //PW1 = 0;
            //PW2 = 1;
            PORTD_latch &= 0b11111011; //PD2/PW1 = 0
            PORTD_latch |= 0b00001000; //PD3/PW2 = 1    

        }else if(position < goto_pos){ //If position is 
            //PW2 = 0;
            //PW1 = 1;
            PORTD_latch |= 0b00000100; //PD2/PW1 = 1
            PORTD_latch &= 0b11110111; //PD3/PW2 = 0 

        }else{
            PORTD_latch &= 0b11110011; //PD2&PD3 = 0
            //Position reached

        }
    }else{  //if homing sequence is active
        
        PORTD_latch &= 0b11111011; //PD2/PW1 = 0
        PORTD_latch |= 0b00001000; //PD3/PW2 = 1    
    }
    
    
    if(Home){
        PORTD_latch &= 0b11110111; 
        //ONLY disallow retraction as it is in an end state
        position = 0;
        homing = 0;
    }
    
    if(Limit){
        PORTD_latch &= 0b11111011; 
        //ONLY disallow extention as it is in an end state
    }
}

void trans(uint8_t a){
    while(!TRMT){
        TXREG=a;
    }
}

void update_machinestate(){
    
    
    if(awaiting_command == 0 && wait_for_UART_data == 0){
        //If a full command has been recived
        
        if(input_command == 0b10000100){ // command to move to a absolute position
            goto_pos = recived_data;
        } else if(input_command == 0b10000011){ // command to set the current position
            position = recived_data;  
        }
        awaiting_command = 1;
        recived_data = 0;
    }
    
    
    if(input_command && awaiting_command){
        //If a new command byte has been recived
        trans(input_command);
        
        if(input_command & 0b10000000){
            //If the recived command requires additional data to execute
            awaiting_command = 0;
            wait_for_UART_data = 1;
            return;

        //If the command does not require additional data
        } else if(input_command == 0b00000111) { //Command to home the device
            homing = 1;
            
        } else if(input_command == 0b00001000) { //Command to home the device
            homing = 0;
                
        } else if(input_command == 0b00000110) { //Command to turn on LED1, useful for debug
            //LED1 = 1;
            //PORTE |= 0b00000010;
            bitset(PORTE_latch,1);

        } else if(input_command == 0b00000101) { //Command to turn off LED1, useful for debug
            //LED1 = 0;
            //PORTE &= 0b11111101;
            bitclr(PORTE_latch,1);
        }else{
            //Invalid command
            //LED2 = 1; 
            //PORTE |= 0b00000001;
            bitset(PORTE_latch,0);
            return;
        }
    }
    //LED2 = 0;
    //PORTE &= 0b11111110;
    bitclr(PORTE_latch,0);
}
void uart_rec(){
    if(awaiting_command){
        input_command = RCREG;
    
    } else if(!awaiting_command){
       
        if(wait_for_UART_data & recived_data){
            ///If it is now waiting for the last byte in the UART data 
            recived_data = (uint8_t) (RCREG << 8);
            wait_for_UART_data = 0;
            
        } else if(wait_for_UART_data & !recived_data) {
             //If it is now waiting for the first byte in the UART data 
            recived_data = RCREG;
            
        }
    }
    //Update machinestate is at the end of this statement to allow for echo to propagate before changes
    update_machinestate();
    //Latching in ports
    PORTE = PORTE_latch; 
    PORTD = PORTD_latch;
    input_command = 0;
}


void __interrupt() isr(void){
    //LED2 = 1;
    
    if (RCIF){ 
        RCIF = 0;
        uart_rec();
        RCREG = 0;
        
        
    }
    //LED2 = 0;
    //LED1 = 1;
    if(INTF){
        INTF = 0;
        //__delay_ms(1);
        if(Encode_dir){
            position++;
        }else{
            position--;
        }
                  
    }
    check_target();
    
    //LED1 = 0;
}


void main(void) {

    TRISA = 0xFF;   //set all digital I/O to inputs
    TRISB = 0xFF;
    //TRISC = 0xFF;
    TRISC = 0X80; //Enable RX/TX on the device

    LED1_TRIS = 0;      //LED1 is an output
    LED2_TRIS = 0;      //LED2 is an output
    PW1_TRIS = 0;       //Halfbridge powerpin 1
    PW2_TRIS = 0;       //Halfbridge powerpin 2
    Encode_dir_TRIS = 1; //The flag for wich way the encoder is spinning

    
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
    
    //TXSTA = 0X24; //Enable TX Async 8-bit mode   
    RCIF = 0;        //reset the UART interrupt flag
    INTF = 0;        //reset the external interrupt flag
    
    while(1){ //Horrendus but for some reason main() kept executing
    }
    return;
}
