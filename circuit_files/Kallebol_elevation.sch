EESchema Schematic File Version 4
LIBS:Kallebol_elevation-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L PIC:PIC16F874-PLCC44 U3
U 1 1 60B64C12
P 7650 3200
F 0 "U3" H 7650 4781 50  0000 C CNN
F 1 "PIC16F874-PLCC44" H 7650 4690 50  0000 C CNN
F 2 "Package_LCC:PLCC-44" H 7650 3200 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/30292C.pdf" H 7650 3200 50  0001 C CNN
	1    7650 3200
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0101
U 1 1 60B65979
P 7650 1800
F 0 "#PWR0101" H 7650 1650 50  0001 C CNN
F 1 "+5V" H 7665 1973 50  0000 C CNN
F 2 "" H 7650 1800 50  0001 C CNN
F 3 "" H 7650 1800 50  0001 C CNN
	1    7650 1800
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0102
U 1 1 60B66321
P 7750 1800
F 0 "#PWR0102" H 7750 1650 50  0001 C CNN
F 1 "+5V" H 7765 1973 50  0000 C CNN
F 2 "" H 7750 1800 50  0001 C CNN
F 3 "" H 7750 1800 50  0001 C CNN
	1    7750 1800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 60B66447
P 7650 4700
F 0 "#PWR0103" H 7650 4450 50  0001 C CNN
F 1 "GND" H 7655 4527 50  0000 C CNN
F 2 "" H 7650 4700 50  0001 C CNN
F 3 "" H 7650 4700 50  0001 C CNN
	1    7650 4700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0104
U 1 1 60B66A5D
P 7750 4700
F 0 "#PWR0104" H 7750 4450 50  0001 C CNN
F 1 "GND" H 7755 4527 50  0000 C CNN
F 2 "" H 7750 4700 50  0001 C CNN
F 3 "" H 7750 4700 50  0001 C CNN
	1    7750 4700
	1    0    0    -1  
$EndComp
$Comp
L Device:Crystal_Small Y1
U 1 1 60B66EF2
P 6350 2500
F 0 "Y1" V 6396 2412 50  0000 R CNN
F 1 "Crystal_Small" V 6305 2412 50  0000 R CNN
F 2 "Crystal:Crystal_HC18-U_Vertical" H 6350 2500 50  0001 C CNN
F 3 "~" H 6350 2500 50  0001 C CNN
	1    6350 2500
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6350 2400 6850 2400
Wire Wire Line
	6850 2600 6350 2600
$Comp
L Device:C_Small C2
U 1 1 60B67D76
P 6150 2600
F 0 "C2" V 5921 2600 50  0000 C CNN
F 1 "22p" V 6012 2600 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 6150 2600 50  0001 C CNN
F 3 "~" H 6150 2600 50  0001 C CNN
	1    6150 2600
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C1
U 1 1 60B686A6
P 6150 2400
F 0 "C1" V 5921 2400 50  0000 C CNN
F 1 "22p" V 6012 2400 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 6150 2400 50  0001 C CNN
F 3 "~" H 6150 2400 50  0001 C CNN
	1    6150 2400
	0    1    1    0   
$EndComp
Wire Wire Line
	6250 2600 6350 2600
Connection ~ 6350 2600
Wire Wire Line
	6250 2400 6350 2400
Connection ~ 6350 2400
$Comp
L power:GND #PWR0105
U 1 1 60B68E5C
P 6050 2600
F 0 "#PWR0105" H 6050 2350 50  0001 C CNN
F 1 "GND" H 6055 2427 50  0000 C CNN
F 2 "" H 6050 2600 50  0001 C CNN
F 3 "" H 6050 2600 50  0001 C CNN
	1    6050 2600
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0106
U 1 1 60B6912E
P 6050 2400
F 0 "#PWR0106" H 6050 2150 50  0001 C CNN
F 1 "GND" H 6055 2227 50  0000 C CNN
F 2 "" H 6050 2400 50  0001 C CNN
F 3 "" H 6050 2400 50  0001 C CNN
	1    6050 2400
	0    1    1    0   
$EndComp
$Comp
L Connector:Conn_01x06_Male J6
U 1 1 60B6941D
P 9650 1650
F 0 "J6" V 9712 1894 50  0000 L CNN
F 1 "Programming header" V 9803 1894 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x06_P2.54mm_Vertical" H 9650 1650 50  0001 C CNN
F 3 "~" H 9650 1650 50  0001 C CNN
	1    9650 1650
	0    1    1    0   
