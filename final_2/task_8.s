        AREA    data, DATA, READWRITE
        ALIGN   4
numbers     DCD     11, 22, 33, 44, 55    ; original array
n           DCD     5                    ; length of the array

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main
        EXPORT  swap_array

main
        LDR     r0, =numbers             ; r0 = base address of array
        LDR     r1, =n                   ; r1 = address of length
        LDR     r1, [r1]                 ; r1 = actual length value

        BL      swap_array               ; call the function to reverse array

stop
        B       stop                     ; infinite loop

; -------------------------------------
; Function: swap_array
; Input : R0 = base address of array
;         R1 = length of array
; Output: array reversed in-place using two pointers
; -------------------------------------
swap_array
        CMP     r1, #1                  ; if length <= 1, nothing to swap
        BLE     done

        MOV     r2, #0                  ; r2 = start index (i)
        SUB     r3, r1, #1              ; r3 = end index (j = length - 1)

loop
        CMP     r2, r3                  ; while i < j
        BGE     done                    ; exit if i >= j

        ; Load arr[i] into r4
        LDR     r4, [r0, r2, LSL #2]

        ; Load arr[j] into r5
        LDR     r5, [r0, r3, LSL #2]

        ; Swap: store r5 into arr[i], and r4 into arr[j]
        STR     r5, [r0, r2, LSL #2]
        STR     r4, [r0, r3, LSL #2]

        ; i++
        ADD     r2, r2, #1

        ; j--
        SUB     r3, r3, #1

        B       loop

done
        BX      lr                      ; return to caller

        END
