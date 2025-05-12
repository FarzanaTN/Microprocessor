        AREA    data, DATA, READWRITE
        ALIGN   4



        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        MOV r0, #0x1101
        MOV r1, #0x1011

        ; ans = 11000
        ADD r2, r0, r1 ;NZCV flag check--> 1010

stop
        B       stop            ; Infinite loop to halt program

        END
