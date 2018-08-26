ORG 0H
MOV A,#38H ;init. LCD 2 lines ,5x7 matrix
ACALL COMMAND ;issue command
MOV A,#0EH ;LCD on, cursor on
ACALL COMMAND ;issue command
MOV A,#01H ;clear LCD command
ACALL COMMAND ;issue command
MOV A,#06H ;shift cursor right
ACALL COMMAND ;issue command
MOV A,#86H ;cursor: line 1, pos. 6
ACALL COMMAND ;command subroutine
MOV A,#'N' ;display letter N
ACALL DATA_DISPLAY
MOV A,#'O' ;display letter O
ACALL DATA_DISPLAY
HERE:SJMP HERE ;STAY HERE
COMMAND:
ACALL READY ;is LCD ready?
MOV P1,A ;issue command code
CLR P3.0 ;RS=0 for command
CLR P3.1 ;R/W=0 to write to LCD
SETB P3.2 ;E=1 for H-to-L pulse
CLR P3.2 ;E=0,latch in
RET
DATA_DISPLAY:
ACALL READY ;is LCD ready?
MOV P1,A ;issue data
SETB P3.0 ;RS=1 for data
CLR P3.1 ;R/W =0 to write to LCD
SETB P3.2 ;E=1 for H-to-L pulse
CLR P3.2 ;E=0,latch in
RET
READY:
SETB P1.7 ;make P1.7 input port
CLR P3.0 ;RS=0 access command reg
SETB P3.1 ;R/W=1 read command reg
;read command reg and check busy flag
BACK:SETB P3.2 ;E=1 for H-to-L pulse
CLR P3.2 ;E=0 H-to-L pulse
JB P1.7,BACK ;stay until busy flag=0
RET
END