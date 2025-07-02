        AREA    data, DATA, READWRITE
        ALIGN   4
numbers     DCD     1, 2, 3, 4         ; array to be reversed
n           DCD     4                  ; number of elements

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main
        EXPORT  reverse_array

main
        LDR     r0, =numbers           ; r0 = address of array
        LDR     r1, =n                 ; r1 = pointer to length
        LDR     r1, [r1]               ; r1 = actual length

        BL      reverse_array          ; call reverse function

stop
        B       stop                   ; infinite loop

; -----------------------------------------
; Function: reverse_array
; Input : R0 = base address of array
;         R1 = length of array
; Output: array reversed in-place
; -----------------------------------------
reverse_array
        CMP     r1, #1                 ; if length <= 1, nothing to do
        BLE     done

        MOV     r2, #0                 ; r2 = start index (i)
        SUB     r3, r1, #1             ; r3 = end index (j = length - 1)

loop
        CMP     r2, r3                 ; while i < j
        BGE     done                   ; exit if i >= j

        ; Load elements at positions i and j
        LDR     r4, [r0, r2, LSL #2]   ; r4 = arr[i]
        LDR     r5, [r0, r3, LSL #2]   ; r5 = arr[j]

        ; Swap arr[i] and arr[j]
        STR     r5, [r0, r2, LSL #2]
        STR     r4, [r0, r3, LSL #2]

        ; Update indices: i++, j--
        ADD     r2, r2, #1
        SUB     r3, r3, #1
        B       loop

done
        BX      lr                     ; return

        END
