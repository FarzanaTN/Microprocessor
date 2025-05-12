        AREA data, DATA, READWRITE
        ALIGN 4



        AREA code, CODE, READONLY
        ENTRY
        EXPORT main

main
        LDR r0, #0x20008000
        LDR r1, #0x76543210
        STR r1, [r0], #4

stop
        B       stop            ; Infinite loop to halt
        END
