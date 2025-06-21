        AREA    data, DATA, READWRITE
        ALIGN   4

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
    MOV r3, #0x0ACB       ; r3 = 2763
    MOV r5, #0xACB5       ; r5 = 44213
    MOV r6, #0x0035       ; r6 = 53
    MOV r0, #0x0003       ; r0 = 3

    SUB r3, r5, r6, LSL r0 ; r3 = r5 - (r6 << 3) = 44213 - 424 = 43789

stop
    B       stop           ; Infinite loop

        END
