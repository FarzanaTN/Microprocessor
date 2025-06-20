        AREA    data, DATA, READWRITE
        ALIGN   4

str     DCB     "madam", 0        ; test string (change to try other cases)
len     DCD     5                 ; length of the string (not including null terminator)
result  DCD     0                 ; 1 if palindrome, 0 if not

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        LDR     r0, =str          ; r0 = pointer to start of string
        LDR     r1, =len
        LDR     r1, [r1]          ; r1 = length of string
        SUB     r1, r1, #1        ; r1 = end index (last char)

        MOV     r2, #0            ; r2 = start index
        MOV     r3, #1            ; assume it is a palindrome (true)

check_loop
        CMP     r2, r1            ; if start >= end, done
        BGE     done

        LDRB    r4, [r0, r2]      ; r4 = str[start]
        LDRB    r5, [r0, r1]      ; r5 = str[end]
        CMP     r4, r5
        BNE     not_palindrome

        ADD     r2, r2, #1        ; start++
        SUB     r1, r1, #1        ; end--
        B       check_loop

not_palindrome
        MOV     r3, #0            ; set result to false (not palindrome)

done
        LDR     r6, =result
        STR     r3, [r6]          ; store result (1 = palindrome, 0 = not)
stop
        B       stop              ; infinite loop (end)

        END
