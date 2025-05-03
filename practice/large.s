;find max from numbers
    AREA STACK, NOINIT, READWRITE, ALIGN = 3
    SPACE 1024

    AREA |.vector|, CODE, READONLY
    EXPORT __Vectors
__Vectors
    DCD __stack_top             ; Initial value of stack pointer (top of the stack)
    DCD Reset_Handler           ; Address of Reset handler (entry point after reset)
    DCD 0                       ; NMI handler (placeholder)
    DCD 0

    ;Define the top of the stack
    AREA |.text|, CODE, READONLY
__stack_top EQU STACK + 1024 ;caluculate the top of the stack(end of 1KB stack)

    ;Define the reset handler function
    EXPORT Reset_Handler
Reset_Handler
    BL main                     ; Branch with link to the main (Call main)
    B .                         ; Loop forever if main returns

    AREA |.data|, DATA, READONLY
numbers DCD 1, -2, 0, 4, 5
n       DCD 5

    AREA |.data2|, DATA, READWRITE
large 

    AREA |.text|, CODE, READWRITE
main
    LDR r0, =numbers    ; r0 points to numbers array
    LDR r1, =n
    LDR r1, [r1]         ; r1 = number of elements (5)

    LDR r2, [r0]         ; Load first number into r2 (initialize largest)

    MOV r3, #1           ; r3 = loop index (start from second element)



LOOP 
    CMP r3, r1           ; if index == n, end of array
    BEQ DONE

    LDR r4, [r0, r3, LSL #2] ; Load numbers[r3]
    CMP r4, r2
    BLS SKIP             ; If r4 <= r2, skip updating
    MOV r2, r4           ; Else, update largest = r4

SKIP
    ADD r3, r3, #1       ; r3++
    B LOOP

DONE
    LDR r5, =large
    STR r2, [r5]         ; Store largest number into variable "large"


STOP
    B STOP
    END