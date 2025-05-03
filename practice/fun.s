;find avg using function call
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
    MOV r1, #5
    BL find_average

    LDR r2, =avg
    STR r0, [r2]


STOP
    B STOP
    END

    EXPORT find_average
find_average
    PUSH {r4-r7, LR}    ; Save used registers and link register
    MOV r2, #0 ;to hold sum
    MOV r3, #0 ;to count
LOOP 
    LDR r4, [r0, r3, LSL #2]
    ADD r2, r2, r4
    ADD r3, r3, #1
    CMP r3, r1
    BNE LOOP

    
    UDIV r0, r2, r1

    POP {r4-r7, PC} ; Restore registers and return// MOV PC, LR

    END


