
        AREA data, DATA, READWRITE
        ALIGN 4

N           DCD     20              
prime_array SPACE   100             
prime_count DCD     0               

        AREA code, CODE, READONLY
        ENTRY
        EXPORT main

main
        BL      Print_Prime_Number 
stop
        B       stop                ; Infinite loop


Print_Prime_Number
        PUSH    {r4-r11, lr}

        LDR     r0, =N              
        LDR     r1, [r0]            
        LDR     r2, =prime_array    
        MOV     r3, #2              
        MOV     r4, #0              

next_num
        CMP     r3, r1
        BGT     done

       
        MOV     r5, #2              
        MOV     r6, #1              
check_div
        MUL     r7, r5, r5
        CMP     r7, r3
        BGT     store_prime         

        UDIV    r8, r3, r5          
        MUL     r9, r8, r5
        CMP     r9, r3
        BEQ     not_prime           

        ADD     r5, r5, #1
        B       check_div

not_prime
        MOV     r6, #0              
        B       skip_store

store_prime
        CMP     r6, #1
        BNE     skip_store

        STR     r3, [r2, r4, LSL #2] 
        ADD     r4, r4, #1

skip_store
        ADD     r3, r3, #1
        B       next_num

done
        LDR     r0, =prime_count
        STR     r4, [r0]            

        POP     {r4-r11, pc}
