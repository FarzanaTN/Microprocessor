;Write an assembly language program to identify prime numbers from a list of array by calling a function called prime.
	AREA arr_dec, DATA, READWRITE

numbers DCD 7,4,3,5
prm DCD 0,0,0,0
	
	AREA prime_number,CODE,READONLY
	ENTRY
	EXPORT main
prime
	PUSH {R3,R4,R5,R6}
	MOV R4,#2 ;divisor start from 2
	CMP R0,#2
	BLT not_prime
is_prime
	CMP R0,R4 ;check if the R4 is reached the value of R0
	BEQ prime_cnf
	SDIV R5,R0,R4
	MUL R5,R5,R4 
	CMP R0,R5
	BEQ not_prime
	ADDS R4,R4,#1 ; increase R4
	B is_prime
prime_cnf
	POP {R3,R4,R5,R6}
	STR R0,[R3],#4
	BX LR
	ENDP

not_prime
	POP {R3,R4,R5,R6}
	BX LR
	ENDP
main
	LDR R3,=prm
	LDR R4,=numbers
	MOV R5,#4 ;size of array
	MOV R6,#4 ;size of array
loop
	LDR R0,[R4],#4
	BL prime
	SUB R6,R6,#1
	CMP R6,#0
	BNE loop
	
stop B stop ; end of code
	END