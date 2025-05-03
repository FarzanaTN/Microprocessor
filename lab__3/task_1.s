	AREA    data, DATA, READWRITE
	ALIGN 4
x       DCD     0x00000003              
y       DCD     0x00000004              
p       DCW     0x0005  
q       DCW     0x0006 
		AREA |.data2|, DATA, READWRITE
	

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
    ; Load operands
    LDR r0, =x
    LDR r1, [r0]
    LDR r0, =y
    LDR r2, [r0]

    ; ----------- 32-bit LOGIC -----------
    ; AND
    AND r3, r1, r2
    

    ; OR
    ORR r4, r1, r2
    


    ;nor operation
    ;ORN r5, r1, r2
    MVN r5, r4
    
    ; NOR operation
	ORR r0, r1, r2
	BIC r0, r3, r0	
   

    ; NAND = NOT (AND)
    
    MVN r6, r3
    ;BIC r6, r3
   
    ; XOR
    EOR r7, r1, r2
;     LDR r0, =xor32
;     STR r3, [r0]

    ; XNOR = NOT (XOR)
    
    MVN r0, r7
;     LDR R0, =xnor32
;     STR R3, [R0]
    
    ;----------------16 bit----------------
    LDR r0, =p
    LDRH r1, [r0]
    LDR r0, =q
    LDRH r2, [r0]

    
    ; AND
    AND r3, r1, r2
    

    ; OR
    ORR r4, r1, r2
    
    

    

    ;nor operation
    ;ORN r5, r1, r2
    MVN r5, r4
    

    ; NAND = NOT (AND)
    ;AND r3, r1, r2
    MVN r6, r3
    
    ; XOR
    EOR r7, r1, r2
    

    ; XNOR = NOT (XOR)
   
    MVN r0, r7
    


    


stop
        B       stop               

        END
