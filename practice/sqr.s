;find sum of square
    AREA STACK, NOINIT, READWRITE, ALIGN = 3
    SPACE 1024

    AREA |.vector|, CODE, READONLY
    EXPORT __Vectors
__Vectors
    DCD __stack_top             ; Initial value of stack pointer (top of the stack)
    DCD Reset_Handler           ; Address of Reset handler
    DCD 0                       ; NMI handler (placeholder)
    DCD 0

    AREA |.text|, CODE, READONLY
__stack_top EQU STACK + 1024     ; Top of the stack

    EXPORT Reset_Handler
Reset_Handler
    BL main                     ; Call main
    B .                         ; Infinite loop

    AREA |.data|, DATA, READONLY

    AREA |.data2|, DATA, READWRITE
sum DCD 0                        ; Variable to store the result

    AREA |.text|, CODE, READWRITE
main
    LDR R0, =sum                 ; R0 holds address of sum
    MOV R1, #0                   ; R1 = 0 (accumulator)
    MOV R2, #1                   ; R2 = 1 (i = 1)

loop
    MUL R3, R2, R2               ; R3 = i * i
    ADD R1, R1, R3               ; R1 = R1 + i*i
    ADD R2, R2, #1               ; i = i + 1
    CMP R2, #11                  ; Compare i with 11
    BNE loop                     ; If i != 11, repeat loop

    STR R1, [R0]                 ; Store result in sum

STOP
    B STOP
    END
