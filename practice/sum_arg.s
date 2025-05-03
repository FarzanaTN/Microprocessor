    AREA p_two, CODE, READONLY
    ENTRY
    EXPORT main
        
sum_function PROC ;sum function 
    ; Retrieve arguments from the stack
    POP {r3,r4} ; arg1 arg2

    ; Add the arguments
    ADD r0, r3, r4
    PUSH {r0}

    ; Return the result
    BX lr
	ENDP

main
    ; Initialize arguments
    MOV r1, #3 ; arg1 = 3
    MOV r2, #2 ; arg2 = 2
    
    PUSH {lr} ; Save the return address
    PUSH {r1, r2} ; Push arguments onto the stack
    BL sum_function ; Call the function
    POP {r5} ; Pop result arguments from the stack

    POP {pc} ; Pop the return address into pc
     
    B Stop
Stop B Stop ; Infinite loop to halt the program
	END