$EndComp
Text GLabel 9850 1850 3    50   Input ~ 0
MCLR
Text GLabel 9550 1850 3    50   Input ~ 0
PGD
Text GLabel 9450 1850 3    50   Input ~ 0
PGC
$Comp
L power:+5V #PWR0107
U 1 1 60B6AE79
P 9750 1850
F 0 "#PWR0107" H 9750 1700 50  0001 C CNN
F 1 "+5V" H 9765 2023 50  0000 C CNN
F 2 "" H 9750 1850 50  0001 C CNN
F 3 "" H 9750 1850 50  0001 C CNN
	1    9750 1850
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR0108
U 1 1 60B6AF84
P 9650 1850
F 0 "#PWR0108" H 9650 1600 50  0001 C CNN
F 1 "GND" H 9655 1677 50  0000 C CNN
F 2 "" H 9650 1850 50  0001 C CNN
F 3 "" H 9650 1850 50  0001 C CNN
	1    9650 1850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 60B6B49F
P 6700 2100
F 0 "R2" V 6493 2100 50  0000 C CNN
F 1 "10k" V 6584 2100 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 6630 2100 50  0001 C CNN
F 3 "~" H 6700 2100 50  0001 C CNN
	1    6700 2100
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR0109
U 1 1 60B6BCC9
P 6550 2100
F 0 "#PWR0109" H 6550 1950 50  0001 C CNN
F 1 "+5V" V 6565 2228 50  0000 L CNN
F 2 "" H 6550 2100 50  0001 C CNN
F 3 "" H 6550 2100 50  0001 C CNN
	1    6550 2100
	0    -1   -1   0   
$EndComp
Text GLabel 6850 2100 1    50   Input ~ 0
MCLR
Text GLabel 8700 3400 2    50   Input ~ 0
PGC
Text GLabel 8700 3500 2    50   Input ~ 0
PGD
$Comp
L Connector:Conn_01x03_Male J7
U 1 1 60B6E34F
P 10600 2050
F 0 "J7" V 10662 2194 50  0000 L CNN
F 1 "Encoder" V 10753 2194 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x03_P2.54mm_Vertical" H 10600 2050 50  0001 C CNN
F 3 "~" H 10600 2050 50  0001 C CNN
	1    10600 2050
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR0110
U 1 1 60B6F8B3
P 9200 3150
F 0 "#PWR0110" H 9200 3000 50  0001 C CNN
F 1 "+5V" H 9215 3323 50  0000 C CNN
F 2 "" H 9200 3150 50  0001 C CNN
F 3 "" H 9200 3150 50  0001 C CNN
	1    9200 3150
	-1   0    0    1   
$EndComp
$Comp
L Device:R R4
U 1 1 60B6FD37
P 10000 2900
F 0 "R4" H 10070 2946 50  0000 L CNN
F 1 "10k" H 10070 2855 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 9930 2900 50  0001 C CNN
F 3 "~" H 10000 2900 50  0001 C CNN
	1    10000 2900
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 60B710E7
P 9200 2900
F 0 "R3" H 9270 2946 50  0000 L CNN
F 1 "10k" H 9270 2855 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 9130 2900 50  0001 C CNN
F 3 "~" H 9200 2900 50  0001 C CNN
	1    9200 2900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0111
U 1 1 60B711E9
P 10600 2250
F 0 "#PWR0111" H 10600 2000 50  0001 C CNN
F 1 "GND" H 10605 2077 50  0000 C CNN
F 2 "" H 10600 2250 50  0001 C CNN
F 3 "" H 10600 2250 50  0001 C CNN
	1    10600 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	10500 2300 10500 2250
Wire Wire Line
	10700 2250 10700 2300
