        AREA    data, DATA, READWRITE
        ALIGN   4
array   SPACE   400             ; 100 integers (4 bytes each) → 100 × 4 = 400 bytes
seed    DCD     25              ; Initial seed
n       DCD     100             ; Upper bound for random numbers
min     DCD     0
sum     DCD     0

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        ; Load array base address and n value
        LDR     r4, =array      ; r4 points to array
        LDR     r5, =n
        LDR     r1, [r5]        ; r1 = n (max random value)
        MOV     r6, #0          ; r6 = loop counter i
        MOV     r7, #0          ; r7 = sum
        MOV     r8, #0x7FFFFFFF ; r8 = min (initialize to max positive int)

fill_array
        CMP     r6, #100
        BEQ     done_filling

        ; Get random number
        BL      Random          ; result in r0

        ; Store in array
        STR     r0, [r4, r6, LSL #2]  ; array[i] = r0

        ; Add to sum
        ADD     r7, r7, r0

        ; Update min
        CMP     r0, r8
        MOVLT   r8, r0

        ; i++
        ADD     r6, r6, #1
        B       fill_array

done_filling
        ; Store sum and min
        LDR     r9, =sum
        STR     r7, [r9]
        LDR     r10, =min
        STR     r8, [r10]

        ; Done
stop
        B       stop

; -----------------------------------------------
; Random function (same as in image, modified slightly)
Random
        SUB sp, sp, #8
        STR lr, [sp, #0]           ; Save return address

        LDR r3, =seed
        LDR r0, [r3]               ; Load old seed

Reset
        ADD r0, r0, #137
        EOR r0, r0, r0, ROR #13    ; New seed
        LSR r0, r0, #1             ; Make positive
        STR r0, [r3]               ; Save new seed

        MOV r3, r1                 ; r1 = upper bound (n)
        CMP r1, #0
        BEQ NoRange                ; Prevent divide by 0

        ; r0 = seed, r1 = n
        MOV r2, r0
        BL __aeabi_idiv            ; r0 / r1 → result in r0
        MUL r2, r0, r1             ; r2 = (r0/r1)*r1
        SUB r0, r2, r0             ; r0 = remainder (seed % n)
        ADD r0, r0, #1             ; random in 1 to n

NoRange
        LDR lr, [sp, #0]
        ADD sp, sp, #8
        BX lr
