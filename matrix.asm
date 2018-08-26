ORG 00h
	MOV P1, #0FFh

	Starter: 	
	MOV P3,#00111000b
	MOV A, P3
	ANL A, #00111000b
	CJNE A, #00111000b, Starter
	
	KeyCheck: 	
	CALL Delay
 	MOV A, P3
 	ANL A, #00111000b
 	CJNE A, #00111000b, Debonc
	SJMP KeyCheck
	
	Debonc: 	
	CALL Delay
 	MOV A, P3
 	ANL A, #00111000b
 	CJNE A, #00111000b, FindRow
	SJMP KeyCheck
	
	FindRow: 	
	MOV P3, #11111110b
	MOV A, P3
	ANL A, #00111000b
	CJNE A, #00111000b, Row_0
	MOV P3, #11111101b
	MOV A, P3
	ANL A, #00111000b
	CJNE A, #00111000b, Row_1
	MOV P3, #11111011b
	MOV A, P3
	ANL A, #00111000b
	CJNE A, #00111000b, Row_2
	LJMP KeyCheck
	
	Row_0: 
	MOV DPTR, #Row_0_Data
	SJMP Find_Col
	
	Row_1: 
	MOV DPTR, #Row_1_Data
	SJMP Find_Col
	
	Row_2: 
	MOV DPTR, #Row_2_Data
	SJMP Find_Col
	
	Find_Col: 	
	MOV R2, #03
	CLR C
	
	Get_col: 	
	RRC A
	DJNZ R2, Get_col
	
	Find_Main: 	
	RRC A
	JNC Matched
	INC DPTR
	SJMP Find_Main
	
	Matched: 	
	CLR A
	MOVC A, @A+DPTR
	MOV P1, A
	LJMP Starter
	
	Delay: 	MOV R5, #50h
	Del_1: 	MOV R6, #10h
	Del_2:	DJNZ R6, Del_2
	DJNZ R5, Del_1
	RET
	
	Row_0_Data: db 0C0h, 0F9h, 0A4h
	Row_1_Data: db 0B0h, 99h, 92h
	Row_2_Data: db 82h, 0F8h, 80h
END
