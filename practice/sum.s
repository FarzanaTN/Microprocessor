        AREA    data, DATA, READWRITE
        ALIGN   4

num1_low    DCD     0xFFFFFFFF         ; Lower 32 bits of num1
num1_high   DCD     0xFFFFFFFF         ; Upper 32 bits of num1

num2_low    DCD     0x00000001         ; Lower 32 bits of num2
num2_high   DCD     0x00000000         ; Upper 32 bits of num2

res_low     DCD     0                  ; To store lower 32 bits of result
res_high    DCD     0                  ; To store upper 32 bits of result
res_carry   DCD     0                  ; To store 65th bit (carry-out)

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        ; Load addresses of inputs
        LDR     R0, =num1_low
        LDR     R1, =num2_low

        ; Load values
        LDR     R2, [R0]          ; R2 = num1 low
        LDR     R3, [R0, #4]      ; R3 = num1 high
        LDR     R4, [R1]          ; R4 = num2 low
        LDR     R5, [R1, #4]      ; R5 = num2 high

        ; Add lower 32 bits
        ADDS    R6, R2, R4        ; R6 = result low, sets carry flag

        ; Add upper 32 bits with carry
        ADC     R7, R3, R5        ; R7 = result high

        ; Get 65th bit: carry-out from previous ADC
        MOV     R8, #0
        ADC     R8, R8, #0        ; R8 = 1 if carry-out exists, else 0

        ; Store results
        LDR     R9, =res_low
        STR     R6, [R9]          ; Store result low
        STR     R7, [R9, #4]      ; Store result high
        STR     R8, [R9, #8]      ; Store 65th bit (carry-out)

loop
        B       loop              ; Infinite loop to halt program

        END
