        AREA data, DATA, READWRITE
        ALIGN 4

bytes   DCB     0x11, 0x22, 0x33, 0x44     ; 4 data bytes

        AREA code, CODE, READONLY
        ENTRY
        EXPORT main

main
        LDR     R0, =bytes     ; R0 = base address of byte array
        MOV     R1, #0         ; loop index = 0
        MOV     R4, #0         ; R4 = total sum
        MOV     R5, #0         ; R5 = carry count

loop
        CMP     R1, #4
        BGE     done           ; loop ends after 4 bytes

        LDRB    R2, [R0, R1]   ; Load byte from memory into R2

        BL      Add_byte       ; Call function to add byte & handle carry

        ADD     R1, R1, #1     ; Increment index
        B       loop

done
stop
        B       stop           ; Infinite loop to stop

; --------------------------------------------
; Function: Add_byte
; Input:
;   R2 - New byte to add
; Uses:
;   R4 - Running sum
;   R5 - Carry counter
; Output:
;   R4 updated sum, R5 updated carry
; --------------------------------------------

Add_byte
        ADDS    R4, R4, R2     ; Add byte with flag update
        BCC     no_carry       ; If no carry, skip

        ADD     R5, R5, #1     ; Carry occurred → increment carry register

no_carry
        BX      LR             ; Return from function

        END
