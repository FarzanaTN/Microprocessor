        AREA data, DATA, READWRITE
        ALIGN 4

sum     DCD     0               ; to store result

        AREA code, CODE, READONLY
        ENTRY
        EXPORT main

main
        MOV     r0, #2         ; first number (argument 1)
        MOV     r1, #5          ; second number (argument 2)
        BL      add_numbers     ; call add_numbers(r0, r1)
                                ; result in r0

        LDR     r2, =sum
        STR     r0, [r2]        ; store result in memory

stop
        B       stop

;--------------------------------------------------
; Function: add_numbers
; Input: r0 = a, r1 = b
; Output: r0 = a + b
; Uses: r2, lr
;--------------------------------------------------
add_numbers
        PUSH    {lr}            ; save return address
        ADD     r0, r0, r1      ; r0 = r0 + r1
        POP     {lr}            ; restore return address
        BX      lr              ; return

        END
