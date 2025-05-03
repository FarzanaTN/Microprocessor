    AREA p_two, CODE, READONLY
    ENTRY
    EXPORT main
        
sum_function  
    ; Retrieve arguments from the stack
    POP {r3,r4} ; arg1 arg2
	push{lr}

    ; Add the arguments
    ADD r0, r3, r4
    PUSH {r0}
    BL sub_func
	ENDP
		
sub_func
	POP {r1}
	pop{lr}
	SUB r1,r1,#1
	push{r1}
	BX lr
	
main
    ; Initialize arguments
    MOV r1, #3 ; arg1 = 3
    MOV r2, #2 ; arg2 = 2
     
    PUSH {r1, r2} 
    BL sum_function 
    POP {r5} 

     
    B Stop
Stop B Stop 
	END