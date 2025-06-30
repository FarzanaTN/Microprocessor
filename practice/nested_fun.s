        AREA    data, DATA, READWRITE
        ALIGN   4

result  DCD     0           ; to store final result

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        MOV     r0, #2         ; initial argument = 7
        BL      funcA           ; call funcA(7)
        LDR     r1, =result
        STR     r0, [r1]        ; store returned result

stop
        B       stop

; -----------------------------------------
; funcA: takes r0 as input, calls funcB with (r0 + 5),
; then adds 3 to funcB's result and returns it.
; Input: r0 = x
; Output: r0 = 3 + 2*(x+5)
; -----------------------------------------
funcA
        PUSH    {lr}            ; save return address

        ADD     r1, r0, #5      ; prepare argument for funcB: x+5 in r1
        MOV     r0, r1          ; move to r0 for call
        BL      funcB           ; call funcB(x+5)

        ADD     r0, r0, #3      ; add 3 to funcB result

        POP     {lr}
        BX      lr

; -----------------------------------------
; funcB: takes r0 as input, returns r0 * 2
; Input: r0 = y
; Output: r0 = y * 2
; -----------------------------------------
funcB
        MOV     r1, r0
        ADD     r0, r1, r1      ; r0 = r1 + r1 = y * 2
        BX      lr

        END
