        AREA    data, DATA, READWRITE
        ALIGN   4
array_base_address DCD     1, 3, 0, 4, 2     ; the numbers array
length       DCD     5                   ; the number of elements

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main
        EXPORT  sum_avg

main
        LDR     r0, =array_base_address        
        LDR     r1, =length  
        LDR     r1, [r1] 
        BL      sum_avg           

stop
        B       stop                ; infinite loop to stop


sum_avg
        PUSH    { lr}
        MOV     r3, #0      ; sum of all elements
        MOV     r4, #0      ; avg
        MOV     r2, #0      ; i = 0

loop
        CMP     r2, r1             ; index - length
        BGE     average

        LDR     r6, [r0]            ; r6 = arr[i]
        ADD     r3, r3, r6          ; r3 += r6
        ADD     r0, r0, #4          ; move to next number
        ADD     r2, r2, #1          ; i++
        B       loop

average     
        UDIV    r4, r3, r1
        B       done

done    
        POP     { lr}
        BX      lr
        END
