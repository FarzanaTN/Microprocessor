MUL r7, r0, #9
;equivalent without multiply
ADD r7, r0, r0, LSL #3  ; r7 = r0 + (r0 << 3), where << 3 is equivalent to multiplying by 8