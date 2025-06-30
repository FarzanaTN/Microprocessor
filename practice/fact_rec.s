        AREA    data, DATA, READWRITE
        ALIGN   4
n       DCD     5           ; the number to compute factorial of
fact    DCD     0           ; to store the result

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        LDR     r0, =n      ; r0 -> &n
        LDR     r1, [r0]    ; r1 = n
        BL      factorial   ; call factorial(n), result in r0

        LDR     r2, =fact   ; r2 -> &fact
        STR     r0, [r2]    ; store result in fact

stop
        B       stop        ; infinite loop to stop execution

; -----------------------------------------
; Function: factorial
; Input:    r1 = n
; Output:   r0 = n!
; Registers used: r1, r2, lr
; Stack: saves r1, r2, lr
; -----------------------------------------
factorial
        PUSH    {r1, r2, lr}     ; save registers

        CMP     r1, #1
        BLE     base_case        ; if n <= 1, return 1

        MOV     r2, r1           ; r2 = current n
        SUB     r1, r1, #1       ; n = n - 1
        BL      factorial        ; call factorial(n-1)
        MUL     r0, r0, r2       ; result = r2 * factorial(n-1)
        B       done

base_case
        MOV     r0, #1           ; factorial(0) or (1) = 1

done
        POP     {r1, r2, lr}     ; restore registers
        BX      lr               ; return to caller
