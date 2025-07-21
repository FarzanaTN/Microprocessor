        AREA data, DATA, READWRITE
        ALIGN 4

num1       DCD     48              ; First input number
num2       DCD     18              ; Second input number
gcd_result DCD     0               ; To store the GCD result

        AREA code, CODE, READONLY
        ENTRY
        EXPORT main

main
        LDR     r0, =num1          ; r0 = &num1
        LDR     r0, [r0]           ; r0 = num1
        LDR     r1, =num2          ; r1 = &num2
        LDR     r1, [r1]           ; r1 = num2

        BL      Find_GCD           ; Call function: result in r2

        LDR     r3, =gcd_result
        STR     r2, [r3]           ; Store GCD result into memory

stop
        B       stop               ; Infinite loop to end program

; -------------------------------------------------------
; FUNCTION: Find_GCD
; Description:
;   Uses Euclid’s Algorithm to compute GCD of two numbers.
; Inputs:
;   r0 = a, r1 = b
; Output:
;   r2 = GCD(a, b)
; Registers used:
;   r3 = remainder temp
; -------------------------------------------------------
Find_GCD
        PUSH    {r3, lr}

loop
        CMP     r1, #0             ; while b != 0
        BEQ     done               ; if b == 0 → GCD is a

        ; Compute a % b using: r3 = a - (a / b) * b
        UDIV    r2, r0, r1         ; r2 = a / b
        MLS     r3, r2, r1, r0     ; r3 = a - (r2 * b) → remainder

        ; Prepare for next iteration
        MOV     r0, r1             ; a = b
        MOV     r1, r3             ; b = remainder
        B       loop

done
        MOV     r2, r0             ; Final GCD in r2
        POP     {r3, pc}
