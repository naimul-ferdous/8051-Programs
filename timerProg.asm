ORG 00h
	
	MOV TMOD, #10h
	
	REPEAT:
	MOV TL1, #00h
	MOV TH1, #0FFh
	CPL P1.5
	SETB TR1
	
	WAIT:
	JNB TF1, WAIT
	CLR TR1
	CLR TF1
	SJMP REPEAT
	
	END