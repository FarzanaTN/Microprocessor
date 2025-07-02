        AREA    data, DATA, READWRITE
        ALIGN   4
my_string   DCB     "hello", 0         ; Null-terminated string
length      DCD     0                  ; To store result

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main
        EXPORT  string_length

main
        LDR     r0, =my_string         ; r0 -> pointer to string
        BL      string_length          ; call string_length
        LDR     r2, =length            ; r2 -> pointer to result storage
        STR     r1, [r2]               ; store length into memory
stop
        B       stop                   ; infinite loop

; -------------------------------------
; Function: string_length
; Input : r0 = address of null-terminated string
; Output: r1 = length of string
; -------------------------------------
string_length
        MOV     r1, #0                 ; r1 = length counter = 0
loop_strlen
        LDRB    r2, [r0], #1           ; load byte and post-increment r0
        CMP     r2, #0                 ; check for null terminator
        BEQ     end_strlen             ; if null, end
        ADD     r1, r1, #1             ; length++
        B       loop_strlen
end_strlen
        BX      lr                     ; return to caller

        END
