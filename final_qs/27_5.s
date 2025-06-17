AREA data, DATA, READWRITE
    ALIGN 4
    ; No variables needed in data section as we'll use registers

    AREA code, CODE, READONLY
    ENTRY
    EXPORT main

main
    ; Initialize a and b from somewhere (assumed to be in R0 and R1)
    ; R0 = a, R1 = b
    
while_loop
    ; Check while condition (a - b > 0)
    SUB     R2, R0, R1        ; R2 = a - b
    CMP     R2, #0            ; Compare R2 with 0
    BLE     end_while         ; If R2 <= 0, exit loop
    
    ; if (a < -b)
    NEG     R3, R1            ; R3 = -b
    CMP     R0, R3            ; Compare a with -b
    BGE     else_block        ; If a >= -b, go to else block
    
    ; b = b - a
    SUB     R1, R1, R0        ; R1 (b) = R1 (b) - R0 (a)
    
    ; a = -a
    NEG     R0, R0            ; R0 (a) = -R0 (a)
    
    B       end_if            ; Skip else block
    
else_block
    ; b = a * b
    MUL     R1, R0, R1        ; R1 (b) = R0 (a) * R1 (b)
    
    ; a = 2 - b
    MOV     R4, #2            ; R4 = 2
    SUB     R0, R4, R1        ; R0 (a) = 2 - R1 (b)
    
end_if
    B       while_loop        ; Go back to loop condition

end_while
    ; End of program
    
stop
    B       stop              ; Infinite loop to halt

    END