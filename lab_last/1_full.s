        AREA    data, DATA, READWRITE
        ALIGN   4

ROWS    EQU     3
COLS    EQU     3
SIZE    EQU     ROWS * COLS

array   DCD     1, 2, 3
        DCD     4, 5, 6
        DCD     7, 8, 9

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        LDR     R4, =array      ; R4 holds base address of array

        MOV     R0, #0          ; R0 = row = 0

row_loop
        CMP     R0, #ROWS
        BGE     end_program     ; If row >= ROWS, end

        MOV     R1, #0          ; R1 = col = 0

col_loop
        CMP     R1, #COLS
        BGE     next_row        ; If col >= COLS, go to next row

        ; Compute offset = ((row * COLS) + col) * 4
        MOV     R5, #COLS
        MUL     R2, R0, R5
  ; R2 = row * COLS
        ADD     R2, R2, R1      ; R2 = (row * COLS + col)
        LSL     R2, R2, #2      ; R2 = offset in bytes

        LDR     R3, [R4, R2]    ; R3 = array[row][col]

        ; (You can do something with R3 here like store/print/debug...)

        ADD     R1, R1, #1      ; col++
        B       col_loop

next_row
        ADD     R0, R0, #1      ; row++
        B       row_loop

end_program
stop
        B       stop            ; infinite loop to stop

        END
