        AREA    data, DATA, READWRITE
        ALIGN   4

number   DCB     0x5F            
result  DCW     0x0  

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        
        LDR     R0, =number
        LDR    R1, [R0]            

        
        AND     R2, R1, #0xF     ; extract last digit  

        
        AND     R3, R1, #0xF0   ; extract first digit 

       
        LSL     R3, R3, #4       ; left shift 

       
        ORR     R4, R3, R2        ; or operation

       
        LDR     R5, =result
        STR     R4, [R5]            

stop
        B       stop                ; Infinite loop to halt execution

        END
