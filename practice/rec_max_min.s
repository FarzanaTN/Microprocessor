        AREA    data, DATA, READWRITE
        ALIGN   4

array   DCD     7, 2, 10, 3, 5, 1, 9
n       DCD     7           ; number of elements

maxval  DCD     0
minval  DCD     0

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        LDR     r0, =array      ; r0 = pointer to array
        MOV     r1, #0          ; r1 = start index = 0
        LDR     r2, =n
        LDR     r2, [r2]        ; r2 = array size

        BL      find_max_min    ; result: r0 = max, r1 = min

        LDR     r3, =maxval
        STR     r0, [r3]        ; store max
        LDR     r3, =minval
        STR     r1, [r3]        ; store min

stop
        B       stop

;---------------------------------------------------
; Recursive function: find_max_min
; Inputs:
;   r0 = pointer to array
;   r1 = current index
;   r2 = size of array
; Output:
;   r0 = max
;   r1 = min
; Uses: r3–r6, lr
;---------------------------------------------------

find_max_min
        PUSH    {r3-r6, lr}

        CMP     r1, r2
        BGE     base_case

        ; r3 = current element = array[r1]
        LDR     r3, [r0, r1, LSL #2]

        ; Recursive call: find_max_min(array, index + 1)
        ADD     r1, r1, #1
        BL      find_max_min

        ; r0 = max from recursion, r1 = min from recursion
        ; r3 = current element

        ; Compare r3 (current) with max (r0)
        CMP     r3, r0
        MOVGT   r0, r3          ; update max if current > max

        ; Compare r3 with min (r1)
        CMP     r3, r1
        MOVLT   r1, r3          ; update min if current < min

        POP     {r3-r6, lr}
        BX      lr

base_case
        ; At end of array: return big min and small max (no update)
        ; or could return last element as both min and max
        ; But since we checked index >= size, return -INF and +INF doesn't help
        ; Instead: go backward — this base case should be when index == size - 1

        SUB     r1, r1, #1
        LDR     r3, [r0, r1, LSL #2]
        MOV     r0, r3          ; max = element
        MOV     r1, r3          ; min = element
        POP     {r3-r6, lr}
        BX      lr

        END
