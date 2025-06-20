AREA data, DATA, READWRITE
    ALIGN 4
    ; No variables needed in data section

    AREA code, CODE, READONLY
    ENTRY
    EXPORT main

; Function find42(int array[], int size)
; R0 = pointer to array
; R1 = size of array
; Returns: index of first element with value 42, or -1 if not found
find42
    PUSH    {R4, LR}          ; Save registers
    MOV     R2, #0            ; R2 = index counter (i = 0)
    
loop_check
    CMP     R2, R1            ; Compare i with size
    BGE     not_found         ; If i >= size, element not found
    
    LDR     R3, [R0, R2, LSL #2]  ; Load array[i] into R3
                                   ; Address = array + (i * 4)
    
    CMP     R3, #42           ; Compare array[i] with 42
    BEQ     found             ; If equal, we found it
    
    ADD     R2, R2, #1        ; i++
    B       loop_check        ; Continue loop
    
found
    MOV     R0, R2            ; Return the index
    B       exit_function
    
not_found
    MVN     R0, #0            ; Return -1 (0xFFFFFFFF)
    
exit_function
    POP     {R4, PC}          ; Restore registers and return

; Main function that could call find42
main
    ; Here you would typically set up parameters and call find42
    ; For example:
    ; LDR R0, =array_address
    ; MOV R1, #array_size
    ; BL find42
    
stop
    B       stop              ; Infinite loop to halt

    END