Text GLabel 10500 2300 3    50   Input ~ 0
Enc_1
Text GLabel 10700 2300 3    50   Input ~ 0
Enc_2
Text GLabel 10000 2750 1    50   Input ~ 0
Enc_1
Text GLabel 9200 2750 1    50   Input ~ 0
Enc_2
$Comp
L Device:C_Small C5
U 1 1 60B73B14
P 9450 2900
F 0 "C5" H 9542 2946 50  0000 L CNN
F 1 "C_Small" H 9542 2855 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 9450 2900 50  0001 C CNN
F 3 "~" H 9450 2900 50  0001 C CNN
	1    9450 2900
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C6
U 1 1 60B658D8
P 10250 2900
F 0 "C6" H 10342 2946 50  0000 L CNN
F 1 "C_Small" H 10342 2855 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 10250 2900 50  0001 C CNN
F 3 "~" H 10250 2900 50  0001 C CNN
	1    10250 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	9200 3150 9200 3100
Wire Wire Line
	9200 3100 9450 3100
Wire Wire Line
	9450 3100 9450 3000
Connection ~ 9200 3100
Wire Wire Line
	9200 3100 9200 3050
Wire Wire Line
	10000 3050 10000 3100
Wire Wire Line
	10000 3100 10250 3100
Wire Wire Line
	10250 3100 10250 3000
Connection ~ 10000 3100
Wire Wire Line
	10000 3100 10000 3150
Wire Wire Line
	10250 2800 10250 2750
Wire Wire Line
	10250 2750 10000 2750
Wire Wire Line
	9200 2750 9450 2750
Wire Wire Line
	9450 2750 9450 2800
Text GLabel 8450 2800 2    50   Input ~ 0
Enc_1
Text GLabel 8450 2900 2    50   Input ~ 0
Enc_2
$Comp
L power:GND #PWR0115
U 1 1 60B6BC68
P 3850 4000
F 0 "#PWR0115" H 3850 3750 50  0001 C CNN
F 1 "GND" H 3855 3827 50  0000 C CNN
F 2 "" H 3850 4000 50  0001 C CNN
F 3 "" H 3850 4000 50  0001 C CNN
	1    3850 4000
	1    0    0    -1  
$EndComp
$Comp
L Device:CP_Small C3
U 1 1 60B6BF59
P 3850 3900
F 0 "C3" H 3938 3946 50  0000 L CNN
F 1 "C_power" H 3938 3855 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D10.0mm_P5.00mm" H 3850 3900 50  0001 C CNN
F 3 "~" H 3850 3900 50  0001 C CNN
	1    3850 3900
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR0116
U 1 1 60B6D213
P 3850 3800
F 0 "#PWR0116" H 3850 3650 50  0001 C CNN
F 1 "+12V" H 3865 3973 50  0000 C CNN
F 2 "" H 3850 3800 50  0001 C CNN
F 3 "" H 3850 3800 50  0001 C CNN
	1    3850 3800
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x02 J5
U 1 1 60B6E806
P 8500 950
F 0 "J5" V 8464 762 50  0000 R CNN
F 1 "power_out" V 8373 762 50  0000 R CNN
F 2 "TerminalBlock:TerminalBlock_bornier-2_P5.08mm" H 8500 950 50  0001 C CNN
F 3 "~" H 8500 950 50  0001 C CNN
	1    8500 950 
	0    -1   -1   0   
$EndComp
Text GLabel 8500 1150 3    50   Input ~ 0
P_out1
Text GLabel 8600 1150 3    50   Input ~ 0
P_out2
$Comp
L power:GND #PWR0117
U 1 1 60B6FF32
P 9100 5050
F 0 "#PWR0117" H 9100 4800 50  0001 C CNN
F 1 "GND" H 9105 4877 50  0000 C CNN
F 2 "" H 9100 5050 50  0001 C CNN
F 3 "" H 9100 5050 50  0001 C CNN
	1    9100 5050
	1    0    0    -1  
$EndComp
$Comp
L Device:CP_Small C4
U 1 1 60B6FF38
P 9100 4900
F 0 "C4" H 9188 4946 50  0000 L CNN
F 1 "C_power" H 9188 4855 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D10.0mm_P5.00mm" H 9100 4900 50  0001 C CNN
F 3 "~" H 9100 4900 50  0001 C CNN
	1    9100 4900
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR0118
U 1 1 60B6FF3E
P 9100 4650
F 0 "#PWR0118" H 9100 4500 50  0001 C CNN
F 1 "+12V" H 9115 4823 50  0000 C CNN
F 2 "" H 9100 4650 50  0001 C CNN
F 3 "" H 9100 4650 50  0001 C CNN
	1    9100 4650
	1    0    0    -1  
