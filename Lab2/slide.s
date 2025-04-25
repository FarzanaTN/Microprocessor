        AREA test, CODE, READONLY
        ENTRY              ; starting point of the code execution
        EXPORT __main        ; the declaration of identifier main

__main                        ; address of the main function
        ; User code starts from the next line
        MOV r0, #2         ; store some arbitrary numbers
        MOV r1, #5
        ADD r2, r0, r1     ; add the values in r0 and r1 and store the result in r2

stop	B	stop             ; Endless loop
        END                ; End of the program, matched with ENTRY keyword