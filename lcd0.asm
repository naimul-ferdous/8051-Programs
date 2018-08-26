; P1.0-P1.7=D0-D7, P3.0=RS, P3.1=R/W, P3.2=E
ORG 0
MOV DPTR,#MYCOM
C1: 
CLR A
MOVC A,@A+DPTR
ACALL COMNWRT 	;call command subroutine
ACALL DELAY 	;give LCD some time
INC DPTR
JZ SEND_DAT
SJMP C1

SEND_DAT:
MOV DPTR,#MYDATA
D1: CLR A
MOVC A,@A+DPTR
ACALL DATAWRT 	;call command subroutine
ACALL DELAY 	;give LCD some time
INC DPTR
JZ AGAIN
SJMP D1

AGAIN: SJMP AGAIN 	;stay here 

COMNWRT: 		;send command to LCD
MOV P1,A 		;copy reg A to P1
CLR P3.0 		;RS=0 for command
CLR P3.1 		;R/W=0 for write
SETB P3.2 		;E=1 for high pulse
ACALL DELAY 	;give LCD some time
CLR P3.2 		;E=0 for H-to-L pulse
RET

DATAWRT: 		;write data to LCD
MOV P1,A 		;copy reg A to port 1
SETB P3.0 		;RS=1 for data
CLR P3.1 		;R/W=0 for write
SETB P3.2 		;E=1 for high pulse
ACALL DELAY 	;give LCD some time
CLR P3.2 		;E=0 for H-to-L pulse
RET

DELAY: MOV R3,#250 	;50 or higher 
HERE2: MOV R4,#255 	;R4 = 255
HERE: DJNZ R4,HERE 	;stay until R4 becomes 0
DJNZ R3,HERE2
RET

ORG 300H
MYCOM: DB 38H,0EH,01,06,84H,0 
; commands and null
MYDATA: DB "I LOVE YOU",0
END  
