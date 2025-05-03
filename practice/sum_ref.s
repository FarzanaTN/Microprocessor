;sum of two numbers using reference in function call

	AREA dec, DATA, READWRITE
num1 DCD 2 ;first number
num2 DCD 3 ;second number
result DCD 0 ;result variable
	AREA main_prog, CODE, READONLY
	ENTRY
	EXPORT main
		
sum
	POP {R3,R4,R5}
    LDR R3, [R3] ;load arg1 from memory
    LDR R4, [R4] ;load arg2 from memory
    ADD R3, R3, R4 ;add arg1 and arg2
    STR R3, [R5] ;store the result in memory
	BX lr
    ENDP
	
main
	LDR R0, =num1 ;address of first number
	LDR R1, =num2 ;address of second number
	LDR R2, =result ;address of result variable
	PUSH {R0,R1,R2}
	BL sum ;call the sum function
	LDR R2,[r2]
	B stop ;end of program
	

	
stop B stop ;end of code
	END