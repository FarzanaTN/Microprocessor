        AREA    data, DATA, READWRITE
        ALIGN   4
numbers     DCD     5, 15, 25, 35, 45      ; array with 5 elements
n           DCD     5                      ; initial length
new_len     DCD     0                      ; to store updated length

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main
        EXPORT  remove_last

main
        LDR     r0, =numbers        ; r0 -> base address of array
        LDR     r1, =n              ; r1 -> pointer to length
        LDR     r1, [r1]            ; r1 = value of length
        BL      remove_last         ; call function

        LDR     r2, =new_len        ; r2 -> memory location for new length
        STR     r1, [r2]            ; store updated length

stop
        B       stop                ; infinite loop to stop

; -------------------------------------
; Function: remove_last
; Input : R0 = base address of array
;         R1 = length of array
; Output: R1 = updated length (length - 1)
; -------------------------------------
remove_last
        CMP     r1, #0              ; if length == 0, do nothing
        BEQ     done

        SUB     r1, r1, #1          ; new length = length - 1

done
        BX      lr                  ; return

        END
