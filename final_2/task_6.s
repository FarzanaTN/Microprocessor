        AREA    data, DATA, READWRITE
        ALIGN   4

array   DCD     4, 1, 5, 3, 2  
n       DCD     5   

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main
        EXPORT  array_ascend

main
        LDR     R0, =array     
        ;MOV     R1, #5   
        LDR     r1, =n
        LDR     r1, [r1]      
        BL      array_ascend   

stop
        B       stop           ; Infinite loop 


array_ascend
        PUSH    { LR}

        SUB     R6, R1, #1        ; length 

outer_loop
        MOV     R2, #0        ; i = 0    

inner_loop
        CMP     R2, R6             
        BGE     end_inner

        LDR     R3, [R0, R2, LSL #2]        ; r3 = array[i]

        ADD     R5, R2, #1                  
        LDR     R4, [R0, R5, LSL #2]        ; r4 = array[i+1]

        CMP     R3, R4
        BLE     no_swap            

        STR     R4, [R0, R2, LSL #2]
        STR     R3, [R0, R5, LSL #2]

no_swap
        ADD     R2, R2, #1         ; i++
        B       inner_loop

end_inner
        SUB     R6, R6, #1         
        CMP     R6, #0
        BGT     outer_loop

        POP     { LR}
        BX      LR

        END
