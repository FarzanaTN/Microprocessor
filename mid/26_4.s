        AREA data, DATA, READWRITE
        ALIGN 4

N       DCD 5
c       DCD 1, 2, 3, 4, 5
x       DCD 5, 4, 3, 2, 1

        AREA code, CODE, READONLY
        ENTRY
        EXPORT main

main
        LDR     r0, =N          ; Load address of N
        LDR     r1, [r0]        ; Load N into r1
        MOV     r2, #0          ; i = 0
        MOV     r3, #0          ; f = 0

        LDR     r4, =c          ; Load base address of c into r4
        LDR     r5, =x          ; Load base address of x into r5

loop
        CMP     r2, r1          ; Compare i with N
        BGE     stop            ; if i >= N, exit loop

        LDR     r6, [r4, r2, LSL #2] ; r6 = c[i]
        LDR     r7, [r5, r2, LSL #2] ; r7 = x[i]
        MUL     r8, r6, r7          ; r8 = c[i] * x[i]
        ADD     r3, r3, r8          ; f += c[i] * x[i]

        ADD     r2, r2, #1          ; i++

        B       loop

stop
        B       stop            ; Infinite loop to halt
        END
