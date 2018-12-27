section .data
    msg1 db 10,"Enter a number : ",10,13               
    msg1len equ $-msg1                     
    msg2 db 10,"Your entered number is : ",10,13,10,13
    msg2len equ $-msg2

section .bss
        num revb 2
    
section .text
    global _start
    
_start:

    %macro out 2
    mov eax,4
    mov ebx,1
    mov ecx,%1
    mov edx,%2
    int 80h
    %endmacro
    
    %macro in 2
    mov eax,3
    mov ebx,0
    mov ecx,%1
    mov edx,%2
    int 80h
    %endmacro
    
    out msg1,msg1len
    in num,2
    out msg2,msg2len
    out num,2
    
    mov eax,1
    int 80h
