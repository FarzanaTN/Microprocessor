        AREA data, DATA, READWRITE
        ALIGN 4

n           DCD     47              ; Amount to make change for
coins       DCD     1, 5, 10, 25, 50 ; 5 coin types (ascending)
num_coins   DCD     5
min_count   DCD     0              ; Output: minimum number of coins

        AREA code, CODE, READONLY
        ENTRY
        EXPORT main

main
        BL      MinCoinChange
stop
        B       stop                ; infinite loop

; ---------------------------------------------------------------
; FUNCTION: MinCoinChange
; Description:
;   Uses Greedy algorithm to compute minimum number of coins
;   to make change for amount n using available coin types.
; Registers:
;   r0 = n (remaining amount)
;   r1 = pointer to coins array
;   r2 = number of coin types
;   r3 = current coin index (from largest to smallest)
;   r4 = current coin value
;   r5 = count for each coin
;   r6 = total coin count
; ---------------------------------------------------------------
MinCoinChange
        PUSH    {r1-r6, lr}

        LDR     r0, =n
        LDR     r0, [r0]            ; r0 = amount
        LDR     r1, =coins          ; r1 = &coins[0]
        LDR     r2, =num_coins
        LDR     r2, [r2]            ; r2 = number of coins
        MOV     r6, #0              ; r6 = total coin count
        SUB     r3, r2, #1          ; r3 = start from last coin index

loop_coin
        CMP     r3, #0
        BLT     done                ; if index < 0, stop

        LDR     r4, [r1, r3, LSL #2] ; r4 = coin value = coins[r3]
check_use
        CMP     r0, r4              ; if remaining amount >= coin
        BLT     next_coin

        ; r5 = how many times we can use coin r4
        UDIV    r5, r0, r4
        ; r0 = r0 - (r5 * r4)
        MUL     r7, r5, r4
        SUB     r0, r0, r7

        ADD     r6, r6, r5          ; add to total coin count

next_coin
        SUB     r3, r3, #1          ; move to next smaller coin
        B       loop_coin

done
        LDR     r7, =min_count
        STR     r6, [r7]            ; store result in memory

        POP     {r1-r6, pc}
