        AREA data, DATA, READWRITE
        ALIGN 4

bcd_data    DCB     0x25     ; BCD: 0x25 = 25 decimal
binary_data DCD     0        ; Will store converted binary value

        AREA code, CODE, READONLY
        ENTRY
        EXPORT main

main
        LDR     R0, =bcd_data     ; R0 points to BCD byte
        LDRB    R1, [R0]          ; Load BCD byte into R1

        BL      BCD_binary        ; Call function to convert

        LDR     R2, =binary_data  ; Store result
        STR     R1, [R2]          ; Save converted binary value

stop
        B       stop              ; Infinite loop

; --------------------------------------------
; Function: BCD_binary
; Input:
;   R1 - BCD value (e.g., 0x25)
; Output:
;   R1 - Binary value (e.g., 25)
; --------------------------------------------
BCD_binary
        MOV     R2, R1            ; Copy original BCD
        AND     R3, R2, #0x0F     ; R3 = lower nibble (units digit)
        AND     R4, R2, #0xF0     ; R4 = upper nibble (tens digit)
        LSR     R4, R4, #4        ; Shift right → get actual tens digit

        MOV     R5, #10
        MUL     R4, R4, R5        ; R4 = tens * 10
        ADD     R1, R4, R3        ; R1 = (tens * 10) + units

        BX      LR                ; Return from function

        END
