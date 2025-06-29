MOV r4, [r1]    ;register indirect (mode)  
                ;EA = [r1]

ADD r5, r3, r5, LSL #2  ;Register with Shifted Register Operand
                        ;Value = r3 + (r5 << 2)

LDR r2, [r0], #4    ;post index
                    ; EA = [r0]

STR r2, [r1, -6]!   ;pre-index with write back
                    ;EA = r1 - 6, and then: r1 = r1 - 6

ADD r3, r8, #12     ;immediate 
                    ; EA = r3 = r8 + 12