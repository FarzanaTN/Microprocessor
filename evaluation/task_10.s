        AREA data, DATA, READWRITE
        ALIGN 4

SPEED           DCD 85        ; Example speed > 80
DISTANCE        DCD 95        ; Example distance < 100
BRAKE_PRESSURE  DCD 60        ; Example brake pressure
MODE            DCD 0         ; Output mode (to be written by logic)

        AREA code, CODE, READONLY
        ENTRY
        EXPORT main

main
        ; Load SPEED
        LDR     r0, =SPEED
        LDR     r1, [r0]          ; r1 = SPEED

        ; Load DISTANCE
        LDR     r0, =DISTANCE
        LDR     r2, [r0]          ; r2 = DISTANCE

        ; Load BRAKE_PRESSURE
        LDR     r0, =BRAKE_PRESSURE
        LDR     r3, [r0]          ; r3 = BRAKE_PRESSURE

        ; Check: SPEED > 80 && DISTANCE < 100 → Emergency Brake (MODE = 3)
        MOV     r4, #0
        CMP     r1, #80
        BLE     check_distance_only   ; If SPEED <= 80, skip to next check
        CMP     r2, #100
        BGE     check_distance_only   ; If DISTANCE >= 100, skip
        MOV     r4, #3                ; MODE = 3
        B       write_mode

check_distance_only
        CMP     r2, #100
        BGE     check_brake           ; DISTANCE >= 100? Skip
        MOV     r4, #2                ; MODE = 2
        B       write_mode

check_brake
        CMP     r3, #80
        BLE     idle_mode
        MOV     r4, #1                ; MODE = 1
        B       write_mode

idle_mode
        MOV     r4, #0                ; MODE = 0

write_mode
        LDR     r0, =MODE
        STR     r4, [r0]              ; Store result

end
        B       end                  ; Infinite loop to end program

        END
