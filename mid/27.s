        AREA    data, DATA, READWRITE
        ALIGN   4

MyData  SPACE   16          ; Reserve 16 bytes of memory starting from label "MyData"

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main

        ; Load immediate values into registers
        MOV     R1, #0x11aa
        MOV     R2, #0x22bb
        MOV     R3, #0x33cc
        MOV     R4, #0x44dd

        ; Load address of MyData into R5
        LDR     R5, =MyData

        ; Perform the STR operations
        STR     R2, [R5, #4]      ; Store R2 at R5 + 4
        STR     R3, [R5], #4      ; Store R3 at R5, then R5 = R5 + 4

stop
        B       stop             ; Infinite loop to halt program

        END
