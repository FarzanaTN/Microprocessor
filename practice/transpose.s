        AREA    data, DATA, READWRITE
        ALIGN   4

ROWS    EQU     3
COLS    EQU     3
SIZE    EQU     ROWS * COLS

array   DCD     1, 2, 3
        DCD     4, 5, 6
        DCD     7, 8, 9

transpose DCD   0, 0, 0
         DCD    0, 0, 0
         DCD    0, 0, 0

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        LDR     R4, =array          ; Base of original matrix
        LDR     R5, =transpose      ; Base of transpose matrix

        MOV     R0, #0              ; row = 0

row_loop
        CMP     R0, #ROWS
        BGE     end_program

        MOV     R1, #0              ; col = 0

col_loop
        CMP     R1, #COLS
        BGE     next_row

        ; Calculate offset of array[row][col]
        MOV     R6, #COLS
        MUL     R2, R0, R6          ; R2 = row * COLS
        ADD     R2, R2, R1          ; R2 = row * COLS + col
        LSL     R2, R2, #2          ; R2 = offset in bytes

        LDR     R3, [R4, R2]        ; R3 = array[row][col]

        ; Store into transpose[col][row]
        MOV     R6, #ROWS
        MUL     R7, R1, R6          ; R7 = col * ROWS
        ADD     R7, R7, R0          ; R7 = col * ROWS + row
        LSL     R7, R7, #2          ; R7 = offset in bytes

        STR     R3, [R5, R7]        ; transpose[col][row] = R3

        ADD     R1, R1, #1
        B       col_loop

next_row
        ADD     R0, R0, #1
        B       row_loop

end_program
stop
        B       stop

        END
