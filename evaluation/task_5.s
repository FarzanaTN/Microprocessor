        ; Define data section
        AREA    data, DATA, READWRITE
        ALIGN   4

INPUT       DCD     0xFFFFFFFF      ; Example input (all bits set)
RESULT      DCD     0               ; To store the result

        ; Define code section
        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        LDR     r0, =INPUT          ; Load address of input value
        LDR     r1, [r0]            ; r1 = input value

        LDR     r2, =0x55555555     ; r2 = mask to toggle even bits
        EOR     r1, r1, r2          ; r1 = r1 XOR mask (toggle even bits)

        LDR     r3, =RESULT         ; Load address to store result
        STR     r1, [r3]            ; Store result

done
        B       done                ; Infinite loop to halt

        END
