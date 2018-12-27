; This is a HELLO WORLD program

; First section for initialized data

section .data
    msg1 db 10,"HELLO",10,13                  ; initialize msg with "HI"
    msg1len equ $-msg1                      ; find msg length
    msg2 db "   WORLD",10,13,10,13
    msg2len equ $-msg2

; section for remaining instructions 
    
section .text
    global _start
    
_start:
    mov eax,4
    mov ebx,1
    mov ecx,msg1
    mov edx,msg1len
    int 80h
    
    mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,msg2len
    int 80h
    
    mov eax,1
    int 80h
    
    
; ASSEMBLE: nasm -f elf filename.asm
; LINK:     ld -m elf_i386 -o filename filename.o
; EXECUTE:  ./filename 
