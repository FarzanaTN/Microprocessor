        AREA    data, DATA, READWRITE
        ALIGN   4

; 2D array of 3x3 integers initialized with sample values
array   DCD     1, 2, 3
        DCD     4, 5, 6
        DCD     7, 8, 9

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        ; R0 = row index, R1 = column index
        MOV     R0, #1              ; Row = 1
        MOV     R1, #2              ; Col = 2

        ; R2 = Number of columns (fixed at 3)
        MOV     R2, #3              ; NUM_COLS = 3

        ; Calculate offset = (row * NUM_COLS + col) * 4
        MUL     R3, R0, R2          ; R3 = row (i)* NUM_COLS(n)
        ADD     R3, R3, R1          ; R3 = (row * NUM_COLS) + col(j)
        LSL     R3, R3, #2          ; R3 = offset in bytes (multiply by 4)

        ; R4 = address of base of array
        LDR     R4, =array

        ; Access array[row][col]
        LDR     R5, [R4, R3]        ; R5 = value at array[row][col]

stop
        B       stop                ; infinite loop to stop

        END
