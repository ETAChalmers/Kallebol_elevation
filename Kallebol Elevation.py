from machine import Pin
import select
import sys
import time
onboardled = Pin("LED", Pin.OUT)
PCB0_LED = Pin(10, Pin.OUT)
PCB1_LED = Pin(11, Pin.OUT)
PCB2_LED = Pin(12, Pin.OUT)
PCB3_LED = Pin(13, Pin.OUT)
LOAD1_pin = Pin(8, Pin.OUT)
LOAD2_pin = Pin(9, Pin.OUT)
ENC_A = Pin(6,Pin.IN,Pin.PULL_DOWN)
ENC_B = Pin(7,Pin.IN,Pin.PULL_DOWN)

Homing_pin = Pin(15,Pin.IN)
Limit_pin = Pin(14,Pin.IN)

RF1_pin = Pin(2, Pin.OUT)
RF2_pin = Pin(3, Pin.OUT)
RF3_pin = Pin(4, Pin.OUT)
RF4_pin = Pin(5, Pin.OUT)

H_bridge_1 = Pin(17, Pin.OUT) #H bridge inputs
H_bridge_2 = Pin(16, Pin.OUT)
H_bridge_1.value(0) #init as 0
H_bridge_2.value(0)

poll_obj = select.poll()
poll_obj.register(sys.stdin, select.POLLIN)


#Global values
stop = 0 # a pseudo E-stop
HW_stop = 0 # indicates that a hardware stop has been reached -1 homing switch, 1 limit switch
homeing = 0
movedir = 0 # 1 = extend, 0 = break, -1 retract
hardware_movedir = 0 # the movedir as commanded by the elevation controller, for debug purposes
setpoint_value = 0 #value from the master
encoder_value = 0  #The current position of the motor

def Encoder_callback(args):
    global encoder_value
    if ENC_B.value() == 1:
        encoder_value = encoder_value + 1
        print("I increesed the counter to : " + str(encoder_value))
    else:
        encoder_value = encoder_value - 1
        print("I DEcreesed the counter to : " + str(encoder_value))
    time.sleep_ms(1) #debounce
    update_elevation_stage_direction()
        
def homing_callback(args):
    global HW_stop
    encoder_value = 0
    HW_stop = -1
    update_elevation_stage_direction()

def limit_callback(args): # this should do something to ensure that it does not pass the limit
    global HW_stop
    HW_stop = 1
    update_elevation_stage_direction()
        

def LED_handler(data): #accepts splitdata
    #BEHOLD MY IF STATEMENTS!
    if (data[1] == "ONBOARD"): # Onboard the Raspberry
        if (data[2] == "ON"):
            onboardled.value(1)
        else:
            onboardled.value(0)
            
    elif (data[1] == "PCB0"):
        if (data[2] == "ON"):
            PCB0_LED.value(1)
        else:
            PCB0_LED.value(0)
            
    elif (data[1] == "PCB1"):
        if (data[2] == "ON"):
            PCB1_LED.value(1)
        else:
            PCB1_LED.value(0)
            
    elif (data[1] == "PCB2"):
        if (data[2] == "ON"):
            PCB2_LED.value(1)
        else:
            PCB2_LED.value(0)
            
    elif (data[1] == "PCB3"):
        if (data[2] == "ON"):
            PCB3_LED.value(1)
        else:
            PCB3_LED.value(0)
# END LED_handler
        
        
def LOAD_handler(data): #accepts splitdata
    if (data[1] == "LOAD1"): # Onboard the Raspberry
        if (data[2] == "ON"):
            LOAD1_pin.value(1)
        else:
            LOAD1_pin.value(0)
    elif (data[1] == "LOAD2"):
        if (data[2] == "ON"):
            LOAD2_pin.value(1)
        else:
            LOAD2_pin.value(0)

