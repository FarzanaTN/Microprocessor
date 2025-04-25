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
X EQU 5 ;define data
Y EQU 7 ;define data
	
main

    MOV r0,  #X
    MOV r1, #Y
    CMP r0, r1 ;compare r0 with r1

    MOVLT r2, r0 ;if r0 < r1, move r0 to r2
    MOVGE r2, r1 ;otherwise move r1 to r2
	
STOP
    B STOP
    END
