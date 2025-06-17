        AREA data, DATA, READWRITE
        ALIGN 4

INPUT   DCB 0xAB        ; 8-bit input value
        ALIGN 4         ; Align to word boundary before storing result
PARITY  DCD 0           ; Output (32-bit, still DCD because ARM stores words)

        AREA code, CODE, READONLY
        ENTRY
        EXPORT main

main
        LDR     r0, =INPUT        ; Load address of input
        LDRB    r1, [r0]          ; Load 8-bit value from memory into r1
        MOV     r2, #0            ; Bit counter
        MOV     r3, #8            ; Loop counter (8 bits)

count_loop
        TST     r1, #1            ; Check least significant bit
        ADDNE   r2, r2, #1        ; If bit is 1, increment count
        LSR     r1, r1, #1        ; Logical shift right
        SUBS    r3, r3, #1        ; Decrement bit counter
        BNE     count_loop        ; Repeat if bits remain

        ; Determine parity
        AND     r2, r2, #1        ; r2 = r2 % 2 (0 = even, 1 = odd)

        ; Store parity result
        LDR     r4, =PARITY
        STR     r2, [r4]

done
        B       done              ; Infinite loop

        END
