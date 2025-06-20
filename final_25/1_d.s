        AREA    data, DATA, READWRITE
        ALIGN   4

src     DCB     "hello", 0         ; Source string (null-terminated)
dst     SPACE   32                 ; Destination buffer (space for copied string)

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        LDR     r0, =dst           ; r0 points to destination
        LDR     r1, =src           ; r1 points to source

copy_loop
        LDRB    r2, [r1], #1       ; Load byte from src and post-increment r1
        STRB    r2, [r0], #1       ; Store byte to dst and post-increment r0
        CMP     r2, #0             ; Check if null terminator was copied
        BNE     copy_loop          ; If not null, continue loop

stop
        B       stop               ; Infinite loop to stop program

        END
