;finding max min using recursion
	AREA arr_min, DATA, READWRITE
arr DCD 10, 5, 8, 3, 6, 2, 7 ;example array
arr_size EQU 7 ;size of example array
	
	AREA min_elem, CODE, READONLY
	ENTRY
	EXPORT main
	EXPORT find_min

find_min
	POP {R3, R1}
	CMP R1, #0
	BEQ ret
	LDR R2, [R0], #4
	CMP R2, R3        ; compare current element with minimum value
	MOVLT R3, R2      ; if current element is smaller, update minimum value
	SUBS R1, R1, #1
	PUSH {R3, R1}
	BL find_min
	
ret   
	MOV R0, R3       ; Move the minimum value to R0
	POP {pc}

main
	LDR R0, =arr ;load the address of the array
	LDR R1, =arr_size ;load the size of the array
	MOV R3, #100 ;initializing min element
	PUSH {lr, R3, R1}
	BL find_min ;call the function to find the minimum element
	POP {R1} ; Receive the result in R1
	B stop ;end of program
	
stop B stop ;end of code
	END