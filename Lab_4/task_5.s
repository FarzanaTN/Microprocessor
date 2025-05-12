        AREA    data, DATA, READWRITE
        ALIGN   4

input   DCD     14              ; decimal number 
binary  SPACE   32              ; Reserve 32 bytes for binary bits (max for 32-bit integer)

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        LDR     r0, =input      ; Load address of input
        LDR     r1, [r0]        ; Load the decimal number into r1

        LDR     r2, =binary     ; r2 points to the binary output array
        MOV     r3, #32         ; Counter for number of bits

convert_loop
        CMP     r3, #0          ; Check if all bits processed
        BEQ     done            ; If yes, exit loop

        MOV     r4, r1, LSR #31 ; Extract MSB (bit 31), right-shifted to LSB
        STRB    r4, [r2], #1    ; Store the bit and increment pointer
        LSL     r1, r1, #1      ; Shift r1 left by 1 to bring next bit to MSB

        SUB     r3, r3, #1      ; Decrease bit counter
        B       convert_loop

done
stop
        B       stop            ; Infinite loop to halt program

        END
