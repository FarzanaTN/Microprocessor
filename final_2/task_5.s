        AREA    data, DATA, READWRITE
        ALIGN   4
numbers     DCD     7, 2, 9, 1, 5       ; sample array
n           DCD     5                   ; number of elements
min_val     DCD     0                   ; to store minimum
max_val     DCD     0                   ; to store maximum

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main
        EXPORT  find_min_max

main
        LDR     r0, =numbers            ; r0 -> base address of array
        LDR     r1, =n                  ; r1 -> pointer to length
        LDR     r1, [r1]                ; r1 = value of length

        BL      find_min_max            ; call function

        LDR     r5, =min_val            ; r5 -> min_val location
        STR     r3, [r5]                ; store min

        LDR     r5, =max_val            ; r5 -> max_val location
        STR     r4, [r5]                ; store max

stop
        B       stop                    ; infinite loop to end

; -----------------------------------------
; Function: find_min_max
; Input : R0 = base address of array
;         R1 = length of array
; Output: R3 = min, R4 = max
; -----------------------------------------
find_min_max
        CMP     r1, #0                  ; if length is 0, exit
        BEQ     done

        LDR     r3, [r0]                ; r3 = min = first element
        LDR     r4, [r0]                ; r4 = max = first element

        MOV     r2, #1                  ; r2 = index = 1
        ADD     r0, r0, #4              ; move to second element

loop
        CMP     r2, r1                  ; if index == length, done
        BEQ     done

        LDR     r5, [r0]                ; r5 = current element

        CMP     r5, r3                  ; compare with min
        MOVLT   r3, r5                  ; if r5 < r3, update min

        CMP     r5, r4                  ; compare with max
        MOVGT   r4, r5                  ; if r5 > r4, update max

        ADD     r0, r0, #4              ; move to next element
        ADD     r2, r2, #1              ; increment index
        B       loop

done
        BX      lr                      ; return

        END
