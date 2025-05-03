AREA    |.text|, CODE, READONLY
        EXPORT  main

main
        LDR     r0, =t1
        LDRH    r1, [r0]
        LDR     r0, =t2
        LDRH    r2, [r0]

        ; AND
        AND     r3, r1, r2

        ; OR
        ORR     r4, r1, r2

        ; NOR 
        MVN     r5, r4
    
    ;NAND
        MVN     r6, r3

        ; XOR
        EOR     r7, r1, r2
    
        ; XNOR
        MVN     r8, r7
    
    
        LDR     r0, =t3
        LDR     r1, [r0]         
        LDR     r0, =t4
        LDR     r2, [r0]         

        ; AND
        AND     r3, r1, r2       

        ; OR
        ORR     r4, r1, r2       

        ; NOR
        MVN     r5, r4           

        ; NAND
        MVN     r6, r3           

        ; XOR
        EOR     r7, r1, r2       

        ; XNOR
        MVN     r8, r7           



stop
        B stop                           

        AREA    problem1, DATA, READWRITE
        ALIGN   4
t1     DCW     0x0010
t2     DCW     0x0006
t3     DCD     0x00000011
t4     DCD     0x00000007

        END