        AREA data, DATA, READWRITE
        ALIGN 4
array1  DCD 1, 2, 3, 4
array2  DCD 5, 6, 7, 8
result  DCD 0, 0, 0, 0
length  EQU 4

        AREA code, CODE, READONLY
        ENTRY
        EXPORT main

main
        LDR     r0, =array1
        LDR     r1, =array2
        LDR     r2, =result
        MOV     r3, #1               

loop
        CMP     r3, #length
        BEQ     done

        
        LDR r4, [r0]
        LDR r5, [r1]
        ADD r4, r4, r5
        STR r4, [r2]
        ADD r0, r0, #4
        ADD r1, r1, #4
        ADD r2, r2, #4
        B       loop

done
        B       .

        END
