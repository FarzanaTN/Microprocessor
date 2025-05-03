	AREA    data, DATA, READWRITE
	ALIGN 4
x       DCD     0x0003              
y       DCD     0x0004              
z       DCD     0x0005             

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        LDR r0, =x 
        LDR r1, [r0]
        LDR r0, =y 
        LDR r2, [r0]
        
        ; LSR operation
	MOV r0, r0, LSR r1

        LSR r3, r1, #1
        
        ASR r4, r1, #1
        
        LSL r5, r1, #1


loop
        B       loop               

        END
