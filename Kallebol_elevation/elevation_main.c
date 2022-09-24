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

#define LED1                1//PORTEbits.RE1 //Blue
#define LED1_TRIS           TRISEbits.TRISE1
#define LED2                0//PORTEbits.RE0 //Red
#define LED2_TRIS           TRISEbits.TRISE0
#define LED3                2//PORTEbits.RE2 //Yellow
#define LED3_TRIS           TRISEbits.TRISE2

#define Limit               PORTDbits.RD0
#define Home                PORTDbits.RD1

#define PW1                 PORTDbits.RD2    //PW1=1,PW2=0   Retract
#define PW1_TRIS            TRISDbits.TRISD2
#define PW2                 PORTDbits.RD3    //PW1=0,PW2=1   Extend
#define PW2_TRIS            TRISDbits.TRISD3
#define PW_port             PORTD
#define Encode_Int_pin      PORTBbits.RB0
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
int16_t deadspace = 2;
int16_t goto_pos = 0;
uint16_t recived_data = 0;
uint8_t input_command = 0;
int8_t move_dir = 0;            //0 for standstill, -1 retrac, +1 extend
uint8_t last_enc_value = 0;

uint8_t wait_for_UART_data = 0; 
//this flag indicates what state the 16-bit data reception machine is in
uint8_t awaiting_command = 1;
uint8_t awaiting_second_byte = 0; //Used in UART to recive 16bit data package
uint8_t homing = 0; //If this flag is high, the machine will home and set the zero position.

//Using latch registers as recomended by XC8 manual 3.7.4
uint8_t PORTE_latch =0x00; 
uint8_t PORTD_latch =0x00;
//uint8_t PORTB_latch =0x00;

void latch_registers(){
    PORTE = PORTE_latch;
    PORTD = PORTD_latch;
}

void check_target(){
    
    //### Normal poitioning stuff   
    if(!homing){
        
        if((position - deadspace) > goto_pos){ 
            move_dir = -1; //retract

        }else if((position + deadspace)  < goto_pos){
            move_dir = 1; //extend

        }else{
            move_dir = 0;
        }
        
    }else{  //if homing sequence is active
        
        move_dir = -1;
    }
    
    //### Saftey features
    //Limit switches have a pullup, low == triggered
    
    if((! Home ) && move_dir == -1){ //Homing switch was hit
        move_dir = 0;
        position = 0;
        homing = 0;
        goto_pos = 0;
        
    }
    
    if((! Limit)  && move_dir == 1){
        move_dir = 0; 
    }
    
     //### Apply output depending on control state
    
    if(move_dir == 1){ //Extend
        bitset(PORTD_latch,2);
        bitclr(PORTD_latch,3);

    }else if(move_dir == -1){ //retract  
        bitset(PORTD_latch,3);
        bitclr(PORTD_latch,2);

    }else{
        bitclr(PORTD_latch,2);
        bitclr(PORTD_latch,3);
    }
}

void trans(uint8_t a){

    while(TRMT == 0){ //Ensure data is ready to be loaded
    } 
    TXREG=a;

}

void update_machinestate(){
    //Updates state_machine state
   
    
    if(awaiting_command == 0 && wait_for_UART_data == 0){
        //If a full command has been recived
        
        if(input_command == 0b10000100){ // command to move to a absolute position
            goto_pos = recived_data;
        } else if(input_command == 0b10000011){ // command to set the current position
            position = recived_data;  
        }
        awaiting_command = 1;
        recived_data = 0;
        wait_for_UART_data = 0;
        input_command = 0;

    }
    
    
    if(input_command && awaiting_command){
        bitclr(PORTE_latch,LED2);
        //If a new command byte has been recived
        
        //trans(input_command); //For some reason the TX wont work,
        //The MCU hangs when loading data into TXREG
        
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
            bitset(PORTE_latch,LED1);

        } else if(input_command == 0b00000101) { //Command to turn off LED1, useful for debug
            bitclr(PORTE_latch,LED1);
        }else{
            //Invalid command, Set status LED
            bitset(PORTE_latch,LED2);
            return;
        }
    }

   
}

