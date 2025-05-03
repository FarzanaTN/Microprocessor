;find the avg of n numbers
    AREA STACK, NOINIT, READWRITE, ALIGN = 3
    SPACE 1024

    AREA |.vector|, CODE, READONLY
    EXPORT __Vectors
__Vectors
    DCD __stack_top             ; Initial value of stack pointer (top of the stack)
    DCD Reset_Handler           ; Address of Reset handler (entry point after reset)
    DCD 0                       ; NMI handler (placeholder)
    DCD 0

    ;Define the top of the stack
    AREA |.text|, CODE, READONLY
__stack_top EQU STACK + 1024 ;caluculate the top of the stack(end of 1KB stack)

    ;Define the reset handler function
    EXPORT Reset_Handler
Reset_Handler
    BL main                     ; Branch with link to the main (Call main)
    B .                         ; Loop forever if main returns

    AREA |.data|, DATA, READONLY
numbers DCD 1, 2, 3, 4, 5
n       DCD 5

    AREA |.data2|, DATA, READWRITE
avg DCD 0x0001
sum DCD 0

    AREA |.text|, CODE, READWRITE
main
    LDR r0, =numbers
    MOV r1, #0 ;hold the sum
    MOV r2, #5 ;hold the total element numner 
    MOV r3, #0;loop counter

LOOP 
    LDR r4, [r0, r3, LSL #2]
    ADD r1, r1, r4
    ADD r3, r3, #1
    CMP r3, r2
    BNE LOOP

    MOV r4, #5
    UDIV r1, r1, r4

    LDR r5, =avg
    STR r1, [r5]

STOP
    B STOP
    END