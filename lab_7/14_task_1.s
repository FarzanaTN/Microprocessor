        AREA data, DATA, READWRITE
        ALIGN 4
array   DCD 10, 20, 30, 40, 50
length  EQU 5
output  DCD 0

        AREA code, CODE, READONLY
        ENTRY
        EXPORT main

main
        LDR     r0, =array
        LDR     r1, [r0]             ; First element
        LDR     r2, =length
        SUB     r2, r2, #1
        ADD     r0, r0, #(4*(length-1))
        LDR     r3, [r0]  
        B stop           

stop
        B       stop                ; infinite loop to stop

       

        END
