import tkinter as tk
from tkinter import ttk
from tkinter import *
from socket import error
import socket

PORT = 1337  # The port used by the server'
numsteps = 1020  # maximum amount of movement, this is when elevation is at its minimum

root = Tk()
statustext = StringVar()
lastpos = StringVar()


# this is the function called when the button is clicked
def gototrg():
    try:
        newpos = str(int(elevation_target.get()))
        print('I will goto position ' + newpos)
        statustext.set("Moving to position: " + newpos + "\napprox: " + str(convert_pos_to_ang(int(newpos))) + " deg")
        sendpacket(goto_pos(int(newpos)))
        lastpos.set("lastpos = " + newpos + "\napprox: " + str(convert_pos_to_ang(int(newpos))) + " deg")
    except ValueError as e:
        print(e)
        statustext.set("invalid target to move to\n" + str(e))
    except ConnectionRefusedError as e:
        print(e)
        statustext.set("failed to connect to host\n" + str(e))
    except Exception as e:
        print(e)
        statustext.set(str(e))


#Translates a integer value to
def goto_pos(target):
    if target < 0 or target > numsteps:
        raise ValueError
        return -1
    # 132 == 0x84 == Goto a position
    datapacket = bytearray(b'\x84')
    datapacket.append(int(target/256))
    datapacket.append(target % 256)
    print(datapacket)
    return datapacket


def sendpacket(data):
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.connect((IPaddr.get(), PORT))
        s.sendall(data)

def convert_pos_to_ang(pos):
    maxang = 75 #deg, 90deg is straight up
    minang = 0  #deg, 0 is horizontal
    ang_per_step = (maxang-minang)/numsteps
    return maxang - (ang_per_step * pos)

# This is the section of code which creates the main window
root.geometry('300x300')
root.configure(background='#F0F8FF')
root.title('kallebol elevation controll')

IPaddr = Entry(root)
IPaddr.place(x=10, y=10)

elevation_target = Entry(root)
elevation_target.place(x=10, y=100)

Button(root, text='go to target', bg='#F0F8FF', font=('arial', 12, 'normal'), command=gototrg).place(x=185, y=100)

Label(root, text='Host IP adress', bg='#F0F8FF', font=('arial', 12, 'normal')).place(x=10, y=30)
Label(root, text='Target extention ', bg='#F0F8FF', font=('arial', 12, 'normal')).place(x=10, y=130)
Label(root, textvariable=statustext, bg='#F0F8FF', font=('arial', 12, 'normal')).place(x=10, y=230)
Label(root, textvariable=lastpos, bg='#F0F8FF', font=('arial', 12, 'normal')).place(x=185, y=170)
statustext.set(" ")
lastpos.set("Lastpos = N/A")

root.mainloop()
