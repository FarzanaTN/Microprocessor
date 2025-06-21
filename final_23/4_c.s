        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        MOV     r0, #0xAC       ; data = 0xAC = 10101100b
        MOV     r1, #0          ; count = 0

loop
        CMP     r0, #0
        BEQ     done            ; while (data)

        SUB     r2, r0, #1      ; r2 = data - 1
        AND     r0, r0, r2      ; data = data & (data - 1)
        ADD     r1, r1, #1      ; count++

        B       loop

done
        B       done            ; Infinite loop to end program

        END

