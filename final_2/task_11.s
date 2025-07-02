        AREA    data, DATA, READWRITE
        ALIGN   4
numbers     DCD     1, 2, 3, 4, 5           ; example array
n           DCD     5                       ; length
k_val       DCD     2                       ; rotation offset k
temp_buf    SPACE   20                      ; temporary buffer for max 5 elements * 4 bytes

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main
        EXPORT  rotate_k

main
        LDR     r0, =numbers              ; base address of array
        LDR     r1, =n                    ; length pointer
        LDR     r1, [r1]                  ; length value

        LDR     r2, =k_val                ; rotation offset pointer
        LDR     r2, [r2]                  ; k value

        BL      rotate_k                  ; call rotation function

stop
        B       stop                      ; infinite loop

; -----------------------------------------
; Function: rotate_k
; Input: 
;   R0 = base address of array
;   R1 = length
;   R2 = k (rotation offset)
; Output: Array rotated left by k positions in-place
; -----------------------------------------
rotate_k
        ; Check k >= length or k == 0, then no rotation needed
        CMP     r2, #0
        BEQ     done
        CMP     r2, r1
        BGE     done

        ; Save k to r5, length to r6 for convenience
        MOV     r5, r2
        MOV     r6, r1

        LDR     r7, =temp_buf             ; pointer to temporary buffer

        ; Copy first k elements into temp buffer
        MOV     r3, #0                   ; index i = 0
copy_to_temp
        CMP     r3, r5                   ; i < k?
        BGE     copy_shift

        LDR     r4, [r0, r3, LSL #2]
        STR     r4, [r7, r3, LSL #2]
        ADD     r3, r3, #1
        B       copy_to_temp

copy_shift
        ; Shift elements from index k to end to front
        MOV     r3, r5                   ; index i = k (start source)
        MOV     r8, #0                   ; index j = 0 (destination)

shift_loop
        CMP     r3, r6                   ; while i < length
        BGE     copy_back

        LDR     r4, [r0, r3, LSL #2]
        STR     r4, [r0, r8, LSL #2]
        ADD     r3, r3, #1
        ADD     r8, r8, #1
        B       shift_loop

copy_back
        ; Copy saved k elements from temp buffer to end of array
        MOV     r3, #0                   ; index i = 0
        MOV     r9, r6                   ; total length
loop_copy_back
        CMP     r3, r5                   ; i < k?
        BGE     done

        LDR     r4, [r7, r3, LSL #2]
        STR     r4, [r0, r8, LSL #2]
        ADD     r3, r3, #1
        ADD     r8, r8, #1
        B       loop_copy_back

done
        BX      lr                      ; return

        END
