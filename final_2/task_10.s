        AREA    data, DATA, READWRITE
        ALIGN   4
arrayA      DCD     1, 4, 6              ; sorted array A
lenA        DCD     3
arrayB      DCD     2, 3, 5, 8           ; sorted array B
lenB        DCD     4
result      SPACE   28                   ; result array space for 7 integers (4*7 = 28 bytes)
totalLen    DCD     0                    ; to store final merged length

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main
        EXPORT  merge_array

main
        LDR     r0, =arrayA              ; base address of A
        LDR     r1, =lenA
        LDR     r1, [r1]                 ; length of A

        LDR     r2, =arrayB              ; base address of B
        LDR     r3, =lenB
        LDR     r3, [r3]                 ; length of B

        LDR     r4, =result              ; base of result array

        BL      merge_array              ; call merge_array

        LDR     r5, =totalLen
        STR     r0, [r5]                 ; store final result length

stop
        B       stop                     ; infinite loop

; -------------------------------------------------------
; Function: merge_array
; Inputs:
;   R0 = base A, R1 = len A
;   R2 = base B, R3 = len B
;   R4 = base of result array
; Output:
;   R0 = total elements in result
; -------------------------------------------------------
merge_array
        MOV     r5, #0                  ; i = indexA
        MOV     r6, #0                  ; j = indexB
        MOV     r7, #0                  ; k = indexResult

loop_merge
        CMP     r5, r1                  ; if i >= lenA
        BGE     copy_b_remaining

        CMP     r6, r3                  ; if j >= lenB
        BGE     copy_a_remaining

        ; Load A[i] into r8
        LDR     r8, [r0, r5, LSL #2]
        ; Load B[j] into r9
        LDR     r9, [r2, r6, LSL #2]

        CMP     r8, r9
        BLT     insert_from_a

        ; else: insert B[j]
        STR     r9, [r4, r7, LSL #2]
        ADD     r6, r6, #1              ; j++
        B       next_insert

insert_from_a
        STR     r8, [r4, r7, LSL #2]
        ADD     r5, r5, #1              ; i++

next_insert
        ADD     r7, r7, #1              ; k++
        B       loop_merge

copy_a_remaining
        CMP     r5, r1
        BGE     finish

        LDR     r8, [r0, r5, LSL #2]
        STR     r8, [r4, r7, LSL #2]
        ADD     r5, r5, #1
        ADD     r7, r7, #1
        B       copy_a_remaining

copy_b_remaining
        CMP     r6, r3
        BGE     finish

        LDR     r9, [r2, r6, LSL #2]
        STR     r9, [r4, r7, LSL #2]
        ADD     r6, r6, #1
        ADD     r7, r7, #1
        B       copy_b_remaining

finish
        MOV     r0, r7                  ; return total elements in R0
        BX      lr

        END
