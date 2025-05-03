;factorial of n
        AREA STACK, NOINIT, READWRITE
        ALIGN 4
stack_space SPACE 0x100        ; Allocate stack

        AREA CODE, CODE, READONLY
        ENTRY
        EXPORT main

main
        LDR SP, =stack_space + 0x100  ; Initialize stack pointer

        MOV R0, #4            ; Set up N = 4
        STR R0, [SP, #-4]!    ; Push N
        SUB SP, SP, #4        ; Reserve space for result (4 bytes)
        BL Factorial          ; Call Factorial(4)
        LDR R0, [SP], #4      ; Pop result into R0
        ADD SP, SP, #4        ; Discard N
        B stop                ; Done

; ================================
; Function: Factorial
; Input: N is 16 bytes into frame (IP + 16)
; Output: result stored 16 bytes into frame (IP + 16)
; ================================
Factorial
        ; Save registers and setup stack frame
        STR LR, [SP, #-4]!    ; Save LR
        STR IP, [SP, #-4]!    ; Save frame pointer
        STR R0, [SP, #-4]!    ; Save R0
        STR R1, [SP, #-4]!    ; Save R1

        MOV IP, SP            ; New frame pointer
        LDR R0, [IP, #16]     ; Load N (16 bytes above current IP)
        CMP R0, #1
        BGT recurse_case

        ; Base case: Factorial(0 or 1) = 1
        MOV R0, #1
        STR R0, [IP, #16]     ; Store result at IP+16
        B end_factorial

recurse_case
        ; Recursive case: N * Factorial(N - 1)
        SUB R0, R0, #1        ; R0 = N - 1
        STR R0, [SP, #-4]!    ; Push N - 1
        SUB SP, SP, #4        ; Reserve space for result
        BL Factorial
        LDR R1, [SP], #4      ; Load result of Factorial(N - 1)
        ADD SP, SP, #4        ; Discard N - 1

        LDR R0, [IP, #16]     ; Load original N
        MUL R0, R0, R1        ; R0 = N * Fact(N - 1)
        STR R0, [IP, #16]     ; Store result at IP+16

end_factorial
        ; Restore registers and return
        LDR R1, [SP], #4      ; Restore R1
        LDR R0, [SP], #4      ; Restore R0
        LDR IP, [SP], #4      ; Restore IP
        LDR PC, [SP], #4      ; Return (restores LR into PC)

stop
        B stop                ; Infinite loop to stop
