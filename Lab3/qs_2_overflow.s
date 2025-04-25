        AREA STACK, NOINIT, READWRITE, ALIGN=3
			SPACE 1024

        AREA |.vectors|, CODE, READONLY
        EXPORT __Vectors
__Vectors
        DCD __stack_top
        DCD Reset_Handler
        DCD 0
        DCD 0

__stack_top EQU STACK + 1024

        AREA |.text|, CODE, READONLY
        EXPORT Reset_Handler
Reset_Handler
        BL main
        B .

        AREA |.text|, CODE, READWRITE
X       EQU 0x7FFFFFFF     ; Max positive 32-bit int (simulate potential overflow)
Y       EQU 0x00000002     ; Y = 2 (this will cause overflow with X)

main
        MOV     r1, #X      ; Load X
        MOV     r2, #Y      ; Load Y

        ADDS    r3, r1, r2  ; r3 = X + Y, sets flags
        BVS     ADD_OVERFLOW ; Branch if overflow occurred (V flag set)

        SUBS    r4, r1, r2  ; r4 = X - Y, sets flags
        BVS     SUB_OVERFLOW ; Branch if overflow occurred (V flag set)

        UMULL   r3, r4, r1, r2  ; r3 = lower 32-bits, r4 = upper 32-bits (X * Y)

        CMP     r4, #0       ; Compare upper part of multiplication result (overflow if non-zero)
        BNE     MUL_OVERFLOW ; If upper part is non-zero, overflow occurred

        MOV     r5, r3      ; Store lower 32-bits result in r5 (no overflow)

        B       STOP        ; Success

ADD_OVERFLOW
        ; Handle addition overflow
        MOV     r6, #0xDEAD
        B       STOP

SUB_OVERFLOW
        ; Handle subtraction overflow
        MOV     r6, #0xBEEF
        B       STOP

MUL_OVERFLOW
        ; Handle multiplication overflow (upper 32-bits != 0)
        MOV     r6, #0xFACE
        B       STOP

STOP
        B       STOP

        END
