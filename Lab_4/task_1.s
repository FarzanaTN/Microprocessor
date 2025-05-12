;Write an assembly language to perform addition, subtraction and multiplication on 64 bit numbers and store the result in memory.

        AREA    data, DATA, READWRITE
        ALIGN   4

; -------- Input 64-bit Numbers ----------
num1        DCD     0xFFFFFFFF      ; num1 low
            DCD     0xFFFFFFFF      ; num1 high

num2        DCD     0x00000001      ; num2 low
            DCD     0x00000000      ; num2 high

; -------- Result Storage ---------------
result_add  DCD     0, 0, 0         ; [low, high, carry]
result_sub  DCD     0, 0, 0         ; [low, high, borrow]
result_mul  DCD     0, 0, 0, 0      ; [lowest to highest 32-bit words of 128-bit result]

        AREA    code, CODE, READONLY
        ALIGN   4
        ENTRY
        EXPORT  main

main
        ; ------- Load num1 into R2 (low), R3 (high) -------
        LDR     R0, =num1
        LDR     R2, [R0]
        LDR     R3, [R0, #4]

        ; ------- Load num2 into R4 (low), R5 (high) -------
        LDR     R0, =num2
        LDR     R4, [R0]
        LDR     R5, [R0, #4]

; ------------ 65-bit ADDITION ------------
        ADDS    R6, R2, R4         ; R6 = low result, carry set in CPSR
        ADCS    R7, R3, R5         ; R7 = high result + carry
        ADC     R8, R8, #0         ; R8 = final carry (bit 64)

        LDR     R0, =result_add
        STR     R6, [R0]           ; low
        STR     R7, [R0, #4]       ; high
        STR     R8, [R0, #8]       ; carry

; ------------ 64-bit SUBTRACTION with borrow ------------
        SUBS    R9, R2, R4         ; R9 = low result, sets borrow if needed
        SBC     R10, R3, R5        ; R10 = high result with borrow
        MOV     R11, #0            ; Clear borrow to propagate
        ADC     R11, R11, #0       ; Propagate NOT(carry) to R11 (borrow = 1 if borrow occurred)

        LDR     R0, =result_sub
        STR     R9, [R0]           ; low
        STR     R10, [R0, #4]      ; high
        STR     R11, [R0, #8]      ; borrow (1 if borrow occurred)

        ; ------------ 128-bit MULTIPLICATION ------------
        ; Assume: A = R3:R2, B = R5:R4

        ; Step 1: A0 * B0
        UMULL   R6, R7, R2, R4     ; R7:R6 = A0 * B0

        ; Step 2: A1 * B0
        UMULL   R11, R12, R3, R4   ; R12:R11 = A1 * B0

        ; Step 3: A0 * B1
        UMULL   R1, R10, R2, R5    ; R10:R1 = A0 * B1

        ; Step 4: A1 * B1
        UMULL   R8, R9, R3, R5     ; R9:R8 = A1 * B1

        ; Step 5: Add mid parts
        ADDS    R1, R1, R11        ; low part of (A1*B0 + A0*B1)
        ADC     R10, R10, R12      ; high part with carry

        ; Step 6: Add mid into main result
        ADDS    R7, R7, R1         ; add mid low to A0*B0 high
        ADC     R8, R8, R10        ; propagate to A1*B1 low
        ADC     R9, R9, #0         ; final carry

        ; Step 7: Store result
        LDR     R0, =result_mul
        STR     R6, [R0]
        STR     R7, [R0, #4]
        STR     R8, [R0, #8]
        STR     R9, [R0, #12]
        


stop
        B       stop              ; infinite loop to end program

        END
