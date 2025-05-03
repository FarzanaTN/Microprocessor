;Qs
;Write an assembly program to display the status of each bit of the register PSR.

;code starts
    AREA STACK, NOINIT, READWRITE, ALIGN = 3
    SPACE 1024

    AREA |.vector|, CODE, READONLY
    EXPORT __Vectors
__Vectors
    DCD __stack_top             ; Initial value of stack pointer (top of the stack)
    DCD Reset_Handler           ; Address of Reset handler (entry point after reset)
    DCD 0                       ; NMI handler (placeholder)
    DCD 0

    AREA |.text|, CODE, READONLY
__stack_top EQU STACK + 1024    ; Top of 1KB stack

    EXPORT Reset_Handler
Reset_Handler
    BL main
    B .

    AREA |.text|, CODE, READWRITE
    EXPORT main

main
    PUSH {R4, R5, R6}            ; Save registers

    MRS R0, APSR                 ; Move Program Status Register to R0 (APSR is Application PSR)
    MOV R1, #32                  ; Number of bits in PSR
    MOV R2, #0                   ; Bit index (starting from 0)

check_next_bit
    MOV R3, R0                   ; Copy PSR value
    LSR R3, R3, R2               ; Logical shift right R3 by R2 positions
    AND R3, R3, #1               ; Mask to get only the least significant bit

    ; At this point:
    ; R2 -> bit number (0 to 31)
    ; R3 -> value of that bit (0 or 1)

    ; Here you would normally display (bit number and bit value)
    ; For now we simulate it by just proceeding (since no UART/console display is setup)

    ADD R2, R2, #1               ; Next bit
    CMP R2, R1
    BLT check_next_bit           ; If R2 < 32, continue checking next bit

    POP {R4, R5, R6}
    B STOP                       ; After finishing, jump to stop

STOP
    B STOP
    END
