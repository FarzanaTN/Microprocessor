    AREA STACK, NOINIT, READWRITE, ALIGN=3
	SPACE 1024               ; Reserve 1024 bytes for stack

    AREA |.vectors|, CODE, READONLY
    EXPORT __Vectors
__Vectors
    DCD __stack_top             ; Initial stack pointer
    DCD Reset_Handler           ; Reset handler
    DCD 0                       ; NMI handler (placeholder)
    DCD 0                       ; HardFault handler (placeholder)

    AREA |.text|, CODE, READONLY
__stack_top EQU STACK + 1024

    EXPORT Reset_Handler
Reset_Handler
    BL main                     ; Call main
    B .                         ; Infinite loop if main returns

    AREA |.data|, DATA, READONLY
X       DCD 5                   ; 32-bit constant value for X
Y       DCD 2                  ; 32-bit constant value for Y
	AREA |.data2|, DATA, READWRITE
RESULT_ADD    DCD 0             ; Memory location to store addition result
RESULT_SUB    DCD 0             ; Memory location to store subtraction result
RESULT_MUL    DCD 0             ; Memory location to store multiplication result

    AREA |.text|, CODE, READWRITE
main
    LDR r0, =X                  ; Load address of X
    LDR r1, [r0]                ; Load value of X into r1

    LDR r0, =Y                  ; Load address of Y
    LDR r2, [r0]                ; Load value of Y into r2

    ADD r3, r1, r2              ; r3 = X + Y
    SUB r4, r1, r2              ; r4 = X - Y
    MUL r5, r1, r2              ; r5 = X * Y

    LDR r0, =RESULT_ADD         ; Store result of addition
    STR r3, [r0]

    LDR r0, =RESULT_SUB         ; Store result of subtraction
    STR r4, [r0]

    LDR r0, =RESULT_MUL         ; Store result of multiplication
    STR r5, [r0]

STOP
    B STOP                      ; Infinite loop
    END
