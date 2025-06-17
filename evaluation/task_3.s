        ; Define data section
        AREA    data, DATA, READWRITE
        ALIGN   4

VAL1        DCD     25          ; Example value 1
VAL2        DCD     42          ; Example value 2
MAX_VAL     DCD     0           ; To store the larger value

        ; Define code section
        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        ; Load address of VAL1 and VAL2
        LDR     r0, =VAL1
        LDR     r1, [r0]        ; r1 = VAL1

        LDR     r0, =VAL2
        LDR     r2, [r0]        ; r2 = VAL2

        ; Compare r1 and r2
        CMP     r1, r2
        BGT     store_r1        ; if r1 > r2, go store r1
        ; Else, r2 is greater or equal

        LDR     r0, =MAX_VAL
        STR     r2, [r0]        ; Store r2 as max
        B       done

store_r1
        LDR     r0, =MAX_VAL
        STR     r1, [r0]        ; Store r1 as max

done
        B       done            ; Infinite loop to halt execution

        END
