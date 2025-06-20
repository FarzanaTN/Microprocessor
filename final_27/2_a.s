        AREA    data, DATA, READWRITE
        ALIGN   4
n       DCD     5                   ; the number of elements

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        LDR r1, =n    
        LSR r1, r1, #3

        LDR r1, =n 
        LSL r1, r1, #4
        
        LDR r1, =n 
        ASR r1, r1, #1

stop
        B       stop                ; infinite loop to stop

        END
