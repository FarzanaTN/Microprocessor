        AREA data, DATA, READWRITE
        ALIGN 4

counter     DCB     0x00        ; BCD counter starting from 00

        AREA code, CODE, READONLY
        ENTRY
        EXPORT main

main
        LDR     R1, =counter     ; R1 = pointer to counter byte

loop
        LDRB    R0, [R1]         ; Load current BCD value

        ; -------- (Place to display BCD: R0) --------

        BL      delay_1s         ; Call delay of 1 second

        ; -------- BCD Increment Logic --------
        ADD     R0, R0, #1       ; Add 1 to BCD

        AND     R2, R0, #0x0F    ; Extract units digit
        CMP     R2, #0x0A
        BLO     store            ; If units < 10, continue

        ADD     R0, R0, #0x06    ; Adjust BCD: add 6 to wrap units and carry

        AND     R2, R0, #0xF0    ; Extract tens digit
        CMP     R2, #0xA0        ; Check if tens overflowed
        BHS     done             ; If >= 0xA0, end

store
        STRB    R0, [R1]         ; Store new BCD counter
        B       loop             ; Repeat

done
        B       done             ; End here (infinite loop)

; ---------------------------------------------
; 1-Second Delay Function
; Customize based on system clock frequency
; ---------------------------------------------

; For example: C MHz = 50 MHz
; 1 instruction = 1 cycle ⇒ Need ~50,000,000 cycles
; We simulate with nested loops

delay_1s
        MOV     R3, #250         ; Outer loop
outer
        MOV     R4, #200000      ; Inner loop (adjust for clock)
inner
        SUBS    R4, R4, #1
        BNE     inner
        SUBS    R3, R3, #1
        BNE     outer
        BX      LR

        END