$EndComp
$Comp
L Regulator_Linear:LM7805_TO220 U4
U 1 1 60B70AD4
P 9750 4750
F 0 "U4" H 9750 4992 50  0000 C CNN
F 1 "LM7805_TO220" H 9750 4901 50  0000 C CNN
F 2 "Package_TO_SOT_THT:TO-220-3_Vertical" H 9750 4975 50  0001 C CIN
F 3 "http://www.fairchildsemi.com/ds/LM/LM7805.pdf" H 9750 4700 50  0001 C CNN
	1    9750 4750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0119
U 1 1 60B74FE3
P 9750 5050
F 0 "#PWR0119" H 9750 4800 50  0001 C CNN
F 1 "GND" H 9755 4877 50  0000 C CNN
F 2 "" H 9750 5050 50  0001 C CNN
F 3 "" H 9750 5050 50  0001 C CNN
	1    9750 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	9100 5050 9100 5000
$Comp
L power:GND #PWR0120
U 1 1 60B785D5
P 10350 5050
F 0 "#PWR0120" H 10350 4800 50  0001 C CNN
F 1 "GND" H 10355 4877 50  0000 C CNN
F 2 "" H 10350 5050 50  0001 C CNN
F 3 "" H 10350 5050 50  0001 C CNN
	1    10350 5050
	1    0    0    -1  
$EndComp
$Comp
L Device:CP_Small C7
U 1 1 60B785DB
P 10350 4900
F 0 "C7" H 10438 4946 50  0000 L CNN
F 1 "C_power" H 10438 4855 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D10.0mm_P5.00mm" H 10350 4900 50  0001 C CNN
F 3 "~" H 10350 4900 50  0001 C CNN
	1    10350 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	10350 5050 10350 5000
Wire Wire Line
	10350 4650 10350 4750
Wire Wire Line
	10050 4750 10350 4750
Connection ~ 10350 4750
Wire Wire Line
	10350 4750 10350 4800
$Comp
L power:+5V #PWR0121
U 1 1 60B79599
P 10350 4650
F 0 "#PWR0121" H 10350 4500 50  0001 C CNN
F 1 "+5V" H 10365 4823 50  0000 C CNN
F 2 "" H 10350 4650 50  0001 C CNN
F 3 "" H 10350 4650 50  0001 C CNN
	1    10350 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	9100 4650 9100 4750
Wire Wire Line
	9100 4750 9450 4750
Connection ~ 9100 4750
Wire Wire Line
	9100 4750 9100 4800
NoConn ~ 9350 1850
$Comp
L PIC:DMC3021LSD U2
U 1 1 60B98260
P 4800 5100
F 0 "U2" H 4895 5175 50  0000 C CNN
F 1 "DMC3021LSD" H 4895 5084 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 4800 5100 50  0001 C CNN
F 3 "" H 4800 5100 50  0001 C CNN
	1    4800 5100
	1    0    0    -1  
$EndComp
$Comp
L PIC:DMC3021LSD U1
U 1 1 60B9BAF1
P 3050 5100
F 0 "U1" H 3145 5175 50  0000 C CNN
F 1 "DMC3021LSD" H 3145 5084 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 3050 5100 50  0001 C CNN
F 3 "" H 3050 5100 50  0001 C CNN
	1    3050 5100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0122
U 1 1 60BA1293
P 4350 5350
F 0 "#PWR0122" H 4350 5100 50  0001 C CNN
F 1 "GND" H 4355 5177 50  0000 C CNN
F 2 "" H 4350 5350 50  0001 C CNN
F 3 "" H 4350 5350 50  0001 C CNN
	1    4350 5350
	1    0    0    -1  
$EndComp
Wire Wire Line
	4350 5350 4500 5350
Text GLabel 5350 5600 2    50   Input ~ 0
P_out2
Text GLabel 3600 5600 2    50   Input ~ 0
P_out1
Wire Wire Line
	3550 5400 3600 5400
Wire Wire Line
	3600 5400 3600 5300
Wire Wire Line
	3550 5300 3600 5300
Wire Wire Line
	5300 5300 5350 5300
Wire Wire Line
	5300 5400 5350 5400
Wire Wire Line
	5350 5400 5350 5300
