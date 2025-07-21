
        AREA data, DATA, READWRITE
        ALIGN 4

main_str    DCB "this is a test string", 0     ; main string
sub_str     DCB "nishat", 0                      ; substring 

        AREA code, CODE, READONLY
        ENTRY
        EXPORT main

main
        LDR     r0, =main_str       
        LDR     r1, =sub_str       
        BL      String_Find         
stop
        B       stop                ; infinite loop to stop

String_Find
        PUSH    {r3-r7, lr}
        MOV     r2, #0              
        MOV     r3, r0              

outer_loop
        LDRB    r4, [r3]            
        CMP     r4, #0              
        BEQ     not_found

        MOV     r5, r3              
        MOV     r6, r1              

inner_loop
        LDRB    r7, [r6]            
        CMP     r7, #0              
        BEQ     found               

        LDRB    r4, [r5]            
        CMP     r4, #0              
        BEQ     not_found

        CMP     r4, r7              
        BNE     next_start          

        ADD     r5, r5, #1          
        ADD     r6, r6, #1          
        B       inner_loop

next_start
        ADD     r3, r3, #1          
        B       outer_loop

found
        MOV     r2, r3              
        B       done

not_found
        MOV     r2, #0              

done
        POP     {r3-r7, pc}
