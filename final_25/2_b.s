gcd 
    CMP r0, r1 
    BEQ end
    BLT less 
    SUB r0, r0, r1 
    B gcd
less 
    SUB r1, r1, r0
    B gcd
end
    

;rewrite the code using conditionally ececuted instructions

gcd
    CMP     r0, r1           ; Compare r0 and r1
    SUBGT   r0, r0, r1       ; If r0 > r1, r0 = r0 - r1
    SUBLT   r1, r1, r0       ; If r0 < r1, r1 = r1 - r0
    BNE     gcd              ; If r0 != r1, loop again
end
