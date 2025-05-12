        AREA    data, DATA, READWRITE
        ALIGN   4

; -------- Input Data --------
dividend8       DCB     100         ; 8-bit: 100
divisor8        DCB     5           ; 8-bit: 5
result8         DCB     0

dividend16      DCW     1000        ; 16-bit: 1000
divisor16       DCW     10          ; 16-bit: 10
result16        DCW     0

dividend32      DCD     100000      ; 32-bit: 100000
divisor32       DCD     100         ; 32-bit: 100
result32        DCD     0

 ; Data Section (Store dividend and divisor)
dividend64_low  DCD     0x00000000         ; Low part of 64-bit dividend
dividend64_high DCD     0x00000002         ; High part of 64-bit dividend
divisor64       DCD     2                 ; Divisor (32-bit)

        ; Storage for result
result_quotient DCD     0x0               ; Space for quotient
result_remainder DCD    0x0               ; Space for remainder
        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main

; ---------- 8-bit Division ----------
        LDR     R0, =dividend8
        LDRB    R1, [R0]
        LDRB    R2, [R0, #1]       ; divisor
        UDIV    R3, R1, R2
        STRB    R3, [R0, #2]

; ---------- 16-bit Division ----------
        LDR     R0, =dividend16
        LDRH    R1, [R0]
        LDRH    R2, [R0, #2]
        UDIV    R3, R1, R2
        STRH    R3, [R0, #4]

; ---------- 32-bit Division ----------
        LDR     R0, =dividend32
        LDR     R1, [R0]
        LDR     R2, [R0, #4]
        UDIV    R3, R1, R2
        STR     R3, [R0, #8]

; -----------------------------
        ; Dividend is stored in:
        ; dividend64_low  = 0x00000000  (Low part of dividend)
        ; dividend64_high = 0x00000002  (High part of dividend)
        ; divisor64       = 2           (Divisor)
        ; -----------------------------

        LDR     R0, =dividend64_low    ; Load low part of dividend (R0)
        LDR     R1, =dividend64_high   ; Load high part of dividend (R1)
        LDR     R2, =divisor64         ; Load divisor (R2)

        ; Step 1: Divide high part of dividend by divisor
        UDIV    R3, R1, R2             ; R3 = Quotient of high part
        MUL     R4, R3, R2             ; R4 = High quotient * divisor (partial product)
        SUB     R5, R1, R4             ; R5 = Remainder from high part division

        ; Step 2: Combine low part of dividend with remainder
        ADD     R5, R5, R0             ; Combine remainder with low part

        ; Step 3: Divide combined remainder by divisor to get the low part of the quotient
        UDIV    R6, R5, R2             ; R6 = Quotient from low part
        MUL     R7, R6, R2             ; R7 = Low quotient * divisor (partial product)
        SUB     R8, R5, R7             ; R8 = Remainder from low part division

        ; Store the result (quotient and remainder)
        LDR     R0, =result_quotient   ; Load address for quotient storage
        STR     R3, [R0]               ; Store high part of quotient (R3)
        STR     R6, [R0, #4]           ; Store low part of quotient (R6)

        LDR     R0, =result_remainder  ; Load address for remainder storage
        STR     R8, [R0]               ; Store remainder (R8)

stop
        B       stop              ; Infinite loop to stop execution

        END
