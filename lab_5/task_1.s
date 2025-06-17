        ; Define data section
        AREA    data, DATA, READWRITE
        ALIGN 4

w       DCD     0x10            ; Variable W = 0x10
x       DCD     0x11            ; Variable X = 0x11
y       DCD     0x12            ; Variable Y = 0x12
z       DCD     0x13            ; Variable Z = 0x13           

        ; Define code section
        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        ; Load the value of W into r1
        LDR r0, =w              ; Load address of w
        LDR r1, [r0]            ; r1 = W

        ; Load the value of X into r2
        LDR r0, =x              ; Load address of x
        LDR r2, [r0]            ; r2 = X

        ; Load the value of Y into r3
        LDR r0, =y              ; Load address of y
        LDR r3, [r0]            ; r3 = Y

        ; Load the value of Z into r4
        LDR r0, =z              ; Load address of z
        LDR r4, [r0]            ; r4 = Z

        ; Compute Y AND Z -> r0
        AND r0, r3, r4          ; r0 = Y.Z (bitwise AND)

        ; Compute NOT of r0 (i.e., ~(Y.Z)) -> r0
        MVN r0, r0              ; r0 = ~(Y.Z) (bitwise NOT)

        ; Compute W AND X -> r5
        AND r5, r1, r2          ; r5 = W.X (bitwise AND)

        ; Compute (W.X) OR ~(Y.Z) -> r5 (final result stored in r5)
        ORR r5, r5, r0          ; r5 = (W.X) + ~(Y.Z) (bitwise OR)

loop
        B       loop            ; Infinite loop to end program execution

        END
