        ; Define data section
        AREA    data, DATA, READWRITE
        ALIGN   4
          DCD 0           ; Output

        ; Define code section
        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main
        ; Data Section
        AREA    data, DATA, READWRITE
        ALIGN   4

hex_table   DCB "0", "1", "2", "3", "4", "5", "6", "7"
            DCB "8", "9", "A", "B", "C", "D", "E", "F"
newline     DCB 0x0D, 0x0A, 0  ; CR LF Null

        ; Code Section
        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

        ; Semihosting call to output a character
        ; r0 = reason code (0x03 for writec)
        ; r1 = pointer to character

main
        LDR     r4, =hex_table      ; Pointer to hex characters
        MOV     r5, #0              ; Counter i = 0

loop
        CMP     r5, #16             ; While i < 16
        BEQ     done

        ; Get address of hex_table[i]
        ADD     r1, r4, r5

        ; Write character to console
        MOV     r0, #0x03           ; SYS_WRITE0 (write character)
        BKPT    0xAB                ; Semihosting call

        ; Write newline (optional after each character)
        ; Uncomment below if you want newline after each digit
        ; LDR     r1, =newline
        ; MOV     r0, #0x04         ; SYS_WRITE0 (write string)
        ; BKPT    0xAB

        ADD     r5, r5, #1          ; i++

        B       loop

done
        B       done                ; Infinite loop

        END

main
stop
        B       stop             ; Infinite loop to halt program

        END
