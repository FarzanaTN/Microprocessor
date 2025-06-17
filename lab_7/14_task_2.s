        AREA    data, DATA, READWRITE
        ALIGN   4
numbers DCD     1, 2, 3, 4, 0     ; the numbers array
n       DCD     5                   ; the number of elements
result DCD 0

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        LDR     r0, =numbers        ; r0 -> pointer to numbers array
        LDR     r1, =n              ; r1 -> pointer to n
        LDR     r2, [r1]            ; r2 = value of n
        MOV     r3, #1              ; r3 = loop index (starts from 1)
        LDR     r4, [r0]            ; r4 = sum = numbers[0]

loop
        CMP     r3, r2              ; if r3 == n, done
        BEQ     stop

        ADD     r0, r0, #4          ; move to next number
        LDR     r5, [r0]            ; r5 = current number
        ADD     r4, r4, r5          ; r4 = r4 + r5

        ADD     r3, r3, #1          ; increment loop index
        B       loop


stop
        LDR r0, =result
        STR r4, [r0]

        B       stop                ; infinite loop to stop

        END