$Comp
L power:GND #PWR0123
U 1 1 60BA54D2
P 2600 5350
F 0 "#PWR0123" H 2600 5100 50  0001 C CNN
F 1 "GND" H 2605 5177 50  0000 C CNN
F 2 "" H 2600 5350 50  0001 C CNN
F 3 "" H 2600 5350 50  0001 C CNN
	1    2600 5350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2600 5350 2750 5350
Wire Wire Line
	3550 5800 3600 5800
Wire Wire Line
	3600 5800 3600 5900
Wire Wire Line
	3600 5900 3550 5900
Connection ~ 3600 5400
Wire Wire Line
	3600 5400 3600 5800
Connection ~ 3600 5800
Wire Wire Line
	5300 5900 5350 5900
Wire Wire Line
	5350 5900 5350 5800
Wire Wire Line
	5350 5800 5300 5800
Wire Wire Line
	5350 5800 5350 5400
Connection ~ 5350 5800
Connection ~ 5350 5400
Wire Wire Line
	2750 5800 2750 5550
Wire Wire Line
	4500 5800 4500 5550
$Comp
L power:+12V #PWR0124
U 1 1 60BBEC67
P 4100 5900
F 0 "#PWR0124" H 4100 5750 50  0001 C CNN
F 1 "+12V" V 4115 6028 50  0000 L CNN
F 2 "" H 4100 5900 50  0001 C CNN
F 3 "" H 4100 5900 50  0001 C CNN
	1    4100 5900
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 6000 4500 6000
Wire Wire Line
	4100 5900 4100 6000
$Comp
L power:+12V #PWR0125
U 1 1 60BC43FB
P 2350 5900
F 0 "#PWR0125" H 2350 5750 50  0001 C CNN
F 1 "+12V" V 2365 6028 50  0000 L CNN
F 2 "" H 2350 5900 50  0001 C CNN
F 3 "" H 2350 5900 50  0001 C CNN
	1    2350 5900
	1    0    0    -1  
$EndComp
Wire Wire Line
	2350 6000 2750 6000
Wire Wire Line
	2350 5900 2350 6000
Text GLabel 2750 5700 0    50   Input ~ 0
Hb1
Text GLabel 4500 5700 0    50   Input ~ 0
Hb2
Wire Wire Line
	8700 3500 8450 3500
Wire Wire Line
	8450 3400 8700 3400
Text GLabel 8450 4400 2    50   Input ~ 0
UART_RX
Text GLabel 8450 4300 2    50   Input ~ 0
UART_TX
Text GLabel 6450 1150 3    50   Input ~ 0
UART_RX
Text GLabel 6550 1150 3    50   Input ~ 0
UART_TX
$Comp
L Connector:Conn_01x02_Female J3
U 1 1 60BD3745
P 6450 950
F 0 "J3" V 6388 762 50  0000 R CNN
F 1 "UART_conn" V 6297 762 50  0000 R CNN
F 2 "TerminalBlock:TerminalBlock_bornier-2_P5.08mm" H 6450 950 50  0001 C CNN
F 3 "~" H 6450 950 50  0001 C CNN
	1    6450 950 
	0    -1   -1   0   
$EndComp
Text Notes 5500 800  0    50   ~ 0
TX is not intended for use but is connected for use\n
$Comp
L Connector:Conn_01x02_Female J2
U 1 1 60BE686B
P 5650 950
F 0 "J2" V 5588 762 50  0000 R CNN
F 1 "Home_switch" V 5497 762 50  0000 R CNN
F 2 "TerminalBlock:TerminalBlock_bornier-2_P5.08mm" H 5650 950 50  0001 C CNN
F 3 "~" H 5650 950 50  0001 C CNN
	1    5650 950 
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR0126
U 1 1 60BEA14C
P 5750 1150
F 0 "#PWR0126" H 5750 1000 50  0001 C CNN
F 1 "+5V" H 5765 1323 50  0000 C CNN
F 2 "" H 5750 1150 50  0001 C CNN
F 3 "" H 5750 1150 50  0001 C CNN
	1    5750 1150
	-1   0    0    1   
$EndComp
$Comp
L Device:R R1
U 1 1 60BEB79C
P 5650 1500
F 0 "R1" V 5443 1500 50  0000 C CNN
F 1 "10k" V 5534 1500 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 5580 1500 50  0001 C CNN
F 3 "~" H 5650 1500 50  0001 C CNN
	1    5650 1500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0127
