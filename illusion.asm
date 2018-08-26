ORG 00h
	BACK:
	MOV A, #55h
	MOV P1, A
	ACALL DELAY
	MOV A, #0AAh
	MOV P1, A
	ACALL DELAY
	SJMP BACK
	
	delay: 
	mov r5, #50
del1: 	mov r6, #50
del2: 	mov r7, #50
del3: 	djnz r7, del3
	djnz r6, del2
	djnz r5, del1
ret
END
		
	