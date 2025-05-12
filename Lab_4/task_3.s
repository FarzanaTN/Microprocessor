        AREA    data, DATA, READWRITE
        ALIGN   4

bcd_val     DCB     0x25            ; Example BCD value: 0x25 (decimal 25)
hex_val     DCD     0               ; Placeholder for result

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        LDR     R0, =bcd_val        ; Load address of BCD value
        LDRB    R1, [R0]            ; Load BCD byte into R1

        AND     R2, R1, #0xF0       ; Extract upper nibble (tens)
        LSR     R2, R2, #4          ; Shift right to get actual tens digit

        AND     R3, R1, #0x0F       ; Extract lower nibble (units)

        MOV     R4, #10
        MUL     R2, R2, R4          ; Multiply tens digit by 10
        ADD     R2, R2, R3          ; Add units digit

        LDR     R5, =hex_val        ; Load address to store result
        STR     R2, [R5]            ; Store HEX result

stop
        B       stop                ; Infinite loop to halt program

        END