U 1 1 60BEE2DE
P 5650 1650
F 0 "#PWR0127" H 5650 1400 50  0001 C CNN
F 1 "GND" H 5655 1477 50  0000 C CNN
F 2 "" H 5650 1650 50  0001 C CNN
F 3 "" H 5650 1650 50  0001 C CNN
	1    5650 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	5650 1350 5650 1150
Text GLabel 5650 1200 0    50   Input ~ 0
Home
Text GLabel 6600 2900 0    50   Input ~ 0
Home
$Comp
L power:+5V #PWR0128
U 1 1 60C04321
P 10750 3450
F 0 "#PWR0128" H 10750 3300 50  0001 C CNN
F 1 "+5V" H 10765 3623 50  0000 C CNN
F 2 "" H 10750 3450 50  0001 C CNN
F 3 "" H 10750 3450 50  0001 C CNN
	1    10750 3450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R6
U 1 1 60C04327
P 10750 3900
F 0 "R6" V 10543 3900 50  0000 C CNN
F 1 "550" V 10634 3900 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 10680 3900 50  0001 C CNN
F 3 "~" H 10750 3900 50  0001 C CNN
	1    10750 3900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0129
U 1 1 60C0432D
P 10750 4050
F 0 "#PWR0129" H 10750 3800 50  0001 C CNN
F 1 "GND" H 10755 3877 50  0000 C CNN
F 2 "" H 10750 4050 50  0001 C CNN
F 3 "" H 10750 4050 50  0001 C CNN
	1    10750 4050
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D2
U 1 1 60C0A6B7
P 10750 3600
F 0 "D2" V 10789 3483 50  0000 R CNN
F 1 "LED" V 10698 3483 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 10750 3600 50  0001 C CNN
F 3 "~" H 10750 3600 50  0001 C CNN
	1    10750 3600
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R5
U 1 1 60C1A693
P 6150 4450
F 0 "R5" V 5943 4450 50  0000 C CNN
F 1 "550" V 6034 4450 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 6080 4450 50  0001 C CNN
F 3 "~" H 6150 4450 50  0001 C CNN
	1    6150 4450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0130
U 1 1 60C1A699
P 6150 4600
F 0 "#PWR0130" H 6150 4350 50  0001 C CNN
F 1 "GND" H 6155 4427 50  0000 C CNN
F 2 "" H 6150 4600 50  0001 C CNN
F 3 "" H 6150 4600 50  0001 C CNN
	1    6150 4600
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D1
U 1 1 60C1A69F
P 6150 4150
F 0 "D1" V 6189 4033 50  0000 R CNN
F 1 "LED" V 6098 4033 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 6150 4150 50  0001 C CNN
F 3 "~" H 6150 4150 50  0001 C CNN
	1    6150 4150
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0131
U 1 1 60C35B33
P 3250 4550
F 0 "#PWR0131" H 3250 4300 50  0001 C CNN
F 1 "GND" H 3255 4377 50  0000 C CNN
F 2 "" H 3250 4550 50  0001 C CNN
F 3 "" H 3250 4550 50  0001 C CNN
	1    3250 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	3250 3100 3250 2850
Connection ~ 3350 3350
Wire Wire Line
	3350 3350 3350 3150
Wire Wire Line
	3350 3350 3350 3450
Wire Wire Line
	3250 3350 3350 3350
Wire Wire Line
	3250 3450 3250 3350
$Comp
L Device:R R7
U 1 1 60C35B2D
P 3250 4400
F 0 "R7" V 3043 4400 50  0000 C CNN
F 1 "30k" V 3134 4400 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 3180 4400 50  0001 C CNN
F 3 "~" H 3250 4400 50  0001 C CNN
	1    3250 4400
	1    0    0    -1  
$EndComp
$Comp
L PIC:DMC3021LSD U5
U 1 1 60C2E3E3
P 2550 3950
F 0 "U5" H 2645 4025 50  0000 C CNN
F 1 "DMC3021LSD" H 2645 3934 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 2550 3950 50  0001 C CNN
F 3 "" H 2550 3950 50  0001 C CNN
	1    2550 3950
	0    -1   -1   0   
