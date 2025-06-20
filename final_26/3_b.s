        AREA    data, DATA, READWRITE
        ALIGN   4
x       DCD     0       ; variable x
y       DCD     0       ; variable y

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        ; x = 1
        LDR     r0, =x
        MOV     r1, #1
        STR     r1, [r0]

        ; load x into r2 for comparison
        LDR     r2, [r0]

        ; switch (x)
        CMP     r2, #0
        BEQ     case0
        CMP     r2, #1
        BEQ     case1
        B       default_case

case0
        LDR     r3, =y
        MOV     r4, #10
        STR     r4, [r3]
        B       end_switch

case1
        LDR     r3, =y
        MOV     r4, #11
        STR     r4, [r3]
        B       end_switch

default_case
        LDR     r3, =y
        MOV     r4, #13
        STR     r4, [r3]

end_switch
        ; return y
        LDR     r3, =y
        LDR     r0, [r3]     ; place return value in r0

stop
        B       stop        ; infinite loop to stop

        END
