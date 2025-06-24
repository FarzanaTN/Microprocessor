        AREA data, DATA, READWRITE
        ALIGN 4

; A[2][3]
A       DCD     1, 2, 3
        DCD     4, 5, 6

; B[3][2]
B       DCD     7, 8
        DCD     9, 10
        DCD     11, 12

; C[2][2] - result matrix
C       DCD     0, 0
        DCD     0, 0

        AREA code, CODE, READONLY
        ENTRY
        EXPORT main

M       EQU     2      ; Rows in A
N       EQU     3      ; Cols in A and Rows in B
P       EQU     2      ; Cols in B

main
        LDR     R4, =A         ; R4 = base of A
        LDR     R5, =B         ; R5 = base of B
        LDR     R6, =C         ; R6 = base of C

        MOV     R0, #0         ; i = 0 (row of A)

row_loop
        CMP     R0, #M
        BGE     done

        MOV     R1, #0         ; j = 0 (col of B)

col_loop
        CMP     R1, #P
        BGE     next_row

        MOV     R2, #0         ; sum = 0
        MOV     R3, #0         ; k = 0 (shared dimension)

dot_product_loop
        CMP     R3, #N
        BGE     store_result

        ; A[i][k] = A[i * N + k]
        MOV     R7, #N
        MUL     R8, R0, R7
        ADD     R8, R8, R3
        LSL     R8, R8, #2
        LDR     R9, [R4, R8]

        ; B[k][j] = B[k * P + j]
        MOV     R7, #P
        MUL     R10, R3, R7
        ADD     R10, R10, R1
        LSL     R10, R10, #2
        LDR     R11, [R5, R10]

        ; sum += A[i][k] * B[k][j]
        MUL     R12, R9, R11
        ADD     R2, R2, R12

        ADD     R3, R3, #1
        B       dot_product_loop

store_result
        ; C[i][j] = sum → offset = (i * P + j) * 4
        MOV     R7, #P
        MUL     R8, R0, R7
        ADD     R8, R8, R1
        LSL     R8, R8, #2
        STR     R2, [R6, R8]

        ADD     R1, R1, #1
        B       col_loop

next_row
        ADD     R0, R0, #1
        B       row_loop

done
stop
        B       stop

        END
