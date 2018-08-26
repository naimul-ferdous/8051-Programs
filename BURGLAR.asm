ORG 00H
;; PREP
	MOV DPTR, #DOORCODE
	MOV P3, #0FFH		; port#3 as input
	MOV P1, #01111111B	; blank the display and no alarm
READP3:
	MOV A, P3
	SETB ACC.6		; P3.6 physically not present
	CJNE A, #0FFH, DETEKT	; door open ? 
	SJMP READP3
DETEKT:		
	CPL A			; compliment door access code
	MOV R0, #00H		; RO as counter
ROTATE:
	RRC A
	JC DISPLAY
	INC R0
	SJMP ROTATE
DISPLAY:
	MOV A, R0
	MOVC A, @A+DPTR

	MOV P1, A
	SETB P1.7		; turn on the alarm
AGAIN:	SJMP AGAIN
DOORCODE:
	DB '0','1','2','3','4','5','6','7'
END
