        ; Define data section
        AREA    data, DATA, READWRITE
        ALIGN   4

INPUT       DCD     0xF0F0F0F0     ; Example input
RESULT      DCD     0              ; To store the result

        ; Define code section
        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        LDR     r0, =INPUT         ; Address of input value
        LDR     r1, [r0]           ; Load input into r1
        MOV     r2, #0             ; r2 = counter = 0
        MOV     r3, #32            ; r3 = bit count loop = 32 bits

bit_loop
        TST     r1, #1             ; Test least significant bit (bit AND 1)
        ADDNE   r2, r2, #1         ; If bit was 1, increment counter
        LSR     r1, r1, #1         ; Logical shift right to next bit
        SUBS    r3, r3, #1         ; Decrement bit counter
        BNE     bit_loop           ; Repeat if not zero

        ; Store the result
        LDR     r4, =RESULT
        STR     r2, [r4]

done
        B       done              ; Infinite loop to halt

        END
