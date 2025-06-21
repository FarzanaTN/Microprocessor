;write an arm code whcih can rotate 64 bit binary numbrt to 5 places on left. dont use built in rotation inst
        AREA code, CODE, READONLY
        ENTRY
        EXPORT main

main
        ; Let's say 64-bit number is in r1:r0 (r1 = high, r0 = low)
        LDR     r0, =0x89ABCDEF      ; lower 32 bits
        LDR     r1, =0x12345678      ; upper 32 bits

        ; Left shift both registers by 5 bits
        ; Shift r0 left by 5 bits
        LSL     r2, r0, #5           ; r2 = r0 << 5

        ; Get top 5 bits from r0 to be added to r1 shift
        LSR     r3, r0, #27          ; r3 = r0 >> (32 - 5)

        ; Shift r1 left by 5 bits and OR with r3 (from r0)
        LSL     r4, r1, #5           ; r4 = r1 << 5
        ORR     r4, r4, r3           ; r4 = new high 32 bits

        ; Get top 5 bits from r1 to be wrapped into r0
        LSR     r5, r1, #27          ; r5 = r1 >> (32 - 5)
        ORR     r2, r2, r5           ; r2 = new low 32 bits

        ; Now:
        ; r4 = rotated upper 32 bits
        ; r2 = rotated lower 32 bits

stop
        B stop

        END
