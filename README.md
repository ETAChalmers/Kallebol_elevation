# Kallebol_elevation
Microcontroller and code for controlling elevation of kallebolen.

The microcontroller communicates via USB.

## Communication interface
 
### commandlist

 - ELEVATION HOME START    - Start homing of the elevationcontroller, this resets the current position
 - ELEVATION HOME STOP     - Stop homing
 - ELEVATION SET *Integer* - Set current position
 - ELEVATION GOTO *Integer* - Set current target position
 - ELEVATION STOP          - kind of a E-stop to the elevation controller, the onboard motor driver should not output any voltage
 - ELEVATION STOP RESET    - turn off the stop state
 - ELEVATION GET POSITION  - returns the current position of the controller
 - ELEVATION GET TARGET    - returns the target position of the controller
 - ELEVATION GET FLAGS     - returns the states of the controller
 - ELEVATION GET ALL       - returns all of the states and positions
 - LOAD LOAD1 [ON/OFF]     - turn on/off load 1
 - LOAD LOAD2 [ON/OFF]     - turn on/off load 2
 - LED ONBOARD [ON/OFF]    - turn on/off the MCUs onboard LED
 - LED PCB0 [ON/OFF]       - turn on/off LED 0 on the PCB
 - LED PCB1 [ON/OFF]       - turn on/off LED 0 on the PCB
 - LED PCB2 [ON/OFF]       - turn on/off LED 0 on the PCB
 - LED PCB3 [ON/OFF]       - turn on/off LED 0 on the PCB
 - RFSWITCH    (TBD)
