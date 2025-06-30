        AREA    data, DATA, READWRITE
        ALIGN   4
numbers DCD     1, 2, 0, 7, 10     ; the numbers array
n       DCD     5                   ; the number of elements

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        LDR     r0, =numbers        ; r0 = pointer to numbers array
        LDR     r1, =n              ; r1 = pointer to n
        LDR     r1, [r1]            ; r1 = value of n

        BL      calcAvg             ; call calcAvg(r0, r1), result in r0
        MOV     r6, r0              ; store avg in r6

stop
        B       stop                ; infinite loop to stop

; --------------------------------------------------------
; Function: calcAvg
; Input:
;   r0 = pointer to numbers array
;   r1 = number of elements
; Output:
;   r0 = average = sum / n
; Uses:
;   r2, r3, r4, r5
; --------------------------------------------------------

calcAvg
        PUSH    {r2-r5, lr}         ; Save used registers and return address

        MOV     r2, #0              ; r2 = loop index
        MOV     r3, #0              ; r3 = sum

loop_sum
        CMP     r2, r1              ; if index == n, done
        BEQ     compute_avg

        LDR     r4, [r0, r2, LSL #2] ; r4 = numbers[r2]
        ADD     r3, r3, r4          ; sum += numbers[r2]
        ADD     r2, r2, #1          ; index++
        B       loop_sum

compute_avg
        UDIV    r0, r3, r1          ; r0 = sum / n (return value)
        POP     {r2-r5, lr}         ; Restore registers
        BX      lr                  ; return to caller

        END
