ORG 00H
;; PREP
	MOV DPTR, #CACODE
	MOV R1, #31H		; buffer
	MOV R3, #00H		; index
	MOV R2, #05H		; counter

GETBUFER:
	MOV A, R3
	MOVC A, @A+DPTR
	INC R3
	CJNE A, #'$', OVER
	MOV A, #0FFH		; ca code of blank
	MOV R3, #00			; index at 00 offset
OVER:
	MOV @R1, A
	INC R1
	DJNZ R2, GETBUFER

AGAIN:
	MOV R2, #05H		; counter
	MOV R1, #31H		; adjust buffer(30-34h)
	MOV R0, #30H
ADJUST:
	MOV A, @R1
	MOV @R0, A
	INC R0
	INC R1	
	DJNZ R2,ADJUST

	MOV R6, #16		; outmost loop
OUTLOOP1:
	MOV R7, #32		; outer loop
OUTLOOP2:
	MOV B, #01H			; display control code
	MOV R1, #30H		; buffer
	MOV R2, #05H		; counter

DISP:					; inner loop
	MOV A, @R1
	MOV P1, A
	MOV P3, B
	LCALL DELY	
	LCALL DELY
	INC R1
	MOV A, B
	RL A
	MOV B, A
	DJNZ R2, DISP
	DJNZ R7, OUTLOOP2
	DJNZ R6, OUTLOOP1

	MOV R1, #35H		; append buffer

	MOV A, R3
	MOVC A, @A+DPTR
	CJNE A, #'$', OVER1
	MOV A, #0FFH		; ca code of blank
	MOV R3, #0FFh		; index at 00 offset
OVER1:
	MOV @R1, A
	INC R3

	SJMP AGAIN

DELY:
 	 MOV R5, #0FFh
FIV: DJNZ R5, FIV
	 RET

CACODE:
	 DB 0F8h, 92h, 0C0h, 0BFh, 0A4h, 92h, 0C0h, 0B7h,  92h, 0C0h, 0C0h, '$'
END
