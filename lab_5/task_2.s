        AREA    BitfieldOps, CODE, READONLY
        ENTRY
        EXPORT  main

main
        ; Load P, Q, R constants
        LDR     R0, =0x20F2        ; P = 0010000011110010
        LDR     R1, =0x30F0        ; Q = 0011000011110000
        LDR     R2, =0xC4F8        ; R = 1100010011111000

        ; Extract Pfield: bits 13-8
        MOV     R3, R0
        LSR     R3, R3, #8         ; >>8 moves p13–p8 to bits [5:0]
        AND     R3, R3, #0x3F      ; Mask to keep only 6 bits

        ; Extract Qfield: bits 6-1
        MOV     R4, R1
        LSR     R4, R4, #1         ; >>1 moves q6–q1 to bits [5:0]
        AND     R4, R4, #0x3F      ; Mask to keep only 6 bits

        ; Extract Rfield: bits 10-5
        MOV     R5, R2
        LSR     R5, R5, #5         ; >>5 moves r10–r5 to bits [5:0]
        AND     R5, R5, #0x3F      ; Mask to keep only 6 bits

        ; Qfield XOR Rfield
        EOR     R6, R4, R5

        ; Add Pfield
        ADD     R7, R3, R6

        ; Mask with 0b111110 = 0x3E
        AND     R8, R7, #0x3E

        ; R8 now holds the result F
stop
        B       stop

        END
