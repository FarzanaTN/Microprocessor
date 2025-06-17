        AREA data, DATA, READWRITE
        ALIGN 4
array   DCD 1, 2, 3, 4, 5
result  DCD 0, 0, 0, 0, 0
length  EQU 5

        AREA code, CODE, READONLY
        ENTRY
        EXPORT main

main
        LDR     r0, =array
        LDR r3, =result
        MOV     r1, #0               ; i = 0
        MOV     r2, #(length )    ; j = length 
        ADD     r0, r0, #(4*(length-1))

reverse_loop
        CMP     r1, r2
        BGE     done

       
        
        LDR     r4, [r0]  
        STR     r4,[r3] 
        SUB r0, r0, #4
        ADD r3, r3, #4

        ;ADD     r0, r0, #4
        ;LDR r3, [r0]
        ADD     r1, r1, #1
        ;SUB     r2, r2, #1
        B       reverse_loop

done
        B       .

        END