def Elevation_command_handler(data):
    global stop
    global movedir
    global homeing
    global encoder_value
    global setpoint_value
    global HW_stop
    global HWmovedir
    
    if (data[1] == "HOME"):
        if (data[2] == "START"):
            homeing = 1
        else:
            homeing = 0
    if (data[1] == "GOTO"):
        try:
            setpoint_value = int(data[2])
        except Exception as e:
            print(e)
            print(data[3])
    if (data[1] == "SET"):
        try:
            encoder_value = int(data[2])
        except Exception as e:
            print(e)
    if (data[1] == "STOP"):
        stop = 1
        if (data[2] == "RESET"):
            stop = 0
    if (data[1] == "GET"):
        if (data[2] == "POSITION"):
            print(str(encoder_value))
        if (data[2] == "TARGET"):
            print(str(setpoint_value))
        if (data[2] == "FLAGS"):
            print("Homeing : " + str(homeing) + " ,Movedir : " + str(movedir) + " ,HWmovedir : " + str(hardware_movedir) + " ,Stop : " + str(stop) + " ,HW_stop : " + str(HW_stop))
        if (data[2] ==  "ALL"):
            print("Current position = " + str(encoder_value))
            print("Target position = " + str(setpoint_value))
            print("Homeing : " + str(homeing) + " ,Movedir : " + str(movedir) + " ,HWmovedir : " + str(hardware_movedir) + " ,Stop : " + str(stop) + " ,HW_stop : " + str(HW_stop))
            
    
        
    

def command_interpreter(data):
    splitdata = data.split()
    
    #Append data to the end to ensure array is atleast 3 elements
    #yes, there probably is a better way, but c'mon.. this needs to run at like 1Hz
    splitdata.append("")
    splitdata.append("")
    splitdata.append("")
    
    if (splitdata[0] == "LED"):
        LED_handler(splitdata)
    elif (splitdata[0] == "LOAD"):
        LOAD_handler(splitdata)
    elif (splitdata[0] == "RFSWITCH"):
        print("to be implemented")
    elif (splitdata[0] == "ELEVATION"):
        Elevation_command_handler(splitdata)
    elif (splitdata[0] == "EXPANTION"):
        print("to be implemented")
        
    update_elevation_stage_direction()
    
    
    
def update_elevation_stage_direction():
    global stop
    global movedir
    global encoder_value
    global setpoint_value
    global HW_stop
    
    if encoder_value > setpoint_value:
            movedir = 1
    elif encoder_value < setpoint_value:
            movedir = -1
    else:
            movedir = 0
            
    #Stopchecks
    if stop == 1:
        movedir = 0
    if HW_stop == -1 and movedir == -1:
        movedir = 0
    if HW_stop ==  1 and movedir ==  1:
        movedir = 0 
            
    update_H_bridge_state()
        
        
        
def update_H_bridge_state():
    global stop
    global movedir
    global HWmovedir
    if movedir == 1:
        H_bridge_1.value(1)
        H_bridge_2.value(0)
        HWmovedir = 1
        
    elif movedir == -1:
        H_bridge_1.value(0)
        H_bridge_2.value(1)
        HWmovedir = -1
        
    else:
        H_bridge_1.value(0)
        H_bridge_2.value(0)
        HWmovedir = 0
        
    if stop == 1:
        H_bridge_1.value(0)
        H_bridge_2.value(0)
        HWmovedir = 0

def update_stops():
    if Homing_pin.value() == 0 and HW_stop ==  -1:
        HW_stop = 0
    if Limit_pin.value() == 0 and HW_stop ==  1:
        HW_stop = 0
    if Limit_pin.value() == 1:
        HW_stop = 1
    if Homing_pin.value() == 1:
        HW_stop = -1


#enable IRQs
ENC_A.irq(trigger=ENC_A.IRQ_FALLING, handler=Encoder_callback)
Homing_pin.irq(trigger=Homing_pin.IRQ_FALLING, handler=homing_callback)
Limit_pin.irq(trigger=Limit_pin.IRQ_FALLING, handler=limit_callback)
#Infinite loop of the program    
while True:
    update_stops()
    poll_results = poll_obj.poll(10)
    if poll_results:
        data = sys.stdin.readline().strip()
        if data:
            print("received data: ", data)
            command_interpreter(data)
    



