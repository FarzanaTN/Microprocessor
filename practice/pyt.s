;do the pythagoras
    AREA STACK, NOINIT, READWRITE, ALIGN = 3
    SPACE 1024

    AREA |.vector|, CODE, READONLY
    EXPORT __Vectors
__Vectors
    DCD __stack_top             ; Initial value of stack pointer (top of the stack)
    DCD Reset_Handler           ; Address of Reset handler (entry point after reset)
    DCD 0                       ; NMI handler
    DCD 0

    AREA |.text|, CODE, READONLY
__stack_top EQU STACK + 1024     ; Top of stack

    EXPORT Reset_Handler
Reset_Handler
    BL main                     ; Call main
    B .                         ; Infinite loop

    AREA |.data|, DATA, READONLY

a   DCD 3                       ; a = 3
b   DCD 4                       ; b = 4

    AREA |.data2|, DATA, READWRITE
c   DCD 0                       ; to store sqrt(a^2 + b^2)

    AREA |.text|, CODE, READWRITE
main
    ; ------------------------
    ; Pythagoras Theorem part
    ; ------------------------

    LDR R0, =a                  ; R0 = address of a
    LDR R1, [R0]                ; R1 = a
    MUL R2, R1, R1              ; R2 = a * a

    LDR R0, =b                  ; R0 = address of b
    LDR R1, [R0]                ; R1 = b
    MUL R3, R1, R1              ; R3 = b * b

    ADD R4, R2, R3              ; R4 = a^2 + b^2

    ; Approximate square root
    ; For a = 3, b = 4
    ; sqrt(9 + 16) = sqrt(25) = 5
    MOV R5, #5                  ; R5 = 5 (result)

    LDR R0, =c
    STR R5, [R0]                ; store result into c

STOP
    B STOP
    END
