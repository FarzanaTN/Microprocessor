        AREA    data, DATA, READWRITE
        ALIGN   4
ch      DCD     0x47          ; Example input character 'G' (you can change it)
        
        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        LDR     r0, =ch       ; Load address of ch
        LDR     r0, [r0]      ; Load character value into r0

        ; Subroutine logic starts here

        MOV     r1, #0x41     ; ASCII 'A'
        CMP     r0, r1
        BLT     check_lower   ; If r0 < 'A', check lowercase

        MOV     r1, #0x5A     ; ASCII 'Z'
        CMP     r0, r1
        BLE     is_alpha      ; If r0 <= 'Z', it's uppercase

check_lower
        MOV     r1, #0x61     ; ASCII 'a'
        CMP     r0, r1
        BLT     not_alpha     ; If r0 < 'a', not alphabet

        MOV     r1, #0x7A     ; ASCII 'z'
        CMP     r0, r1
        BLE     is_alpha      ; If r0 <= 'z', it's lowercase

not_alpha
        MOV     r2, #0        ; Force Zero flag to 0
        CMP     r2, #1        ; Z = 0
        B       stop

is_alpha
        CMP     r0, r0        ; Set Zero flag = 1
        B       stop

stop
        B       stop

        END
;write down the arm instruxtion to multilply the content of register r0 by nine and store the product in r7. later write the equivalent single instruction to perform the same operation witout using any multiplication instruction