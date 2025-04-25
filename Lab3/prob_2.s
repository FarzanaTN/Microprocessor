    AREA STACK, NOINIT,READWRITE, ALIGN = 3
        SPACE 1024    ;reserves 1024 bytes for stack

    
    AREA |.vectors|, CODE, READONLY
    EXPORT __Vectors
__Vectors
    DCD __stack_top ;initial stack pointer
    DCD Reset_Handler ;reset handler
    DCD 0 ;NMI handler (placeholder)
    DCD 0 ;hardfault handler (placeholder)

    AREA |.text|, CODE, READONLY
__stack_top EQU STACK + 1024

    EXPORT Reset_Handler
Reset_Handler
    BL main ;call main
    B . ;loop forever if main returns



    AREA |.text|, CODE, READWRITE
X EQU 5
Y EQU 7
	
main

    MOV r1,  #X
    MOV r2, #Y
    ADD r0, r1, r2		  ;r0 = r1 + r2 (addition)
    SUB r4, r1, r2        ; r4 = r1 - r2 (Subtraction)
    MUL r5, r1, r2        ; r5 = r1 * r2 (Multiplication)
	
STOP
    B STOP
    END
