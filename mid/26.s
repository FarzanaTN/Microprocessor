        AREA    data, DATA, READWRITE
        ALIGN   4

x  DCD    0x80008001

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        LDR r0, =x
        LDR r1, [r0]
        LSR r1, r1, #3  ;0x10001000
        
        LDR r1, [r0]
        LSL r1, r1, #4  ;0x00080010

        LDR r1, [r0]
        ASR r1, r1, #1  ;0xC0004000
		
        

stop
        B       stop            ; Infinite loop to halt program

        END
