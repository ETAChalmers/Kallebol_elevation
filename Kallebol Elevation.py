#Welcome to Python hell
#by yours truly, SA6DGJ
#range of movement is 1117 pulses
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
        #print_custom("I increased the counter to : " + str(encoder_value))
    else:
        encoder_value = encoder_value - 1
        #print_custom("I Decreased the counter to : " + str(encoder_value))
    time.sleep_ms(1) #debounce
    update_elevation_stage_direction()
        
def homing_callback(args):
    global HW_stop
    global encoder_value
    global homeing
    global setpoint_value
    print_custom("homeswitch reached")
    encoder_value = 0
    setpoint_value = 0
    homeing = 0
    update_stops()
    update_elevation_stage_direction()

def limit_callback(args): # this should do something to ensure that it does not pass the limit
    global HW_stop
    print_custom("limit switch reached")
    update_stops()
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
            foo = []
            foo[0] = e
            foo[1] =data[3]
            print_custom(foo)
    if (data[1] == "SET"):
        try:
            encoder_value = int(data[2])
        except Exception as e:
            print_custom(e)
    if (data[1] == "STOP"):
        stop = 1
        if (data[2] == "RESET"):
            stop = 0
    if (data[1] == "GET"):
        if (data[2] == "POSITION"):
            print_custom(str(encoder_value))
        if (data[2] == "TARGET"):
            print_custom(str(setpoint_value))
        if (data[2] == "FLAGS"):
            print_custom("Homeing : " + str(homeing) + " ,Movedir : " + str(movedir) + " ,HWmovedir : " + str(hardware_movedir) + " ,Stop : " + str(stop) + " ,HW_stop : " + str(HW_stop))
        if (data[2] == "PINS"):
            foo = []
            foo [0] = "LOAD1 : " + str(LOAD1_pin.value()) +  " ,LOAD2 : " + str(LOAD2_pin.value()) + " ,ENC_A : " + str(ENC_A.value()) + " ,ENC_B : " + str(ENC_B.value())
            foo [1] = "Homing_pin : " + str(Homing_pin.value())  + " ,Limit_pin : " + str(Limit_pin.value())
            foo [2] = "RF1_pin " + str(RF1_pin.value()) + " ,RF2_pin " + str(RF2_pin.value())+ " ,RF3_pin " + str(RF3_pin.value())+ " ,RF4_pin " + str(RF4_pin.value())
            foo [3] = "Hbridge1 : " + str(H_bridge_1.value())  +  "Hbridge2 : " + str(H_bridge_2.value())
            print_custom(foo)
        if (data[2] ==  "ALL"):
            foo [0] = "=====variables====="
            foo [1] = "Current position = " + str(encoder_value)
            foo [2] = "Target position = " + str(setpoint_value)
            foo [3] = "Homeing : " + str(homeing) + " ,Movedir : " + str(movedir) + " ,HWmovedir : " + str(hardware_movedir) + " ,Stop : " + str(stop) + " ,HW_stop : " + str(HW_stop)
            foo [4] = "=====pins====="
            foo [5] = "LOAD1 : " + str(LOAD1_pin.value()) +  " ,LOAD2 : " + str(LOAD2_pin.value()) + " ,ENC_A : " + str(ENC_A.value()) + " ,ENC_B : " + str(ENC_B.value())
            foo [6] = "Homing_pin : " + str(Homing_pin.value())  + " ,Limit_pin : " + str(Limit_pin.value())
            foo [7] = "RF1_pin " + str(RF1_pin.value()) + " ,RF2_pin " + str(RF2_pin.value())+ " ,RF3_pin " + str(RF3_pin.value())+ " ,RF4_pin " + str(RF4_pin.value())
            foo [8] = "Hbridge1 : " + str(H_bridge_1.value())  +  "Hbridge2 : " + str(H_bridge_2.value())
            print_custom(foo)
        
    

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
        print_custom("to be implemented")
    elif (splitdata[0] == "ELEVATION" or splitdata[0] == "EL"):
        Elevation_command_handler(splitdata)
    elif (splitdata[0] == "EXPANTION"):
        print_custom("to be implemented")
        
    update_elevation_stage_direction()
    
    
    
def update_elevation_stage_direction():
    global stop
    global movedir
    global encoder_value
    global setpoint_value
    global HW_stop
    global homeing

    #Default tracking mode
    if encoder_value > setpoint_value:
            movedir = 1
    elif encoder_value < setpoint_value:
            movedir = -1
    else:
            movedir = 0
    #Homing mode
    if homeing == 1:
        movedir = 1
    
        
    #Stopchecks
    if stop == 1:
        movedir = 0
    if HW_stop == -1 and movedir == 1:
        movedir = 0
    if HW_stop ==  1 and movedir ==  -1:
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
    global HW_stop
    global stop
    global homeing
    homing_pin_polarity = 1  #This state indicates that the switch is ACTIVE / has been reached / pressed down / in position
    limit_pin_polarity  = 1  #This state indicates that the switch is ACTIVE / has been reached / pressed down / in position
    
    if (not Homing_pin.value() == homing_pin_polarity) and HW_stop ==  -1:
        HW_stop = 0
    if (not Limit_pin.value() == homing_pin_polarity ) and HW_stop ==  1:
        HW_stop = 0
    if Limit_pin.value() == limit_pin_polarity:
        HW_stop = 1
    if Homing_pin.value() == homing_pin_polarity:
        homeing = 0
        HW_stop = -1
    if Homing_pin.value() == homing_pin_polarity and Limit_pin.value() == limit_pin_polarity:
        foo = []
        foo[0] = "ERROR both limit switches appear to have triggered at the same time"
        foo[1] = "ERROR I have pulled the E-stop, please reset before resuming operation"
        print_custom(foo)
        stop = 1


def print_custom(printdata):
    # This function takes a array of stings as input and prints it
    # A singular array works aswell
    length = 0
    length_str = ""
    try:
        if type(printdata) == type("foo"):
            # if the input is a string
            length = len(printdata) + 5 # the five extra chars are the length header and the carrige return
            if length < 9: # I deem printF as black magic and refuse to use it
                length_str = "00" + str(length)
            elif length < 99:
                length_str = "0" + str(length)
                
            print(length_str +  " " + printdata, end="\n\r")
        else:
           # if the inputdata is an array
            for st in printdata:
                length = length + len(st)
            length = length + 5
            if length < 9: # I deem printF as black magic and refuse to use it
                length_str = "00" + str(length)
            elif length < 99:
                length_str = "0" + str(length)
            print(length_str, end=" ") #Print witout newline, but with explicit space
            for st in printdata:
                if st == printdata[-1]:
                    print(st, end="\n\r")
                else:
                    print(st, end="\n")
    except Exception as e:
        print("035 ERROR in customprint function\r")

#enable IRQs
ENC_A.irq(trigger=ENC_A.IRQ_FALLING, handler=Encoder_callback)
Homing_pin.irq(trigger=Homing_pin.IRQ_RISING, handler=homing_callback)
Limit_pin.irq(trigger=Limit_pin.IRQ_RISING, handler=limit_callback)
#Infinite loop of the program
print_custom ("booted the MCU")
while True:
    update_stops()
    poll_results = poll_obj.poll(10)
    if poll_results:
        data = sys.stdin.readline().strip()
        if data:
            print_custom(["received data: ", data])
            command_interpreter(data)
    




