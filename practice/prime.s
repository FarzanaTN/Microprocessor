        AREA data, DATA, READWRITE
        ALIGN   4

SIZE    EQU     6

numbers     DCD     11, 2, 3, 4, 5, 6      ; list of numbers
is_prime_array    DCD     0, 0, 0, 0, 0, 0      ; output: 1 if prime, 0 otherwise

        AREA code, CODE, READONLY
        ENTRY
        EXPORT main

main
        LDR     r4, =numbers        ; r4 = pointer to numbers array
        LDR     r5, =is_prime_array      ; r5 = pointer to output array
        MOV     r6, #0              ; r6 = loop counter (index)

loop
        CMP     r6, #SIZE
        BGE     end_program         ; if index >= SIZE, exit

        LDR     r0, [r4, r6, LSL #2] ; r0 = numbers[index]
        BL      prime               ; call prime(r0), result in r0

        STR     r0, [r5, r6, LSL #2] ; store result in is_prime[index]

        ADD     r6, r6, #1
        B       loop

end_program
stop
        B       stop                ; halt

;------------------------------------------------------
; prime function
; Input: r0 = number
; Output: r0 = 1 if prime, 0 if not
; Uses: r1–r3
;------------------------------------------------------

prime
        PUSH    {r1-r3, lr}

        CMP     r0, #2
        BLT     not_prime           ; 0 and 1 are not prime

        MOV     r1, #2              ; divisor = 2

check_loop
        MOV     r2, r0
        CMP     r1, r2
        BGE     is_prime            ; if divisor >= number, it's prime

        UDIV    r3, r0, r1          ; r3 = number / divisor
        MUL     r3, r3, r1          ; r3 = (number / divisor) * divisor
        CMP     r3, r0
        BEQ     not_prime           ; divisible ⇒ not prime

        ADD     r1, r1, #1
        B       check_loop

is_prime
        MOV     r0, #1
        B       done

not_prime
        MOV     r0, #0

done
        POP     {r1-r3, lr}
        BX      lr

        END
