; P1.0-P1.7=D0-D7, P3.0=RS, P3.1=R/W, P3.2=E
ORG 00h
; configure LCD
MOV A,#38H ;init. lcd 2 lines, 5x7 matrix
ACALL COMNWRT ;call command subroutine
ACALL DELAY ;give LCD some time
MOV A,#0EH ;display on, cursor on
ACALL COMNWRT ;call command subroutine
ACALL DELAY ;give LCD some time
MOV A,#01 ;clear LCD
ACALL COMNWRT ;call command subroutine
ACALL DELAY ;give LCD some time
MOV A,#06H ;shift cursor right
ACALL COMNWRT ;call command subroutine
ACALL DELAY ;give LCD some time
MOV A,#84H ;cursor at line 1, pos. 4
ACALL COMNWRT ;call command subroutine
ACALL DELAY ;give LCD some time
; send data
MOV A,#'N' ;display letter N
ACALL DATAWRT ;call display subroutine
ACALL DELAY ;give LCD some time
MOV A,#'O' ;display letter O
ACALL DATAWRT ;call display subroutine
AGAIN: SJMP AGAIN ;stay here
COMNWRT: ;send command to LCD
MOV P1,A ;copy reg A to port 1
CLR P3.0 ;RS=0 for command
CLR P3.1 ;R/W=0 for write
SETB P3.2 ;E=1 for high pulse
ACALL DELAY ;give LCD some time
CLR P3.2 ;E=0 for H-to-L pulse
RET
DATAWRT: ;write data to LCD
MOV P1,A ;copy reg A to port 1
SETB P3.0 ;RS=1 for data
CLR P3.1 ;R/W=0 for write
SETB P3.2 ;E=1 for high pulse
ACALL DELAY ;give LCD some time
CLR P3.2 ;E=0 for H-to-L pulse
RET
DELAY: MOV R3,#50 ;50 or higher 
HERE2:
MOV R4,#255 ;R4 = 255
HERE: DJNZ R4,HERE ;stay until R4 becomes 0
DJNZ R3,HERE2
RET
END