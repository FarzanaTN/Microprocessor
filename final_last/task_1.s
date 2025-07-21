        AREA data, DATA, READWRITE
        ALIGN 4

n           DCD     10              ; Number of Fibonacci terms to generate
fib_array   SPACE   40              ; Reserve space for 10 integers (4 bytes each)

        AREA code, CODE, READONLY
        ENTRY
        EXPORT main

main
        LDR     r0, =n              ; r0 = &n
        LDR     r0, [r0]            ; r0 = n
        LDR     r1, =fib_array      ; r1 = &fib_array
        BL      Fibonacci_sequence ; call the function

stop
        B       stop                ; infinite loop

; -------------------------------------------------------
; FUNCTION: Fibonacci_sequence
; Input:
;   r0 = number of terms (n)
;   r1 = pointer to result array
; Output:
;   Stores n Fibonacci numbers into array at r1
; -------------------------------------------------------
Fibonacci_sequence
        PUSH    {r2-r5, lr}

        CMP     r0, #1
        BLT     end                 ; if n < 1, exit

        MOV     r2, #0              ; first Fibonacci = 0
        STR     r2, [r1]            ; fib[0] = 0

        CMP     r0, #1
        BEQ     end

        MOV     r3, #1              ; second Fibonacci = 1
        STR     r3, [r1, #4]        ; fib[1] = 1

        MOV     r4, #2              ; index i = 2

loop
        CMP     r4, r0              ; if i >= n, exit
        BGE     end

        ADD     r5, r2, r3          ; fib[i] = fib[i-2] + fib[i-1]
        STR     r5, [r1, r4, LSL #2] ; store fib[i]

        MOV     r2, r3              ; update previous values
        MOV     r3, r5

        ADD     r4, r4, #1          ; i++
        B       loop

end
        POP     {r2-r5, pc}
