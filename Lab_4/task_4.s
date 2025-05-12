        AREA    data, DATA, READWRITE
        ALIGN   4
hex_num     DCD     0x1A       ; Input: hexadecimal number (e.g., 0x1A = 26 decimal)
bcd_result  SPACE   4          ; Output: space for BCD result (up to 4 digits, 16 bits)

    AREA    code, CODE, READONLY
    ENTRY
    EXPORT  main

main
    LDR     R0, =hex_num       ; Load address of hex number
    LDR     R1, [R0]           ; Load hex value (e.g., 0x1A = 26 decimal)
    LDR     R2, =bcd_result    ; Load address to store BCD result
    MOV     R3, #0             ; Initialize BCD result
    MOV     R4, #10            ; Decimal base for division
    MOV     R5, R1             ; Copy hex value to R5 (working number)
    MOV     R6, #0             ; Counter for digit position (0, 4, 8, ...)

convert_loop
    CMP     R5, #0             ; Check if number is 0
    BEQ     store_bcd          ; If zero, store result
    UDIV    R7, R5, R4         ; Divide by 10 to get quotient
    MUL     R8, R7, R4         ; Multiply quotient by 10
    SUB     R9, R5, R8         ; Remainder (current digit, 0-9)
    LSL     R9, R9, R6         ; Shift digit to correct BCD position
    ORR     R3, R3, R9         ; Add digit to BCD result
    ADD     R6, R6, #4         ; Increment position by 4 bits for next digit
    MOV     R5, R7             ; Update number with quotient
    B       convert_loop       ; Repeat for next digit

store_bcd
    STR     R3, [R2]           ; Store final BCD result (e.g., 0x26 for 26 decimal)

done
    B       done               ; Infinite loop to stop the program

    END