$EndComp
$Comp
L Device:Fuse F1
U 1 1 60C20635
P 3350 3000
F 0 "F1" H 3410 3046 50  0000 L CNN
F 1 "Fuse 3A" H 3410 2955 50  0000 L CNN
F 2 "Xp_motor:Fuse_holder" V 3280 3000 50  0001 C CNN
F 3 "~" H 3350 3000 50  0001 C CNN
	1    3350 3000
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR0114
U 1 1 60B6AECD
P 3450 4250
F 0 "#PWR0114" H 3450 4100 50  0001 C CNN
F 1 "+12V" H 3465 4423 50  0000 C CNN
F 2 "" H 3450 4250 50  0001 C CNN
F 3 "" H 3450 4250 50  0001 C CNN
	1    3450 4250
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR0113
U 1 1 60B6ACC3
P 3250 3100
F 0 "#PWR0113" H 3250 2850 50  0001 C CNN
F 1 "GND" H 3255 2927 50  0000 C CNN
F 2 "" H 3250 3100 50  0001 C CNN
F 3 "" H 3250 3100 50  0001 C CNN
	1    3250 3100
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x02 J4
U 1 1 60B6804F
P 3250 2650
F 0 "J4" V 3214 2462 50  0000 R CNN
F 1 "Power in" V 3123 2462 50  0000 R CNN
F 2 "TerminalBlock:TerminalBlock_bornier-2_P5.08mm" H 3250 2650 50  0001 C CNN
F 3 "~" H 3250 2650 50  0001 C CNN
	1    3250 2650
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R8
U 1 1 60C4DCCD
P 6450 4450
F 0 "R8" V 6243 4450 50  0000 C CNN
F 1 "550" V 6334 4450 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 6380 4450 50  0001 C CNN
F 3 "~" H 6450 4450 50  0001 C CNN
	1    6450 4450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0132
U 1 1 60C4DCD3
P 6450 4600
F 0 "#PWR0132" H 6450 4350 50  0001 C CNN
F 1 "GND" H 6455 4427 50  0000 C CNN
F 2 "" H 6450 4600 50  0001 C CNN
F 3 "" H 6450 4600 50  0001 C CNN
	1    6450 4600
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D3
U 1 1 60C4DCD9
P 6450 4150
F 0 "D3" V 6489 4033 50  0000 R CNN
F 1 "LED" V 6398 4033 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 6450 4150 50  0001 C CNN
F 3 "~" H 6450 4150 50  0001 C CNN
	1    6450 4150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6450 4000 6450 3800
Wire Wire Line
	6450 3800 6850 3800
Wire Wire Line
	6850 3700 6150 3700
Wire Wire Line
	6150 3700 6150 4000
$Comp
L Device:C_Small C8
U 1 1 60C5C91A
P 10850 4900
F 0 "C8" H 10942 4946 50  0000 L CNN
F 1 "C_Small" H 10942 4855 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 10850 4900 50  0001 C CNN
F 3 "~" H 10850 4900 50  0001 C CNN
	1    10850 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	10350 4750 10850 4750
Wire Wire Line
	10850 4750 10850 4800
$Comp
L power:GND #PWR0133
U 1 1 60C62E93
P 10850 5000
F 0 "#PWR0133" H 10850 4750 50  0001 C CNN
F 1 "GND" H 10855 4827 50  0000 C CNN
F 2 "" H 10850 5000 50  0001 C CNN
F 3 "" H 10850 5000 50  0001 C CNN
	1    10850 5000
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H2
U 1 1 60C68A81
P 1550 1150
F 0 "H2" H 1650 1199 50  0000 L CNN
F 1 "MountingHole_Pad_M4" H 1650 1108 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4_Pad" H 1550 1150 50  0001 C CNN
F 3 "~" H 1550 1150 50  0001 C CNN
	1    1550 1150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0134
U 1 1 60C69619
P 1550 1250
F 0 "#PWR0134" H 1550 1000 50  0001 C CNN
F 1 "GND" H 1555 1077 50  0000 C CNN
F 2 "" H 1550 1250 50  0001 C CNN
F 3 "" H 1550 1250 50  0001 C CNN
	1    1550 1250
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H3
U 1 1 60C6BCF5
P 1550 1600
F 0 "H3" H 1650 1649 50  0000 L CNN
F 1 "MountingHole_Pad_M4" H 1650 1558 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4_Pad" H 1550 1600 50  0001 C CNN
F 3 "~" H 1550 1600 50  0001 C CNN
	1    1550 1600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0135
