        AREA    data, DATA, READWRITE
        ALIGN   4

x  DCD    0x80008001

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        LDR r0, =x
        LDR r1, [r0]
        LSR r1, r1, #3  ; 0x10001000
        
        LDR r1, [r0]
        LSL r1, r1, #4  ;0x00080010
        MOV r0, #12
	MOV r1, #12
        CMP r0, r1  ;z flag set 1

        MOV r3, #1
        MOV r4, #2
        ADD r5, r3, r4 ;no flag set
        ADDS r6, r3, r4 ;diff --> z, c flag set
stop
        B       stop            ; Infinite loop to halt program

        END
