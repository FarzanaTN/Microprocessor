        AREA    data, DATA, READWRITE
        ALIGN   4
numbers     DCD     10, 7, 4, 9, 3       ; sample array
n           DCD     5                    ; number of elements

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main
        EXPORT  odd_even

main
        LDR     r2, =numbers             ; r2 = base address of array
        LDR     r3, =n                   ; r3 = pointer to length
        LDR     r3, [r3]                 ; r3 = actual length

        MOV     r0, r2                   ; r0 = array address
        MOV     r1, r3                   ; r1 = length

        BL      odd_even                 ; call function

        ; At this point:
        ; R0 = number of even numbers
        ; R1 = number of odd numbers

stop
        B       stop                     ; infinite loop

; -----------------------------------------
; Function: odd_even
; Input : R0 = base address of array
;         R1 = length of array
; Output: R0 = number of even elements
;         R1 = number of odd elements
; -----------------------------------------
odd_even
        MOV     r2, #0                   ; r2 = loop index
        MOV     r3, #0                   ; r3 = even count
        MOV     r4, #0                   ; r4 = odd count

loop
        CMP     r2, r1                   ; if index >= length, done
        BGE     done

        LDR     r5, [r0, r2, LSL #2]     ; load numbers[index]

        TST     r5, #1                   ; test if LSB is 1 (odd)
        BEQ     even                     ; if not set, it's even

        ADD     r4, r4, #1               ; odd count++
        B       next

even
        ADD     r3, r3, #1               ; even count++

next
        ADD     r2, r2, #1               ; index++
        B       loop

done
        MOV     r0, r3                   ; return even count in r0
        MOV     r1, r4                   ; return odd count in r1
        BX      lr                       ; return

        END
