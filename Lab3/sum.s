  AREA STACK, NOINIT, READWRITE, ALIGN=3
    SPACE 1024                  ; Reserve 1024 bytes for stack

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
    B .                         ; Loop forever if main returns

    AREA |.data|, DATA, READONLY
X       DCW 0x1234              ; Define 16-bit value (zero-extended to 32-bit)
Y       DCW 0x4321
  AREA |.data2|, DATA, READWRITE
Result  DCW 0x0001                   ; Result placeholder

    AREA |.text|, CODE, READWRITE
main
    LDR r0, =X                  ; Load address of X
    LDRH r1, [r0]                ; Load value of X into r1

    LDR r0, =Y                  ; Load address of Y
    LDRH r2, [r0]                ; Load value of Y into r2

    ADD r3, r1, r2              ; Add X and Y, store result in r3

    LDR r0, =Result             ; Load address of Result
    STRH r3, [r0]                ; Store result in memory

STOP
    B STOP                      ; Infinite loop
    END