void uart_rec(){
    
    if(RCSTAbits.OERR){ 
        CREN = 0;
        NOP();
        CREN=1;
    }
    
    if(awaiting_command){
        input_command = RCREG;
    
    } else if(!awaiting_command){  
       
        if(wait_for_UART_data == 2){
            ///If it is now waiting for the last byte in the UART data 
            recived_data |= RCREG;
            wait_for_UART_data = 0;
            
        } else if(wait_for_UART_data == 1 & !recived_data) {
            
             //If it is now waiting for the first byte in the UART data 
            recived_data = RCREG << 8;
            wait_for_UART_data = 2;
            
        }
    }
    //Update machinestate is at the end of this statement to allow for echo to propagate before changes
    update_machinestate();

    if(awaiting_command){
        input_command = 0;
    }
}

void __interrupt() isr(void){

    if (RCIF){ 
        RCIF = 0;
        uart_rec();
        RCREG = 0;
    }
    

    if(INTF){   
        INTF = 0;         
    }
    //check_target();

}

void debug(){
    if(homing){
        bitset(PORTE_latch,LED3);
    } else {
        bitclr(PORTE_latch,LED3);
    }
    
    if(move_dir == 1){
        bitset(PORTE_latch,LED2);
    }else{
        bitclr(PORTE_latch,LED2);
    }
    
}

void main(void) {

    TRISA = 0xFF;//set all digital I/O to inputs
    TRISB = 0xFF;
    TRISC = 0xFF; 
 
    TRISCbits.TRISC6 = 1; //RX pin input enable
    TRISCbits.TRISC7 = 0; //TX pin output enable
    
    LED1_TRIS = 0;      //LED1 is an output
    LED2_TRIS = 0;      //LED2 is an output
    LED3_TRIS = 0;      //LED3 is an output
    PW1_TRIS = 0;       //Halfbridge powerpin 1
    PW2_TRIS = 0;       //Halfbridge powerpin 2
    Encode_dir_TRIS = 1; //The flag for wich way the encoder is spinning

        
    bitset(PORTE_latch,LED2);
    PORTE = PORTE_latch;
    
    
    BRGH = 0;   // High-Speed Baud Rate
    SPBRG = 25; // Set The Baud Rate To Be 9615 baud (datasheet Table 10.4)
    
    SYNC = 0;   //Async mode
    SPEN = 1;   //Enable serialport on RC7 and RC6
    // TXIE = 0;   // disallow tx interrupts
    // TXEN = 0;   //Enable TX
    TX9 = 0;    //8-bit mode
    RX9 = 0;    //8-bit mode
    
    
    CREN = 1;   // Enable UART Data Reception
    
    INTEDG = 1;      //external interrupt on the rising edge
    //INTE = 1;        //enable the external interrupt
    
    
    RCIE = 1;   // UART Receving Interrupt Enable Bit
    PEIE = 1;   // Peripherals Interrupt Enable Bit
    GIE = 1;    //set the Global Interrupt Enable
    
    
    
    //TXSTA = 0X24; //Enable TX Async 8-bit mode   
    RCIF = 0;        //reset the UART interrupt flag
    
    INTF = 0;        //reset the external interrupt flag
    last_enc_value = 0;

    
    while(1){ //Horrendus but for some reason the interup for the pin would not work
        
        if(Encode_Int_pin == 0 && last_enc_value == 0){
            //Find Rising edge
        
            last_enc_value = 1;
            
            __delay_ms(2);//Debounce
            
            if(Encode_dir){
                position--;
            }else{
                position++;
            }
        }
        
        if(Encode_Int_pin == 1 && last_enc_value){
            last_enc_value = 0;
            __delay_ms(2);//Debounce
        }
        
        check_target();

        
        //debug();
        
        if(homing){
            bitset(PORTE_latch,LED3);
        } else {
            bitclr(PORTE_latch,LED3);
        }
        
        latch_registers();
    }  
    return;
}
