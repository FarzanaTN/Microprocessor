        ; Define data section
        AREA    data, DATA, READWRITE
        ALIGN   4

A           DCD     15              ; First signed integer
B           DCD     20              ; Second signed integer
RESULT      DCD     0               ; To store comparison result

        ; Define code section
        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        LDR     r0, =A              ; Load address of A
        LDR     r1, [r0]            ; r1 = A

        LDR     r2, =B              ; Load address of B
        LDR     r3, [r2]            ; r3 = B

        CMP     r1, r3              ; Compare A (r1) with B (r3)

        ; Use conditional execution for signed integers
        MOVGT   r4, #1              ; A > B -> result = 1
        MOVEQ   r4, #0              ; A == B -> result = 0
        MOVLT   r4, #-1             ; A < B -> result = -1

        LDR     r5, =RESULT         ; Address to store result
        STR     r4, [r5]            ; Store result

done
        B       done                ; Infinite loop to halt

        END
