        AREA data, DATA, READWRITE
        ALIGN 4

num1    DCD     5              ; first number
num2    DCD     1              ; second number
sum     DCD     0               ; to store the result

        AREA code, CODE, READONLY
        ENTRY
        EXPORT main

main
        LDR     r0, =num1        ; r0 = &num1
        LDR     r1, =num2        ; r1 = &num2
        BL      add_by_reference ; call add_by_reference(&num1, &num2)

        LDR     r2, =sum         ; r2 = &sum
        STR     r0, [r2]         ; store result in sum

stop
        B       stop             ; infinite loop

; ---------------------------------------------------------
; Function: add_by_reference
; Input:
;   r0 = pointer to num1
;   r1 = pointer to num2
; Output:
;   r0 = value at *r0 + value at *r1
; ---------------------------------------------------------

add_by_reference
        PUSH    {r2, lr}         ; save registers

        LDR     r2, [r0]         ; r2 = *r0 (value at num1)
        LDR     r0, [r1]         ; r0 = *r1 (value at num2)
        ADD     r0, r0, r2       ; r0 = *r0 + *r1

        POP     {r2, lr}
        BX      lr               ; return

        END
