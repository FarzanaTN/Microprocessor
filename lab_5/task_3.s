	AREA    data, DATA, READWRITE
	ALIGN 4
number       DCD     0xc123             
           

        AREA    code, CODE, READONLY
        ENTRY
        EXPORT  main

main
        LDR r0, =number 
        LDR r1, [r0]
        
        MVN r2, r1 ;FFFF3EDC

loop
        B       loop               

        END
