# Kallebol_elevation
Microcontroller and code for controlling elevation of kallebolen.

The microcontroller communicates via UART, in the current state it will only recive commands without acknowledging them.

## Communication interface

UART is done without a controll bit at 9600 Baud with 8-bit command packets with optional payload and no 9:th control bit.
if the first bit is a 1 the command requires a 16-bit payload composed as 2 8-bit packages, (MSB). 

The interval between packages is non-critical. All inputed 16-bit commands will be cast as uint16_t, no negative position values allowed.

**Observe** if the controller expects a payload and only one 8-bit package arrives the device statemachine will wait indefinetly without a timeout.

     Avalible commands
     * 0b00000000 - No operation, can be used to flush a desync, Reserved
     * 0b00000101 - Turn off LED1
     * 0b00000110 - Turn on  LED1
     * 0b00000111 - Home the elevation control
     * 0b00001000 - abort homing (without applying a new position)
     * 0b10000011 - Sets the current position accoring to the payload
     * 0b10000100 - Goto a position accoring to the payload (position is defined as points in the rotationcycle of the acctuator, I.E a arbritary unit)
     
**Example usage of communication**
 - 0b00000000 //Flush statemachine from unknown state on boot
 - 0b00000000 //Flush statemachine from unknown state on boot
 - 0b00000111 // To initiate homeing sequence
 - Wait 20sec to allow homeing to complete
 - 0b00001000 // Abort homeing sequence, in case the limitswitch failed this will ensure the statemachine is reset
 - 0b10000011 //Set the current position to zero, incase the limitswitch failed, if homeing was successfull it should be at 0 already
 - 0b00000000 //Data payload
 - 0b00000000 //Data payload
 - 0b10000100 //Move to position, IE tilt the parabola dish
 - 0b00000001 //data payload for 256 
 - 0b00000000 //data payload for 256
 
 The elevation should now move to position 256
 
## Software workings
The entire microcontroller works in interupts, if no interupt is generated (UART or Encoder) the machinestate will not change.

A encoder is connected to the microcontroller, when rotated interupts are generated which updates the current software position of the acctuator and checks if the position is reached.
