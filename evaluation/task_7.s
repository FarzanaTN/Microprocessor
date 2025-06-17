        ; Define data section
        AREA    data, DATA, READWRITE
        ALIGN   4

number      DCD 0x12345678         ; Original number at 0x20000000
n_value     DCD 8                  ; Number of bits to rotate at 0x20000004
result      DCD 0                  ; Space to store result at 0x20000008

        ; Define code section
        AREA    code, CODE, READONLY
        ALIGN   4
        ENTRY
        EXPORT  main

main
        ; Load addresses
        LDR     r0, =number        ; r0 points to original number
        LDR     r1, [r0]           ; r1 = number

        LDR     r2, =n_value       ; r2 points to rotate amount
        LDR     r3, [r2]           ; r3 = n

        ; Calculate rotate left:
        ; ROL x, n = (x << n) | (x >> (32 - n))
        ; Use ORR with LSLS and LSRS

        MOV     r4, r1             ; Copy original number
        MOV     r5, r3             ; Copy n

        ; Left part: x << n
        LSLS    r4, r4, r5         ; r4 = r1 << n

        ; Right part: x >> (32 - n)
        RSB     r5, r5, #32        ; r5 = 32 - n
        LSRS    r1, r1, r5         ; r1 = original >> (32 - n)

        ; Combine both parts
        ORR     r6, r4, r1         ; r6 = rotated value

        ; Store result
        LDR     r7, =result
        STR     r6, [r7]

done
        B       done              ; Infinite loop to end

        END
