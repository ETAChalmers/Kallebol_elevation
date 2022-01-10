# Kallebol_elevation
Microcontroller and code for controlling elevation of kallebolen.

The microcontroller communicates via UART

UART is done without a controll bit at 9600 Baud with 2 8-bit packets (16bit)
The package stucture is as follows.
0b CCCD DDDD DDDD DDDD
C is command
D is the payload
 
Some commands ignore payload
 
     Avalible commands
     * 000 - reserved
     * 001 - unused 
     * 010 - unused
     * 011 - Set current position accoring to the following payload
     * 100 - Goto position accoring to the following payload
     * 101 - Turn off LED1
     * 110 - Turn on  LED1
     * 111 - Home the elevation controll
