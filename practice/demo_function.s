        AREA Code1, CODE, READONLY
        ENTRY           ; Entry point
        EXPORT Main 

Main
        LDR     r13, =StackEnd     ; Initialize stack pointer (SP = StackEnd)

        MOV     r1, #5             ; xyz = 5
        STR     r1, [r13, #-4]!    ; Push argument for f1 onto stack
        BL      func1              ; Call f1(5)

here
        B       here               ; Infinite loop (end of main)

; -----------------------------------------
; void f1(int a) { f2(a); }
func1
        LDR     r0, [r13]          ; Load argument a from stack into r0

        STR     r14, [r13, #-4]!   ; Save return address for func1
        STR     r0,  [r13, #-4]!   ; Push argument for f2

        BL      func2              ; Call f2(a)

        ADD     r13, #4            ; Pop argument for f2
        LDR     r15, [r13], #4     ; Pop return address and branch to it

; -----------------------------------------
; void f2(int r) { int g = r + 5; }
func2
        LDR     r4, [r13]          ; Load argument r from stack into r4
        ADD     r5, r4, #5         ; g = r + 5 → store in r5
        BX      r14                ; Return to caller (func1)

; -----------------------------------------
        AREA Data1, DATA, READWRITE
Stack   SPACE   20                 ; Allocate 20 bytes for stack
StackEnd
        END
