        AREA    data, DATA, READWRITE
        ALIGN   4
numbers     DCD     10, 20, 30, 40, 50      ; array with 5 elements
n           DCD     5                       ; initial length
new_len     DCD     0                       ; to store updated length

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main
        EXPORT  remove_first

main
        LDR     r0, =numbers        ; r0 -> base address of array
        LDR     r1, =n              ; r1 -> pointer to n
        LDR     r1, [r1]            ; r1 = value of n (length)
        BL      remove_first        ; call function

        LDR     r2, =new_len        ; r2 -> memory to store new length
        STR     r1, [r2]            ; store updated length

stop
        B       stop                ; infinite loop

; -------------------------------------
; Function: remove_first
; Input : R0 = base address of array
;         R1 = length of array
; Output: R1 = updated length (length - 1)
; -------------------------------------
remove_first
        CMP     r1, #0              ; if length == 0, do nothing
        BEQ     done

        MOV     r2, #1              ; r2 = index (start from second element)
        MOV     r3, r0              ; r3 = write pointer (start at base)
loop_shift
        CMP     r2, r1              ; if index == length, done
        BEQ     finish_shift

        LDR     r4, [r0, r2, LSL #2] ; load element at index r2
        STR     r4, [r3], #4         ; store it at write pointer, then increment
        ADD     r2, r2, #1           ; r2++
        B       loop_shift

finish_shift
        SUB     r1, r1, #1          ; new length = length - 1
done
        BX      lr                  ; return

        END
