
	AREA myData, DATA

COUNT	EQU 10
SUM		EQU 0

	AREA myCode, CODE
		ENTRY
		EXPORT __main
			
__main
	LDR r0, =COUNT
	LDR r1, =SUM
	LDR r2, =1	;r2 stores the initial value of i
	
myLoop
	ADD r1, r2, r1 ; sum = sum + i
	ADD r2, r2, #1 ; i++
	SUBS r4, r0, r2
	
	BNE myLoop
	ADD r1, r2, r1
	
stop	B	stop	;infinite loop
	
	END