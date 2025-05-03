;basic string operation 
    AREA STACK, NOINIT, READWRITE, ALIGN = 3
    SPACE 1024

    AREA |.vector|, CODE, READONLY
    EXPORT __Vectors
__Vectors
    DCD __stack_top             ; Initial value of stack pointer
    DCD Reset_Handler           ; Reset Handler
    DCD 0                       ; NMI Handler
    DCD 0

    AREA |.text|, CODE, READONLY
__stack_top EQU STACK + 1024     ; Top of stack

    EXPORT Reset_Handler
Reset_Handler
    BL main
    B .

    AREA |.data|, DATA, READONLY

string1     DCB "HELLO",0        ; String 1, NULL-terminated
string2     DCB "WORLD",0        ; String 2, NULL-terminated

    AREA |.data2|, DATA, READWRITE

string3     SPACE 20             ; Destination for reverse/concat
len1        DCD 0                ; Length of string1
cmpResult   DCD 0                ; Result of comparison (0 if equal, 1 otherwise)

    AREA |.text|, CODE, READWRITE
main
    ; -------- a) Print string1 --------
    LDR R0, =string1
    BL print_string

    ; -------- b) Reverse string1 into string3 --------
    LDR R0, =string1
    LDR R1, =string3
    BL reverse_string

    ; -------- c) Find Length of string1 --------
    LDR R0, =string1
    BL string_length
    LDR R1, =len1
    STR R0, [R1]                 ; Save length into len1

    ; -------- d) Compare string1 and string2 --------
    LDR R0, =string1
    LDR R1, =string2
    BL compare_strings
    LDR R2, =cmpResult
    STR R0, [R2]                 ; Save comparison result

    ; -------- e) Concatenate string1 and string2 into string3 --------
    LDR R0, =string1
    LDR R1, =string2
    LDR R2, =string3
    BL concatenate_strings

STOP
    B STOP

; -----------------------------------------
; Function: print_string (R0 = address)
print_string
    PUSH {R1}
print_loop
    LDRB R1, [R0], #1            ; Load byte and increment pointer
    CMP R1, #0
    BEQ print_done
    ; Normally here you'd output the character to UART or screen
    B print_loop
print_done
    POP {R1}
    BX LR

; -----------------------------------------
; Function: reverse_string (R0 = source, R1 = destination)
reverse_string
    PUSH {R2, R3, R4}

    ; Find length
    MOV R2, R0
    MOV R3, #0
find_len
    LDRB R4, [R2], #1
    CMP R4, #0
    BEQ got_len
    ADD R3, R3, #1
    B find_len
got_len
    SUB R2, R2, #1               ; R2 points to last valid character

rev_loop
    CMP R3, #0
    BEQ rev_done
    LDRB R4, [R2], #-1
    STRB R4, [R1], #1
    SUB R3, R3, #1
    B rev_loop
rev_done
    MOV R4, #0
    STRB R4, [R1]                ; NULL terminate
    POP {R2, R3, R4}
    BX LR

; -----------------------------------------
; Function: string_length (R0 = address, result in R0)
string_length
    PUSH {R1}
    MOV R1, #0
len_loop
    LDRB R0, [R0], #1
    CMP R0, #0
    BEQ len_done
    ADD R1, R1, #1
    B len_loop
len_done
    MOV R0, R1
    POP {R1}
    BX LR

; -----------------------------------------
; Function: compare_strings (R0 = addr1, R1 = addr2)
; Return 0 if same, 1 if different
compare_strings
    PUSH {R2, R3}
cmp_loop
    LDRB R2, [R0], #1
    LDRB R3, [R1], #1
    CMP R2, R3
    BNE cmp_not_equal
    CMP R2, #0
    BEQ cmp_equal
    B cmp_loop
cmp_equal
    MOV R0, #0
    POP {R2, R3}
    BX LR
cmp_not_equal
    MOV R0, #1
    POP {R2, R3}
    BX LR

; -----------------------------------------
; Function: concatenate_strings (R0=string1, R1=string2, R2=dest)
concatenate_strings
    PUSH {R3}

copy_first
    LDRB R3, [R0], #1
    CMP R3, #0
    BEQ copy_second
    STRB R3, [R2], #1
    B copy_first

copy_second
    LDRB R3, [R1], #1
    CMP R3, #0
    BEQ concat_done
    STRB R3, [R2], #1
    B copy_second

concat_done
    MOV R3, #0
    STRB R3, [R2]                ; NULL terminate
    POP {R3}
    BX LR

    END
