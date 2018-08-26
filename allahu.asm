ORG 00h
	START:
	MOV R0, #07h
	MOV DPTR, #TABLE
	
	LOOP:
	MOV A, #00h
	MOVC A, @A+DPTR
	MOV P1, A
	INC DPTR
	ACALL DELAY
	DJNZ R0, LOOP
	SJMP START
	
	DELAY:
	MOV R1, #95h
	DEL1:
	MOV R2, #50h
	DEL2:
	MOV R3, #20h
	DEL3:
	DJNZ R3, DEL3
	DJNZ R2, DEL2
	DJNZ R1, DEL1
	RET
	
	TABLE:
	DB 08h, 47h, 0FFh, 47h, 08h, 89h, 0C1h
	
END