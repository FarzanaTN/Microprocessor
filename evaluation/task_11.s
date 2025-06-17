        ; Define data section
        AREA    data, DATA, READWRITE
        ALIGN   4

BATTERY_LEVEL   DCD 10          ; Example value < 20
LOAD_STATUS     DCD 1           ; 1 = Heavy
MODE            DCD 0           ; Output

        ; Define code section
        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        ; Load BATTERY_LEVEL into r1
        LDR     r0, =BATTERY_LEVEL
        LDR     r1, [r0]

        ; Load LOAD_STATUS into r2
        LDR     r0, =LOAD_STATUS
        LDR     r2, [r0]

        ; Check for high performance: battery > 80
        CMP     r1, #80
        BGT     high_performance

        ; Check for low power: battery < 20 and load = heavy
        CMP     r1, #20
        BGE     check_normal     ; If battery >= 20, go check for normal

        CMP     r2, #1
        BEQ     low_power        ; If load is heavy and battery < 20 → Low power

check_normal
        ; Else → Normal
        B       normal

high_performance
        LDR     r0, =MODE
        MOV     r3, #3
        STR     r3, [r0]
        B       end

low_power
        LDR     r0, =MODE
        MOV     r3, #1
        STR     r3, [r0]
        B       end

normal
        LDR     r0, =MODE
        MOV     r3, #2
        STR     r3, [r0]

end
        B       end             ; Infinite loop to halt program

        END