U 1 1 60C6BCFB
P 1550 1700
F 0 "#PWR0135" H 1550 1450 50  0001 C CNN
F 1 "GND" H 1555 1527 50  0000 C CNN
F 2 "" H 1550 1700 50  0001 C CNN
F 3 "" H 1550 1700 50  0001 C CNN
	1    1550 1700
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H4
U 1 1 60C6D971
P 1550 2050
F 0 "H4" H 1650 2099 50  0000 L CNN
F 1 "MountingHole_Pad_M4" H 1650 2008 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4_Pad" H 1550 2050 50  0001 C CNN
F 3 "~" H 1550 2050 50  0001 C CNN
	1    1550 2050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0136
U 1 1 60C6D977
P 1550 2150
F 0 "#PWR0136" H 1550 1900 50  0001 C CNN
F 1 "GND" H 1555 1977 50  0000 C CNN
F 2 "" H 1550 2150 50  0001 C CNN
F 3 "" H 1550 2150 50  0001 C CNN
	1    1550 2150
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H1
U 1 1 60C6F809
P 1550 700
F 0 "H1" H 1650 749 50  0000 L CNN
F 1 "MountingHole_Pad_M4" H 1650 658 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4_Pad" H 1550 700 50  0001 C CNN
F 3 "~" H 1550 700 50  0001 C CNN
	1    1550 700 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0137
U 1 1 60C6F80F
P 1550 800
F 0 "#PWR0137" H 1550 550 50  0001 C CNN
F 1 "GND" H 1555 627 50  0000 C CNN
F 2 "" H 1550 800 50  0001 C CNN
F 3 "" H 1550 800 50  0001 C CNN
	1    1550 800 
	1    0    0    -1  
$EndComp
Text GLabel 6600 3100 0    50   Input ~ 0
Hb1
Text GLabel 6600 3000 0    50   Input ~ 0
Hb2
Wire Wire Line
	6850 2900 6600 2900
Wire Wire Line
	6600 2800 6850 2800
Wire Wire Line
	6600 3000 6850 3000
Wire Wire Line
	6850 3100 6600 3100
Text GLabel 6600 2800 0    50   Input ~ 0
Limit
Text GLabel 4800 1150 0    50   Input ~ 0
Limit
$Comp
L Connector:Conn_01x02_Female J1
U 1 1 60B7E951
P 4800 950
F 0 "J1" V 4738 762 50  0000 R CNN
F 1 "Limit_switch" V 4647 762 50  0000 R CNN
F 2 "TerminalBlock:TerminalBlock_bornier-2_P5.08mm" H 4800 950 50  0001 C CNN
F 3 "~" H 4800 950 50  0001 C CNN
	1    4800 950 
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR0138
U 1 1 60B7E957
P 4900 1150
F 0 "#PWR0138" H 4900 1000 50  0001 C CNN
F 1 "+5V" H 4915 1323 50  0000 C CNN
F 2 "" H 4900 1150 50  0001 C CNN
F 3 "" H 4900 1150 50  0001 C CNN
	1    4900 1150
	-1   0    0    1   
$EndComp
$Comp
L Device:R R9
U 1 1 60B7E95D
P 4800 1500
F 0 "R9" V 4593 1500 50  0000 C CNN
F 1 "10k" V 4684 1500 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 4730 1500 50  0001 C CNN
F 3 "~" H 4800 1500 50  0001 C CNN
	1    4800 1500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0139
U 1 1 60B7E963
P 4800 1650
F 0 "#PWR0139" H 4800 1400 50  0001 C CNN
F 1 "GND" H 4805 1477 50  0000 C CNN
F 2 "" H 4800 1650 50  0001 C CNN
F 3 "" H 4800 1650 50  0001 C CNN
	1    4800 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 1350 4800 1150
$Comp
L power:+5V #PWR0112
U 1 1 60B88718
P 10000 3150
F 0 "#PWR0112" H 10000 3000 50  0001 C CNN
F 1 "+5V" H 10015 3323 50  0000 C CNN
F 2 "" H 10000 3150 50  0001 C CNN
F 3 "" H 10000 3150 50  0001 C CNN
	1    10000 3150
	-1   0    0    1   
$EndComp
$EndSCHEMATC
