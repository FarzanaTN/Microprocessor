        ; Define data section
        AREA    data, DATA, READWRITE
        ALIGN   4
newline     DCB     0x0D, 0x0A, 0        ; CR LF null-terminated

        ; Define code section
        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        MOV     r4, #0x98        ; Start number
        MOV     r5, #0xA5        ; End number

loop
        ; Convert r4 to hexadecimal ASCII string
        MOV     r0, r4           ; Copy value to r0
        BL      to_hex_string    ; Converts r0 → hexStr in r1

        ; Print the hex string
        MOV     r0, #0x04        ; SYS_WRITE0
        BKPT    0xAB

        ; Print newline
        LDR     r1, =newline
        MOV     r0, #0x04
        BKPT    0xAB

        ; Increment number
        ADD     r4, r4, #1
        CMP     r4, r5
        BGT     done
        B       loop

done
        B       done             ; Infinite loop to stop execution

; ------------------------------------------------------------
; Converts a number in r0 to a 2-digit hex ASCII string + NULL
; Returns pointer to string in r1
; ------------------------------------------------------------
to_hex_string
        PUSH    {r2, r3, r4, lr}

        LDR     r1, =hexStr      ; Destination buffer

        ; Get high nibble
        MOV     r2, r0
        LSR     r2, r2, #4
        AND     r2, r2, #0xF
        BL      nibble_to_ascii
        STRB    r0, [r1]

        ; Get low nibble
        AND     r2, r0, #0xF
        BL      nibble_to_ascii
        STRB    r0, [r1, #1]

        ; Null-terminate
        MOV     r0, #0
        STRB    r0, [r1, #2]

        POP     {r2, r3, r4, pc}

; --------------------------------------------
; Converts 4-bit nibble in r2 to ASCII char in r0
; --------------------------------------------
nibble_to_ascii
        CMP     r2, #9
        BLE     less_than_10
        ADD     r0, r2, #'A' - 10
        BX      lr
less_than_10
        ADD     r0, r2, #'0'
        BX      lr

; --------------------------------------------
; Storage buffer for hex string
; --------------------------------------------
        AREA    strings, DATA, READWRITE
hexStr      SPACE   3           ; 2 chars + null
