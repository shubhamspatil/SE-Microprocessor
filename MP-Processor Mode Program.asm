
section .data

	gmsg db 10,10,"The contents of GDTR are : "
	gmsg_len equ $-gmsg
	
	lmsg db 10,10,"The contents of LDTR are : "
	lmsg_len equ $-lmsg
	
	imsg db 10,10,"The contents of IDTR are : "
	imsg_len equ $-imsg
	
	tmsg db 10,10,"The contents of TR are : "
	tmsg_len equ $-tmsg
	
	mmsg db 10,10,"The contents of MSW/CR0 are : "
	mmsg_len equ $-mmsg
	
	pro db 10,10,"The processor is in protected mode "
	pro_len equ $-pro
	
	real db 10,10,"The processor is in real mode "
	real_len equ $-real
   	          	
   	col db " : "
	col_len equ $-col
	
	nline db 10,10
	nlen equ $-nline
	
section .bss

	buff resb 4
	gdt1 resb 6
	idt1 resb 6
	ldt1 resw 1
	t1 resb 2
	msw1 resb 4
	
%macro display 2
	mov eax,4			        ;print
	mov ebx,1                   ;stdout/screen
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro

section .text
	global _start
	
_start:

	smsw eax
	mov [msw1],eax
	bt eax,0
	jc protected
	display real,real_len
	jmp end
	
protected:

	display pro,pro_len
	sgdt [gdt1]
	sldt [ldt1]
	sidt [idt1]
	str [t1]
	
	display gmsg,gmsg_len
	mov bx,[gdt1+4]
	call original_ascii
	mov bx,[gdt1+2]
	call original_ascii
	display col,col_len
	mov bx,[gdt1]
	call original_ascii
	
	display lmsg,lmsg_len
	mov bx,[ldt1]
	call original_ascii
	
	display imsg,imsg_len
	mov bx,[idt1+4]
	call original_ascii
	mov bx,[idt1+2]
	call original_ascii
	display col,col_len
	mov bx,[idt1]
	call original_ascii
	
	display tmsg,tmsg_len
	mov bx,[t1]
	call original_ascii
	
	display mmsg,mmsg_len
	mov bx,[msw1+2]
	call original_ascii
	mov bx,[msw1]
	call original_ascii
	
	
end:

	display nline,nlen
	mov eax,1
	int 80h
	
	
	
	
   	          	
   original_ascii:	                        
   	         mov eax,0
   	         mov ecx,4
   	         mov edi,buff        
   	     up2:rol bx,4
   	         mov dl,bl
   	         and dl,0fh			   
   	         cmp dl,09h             
   	         jbe down2
   	         add dl,07h
   	   down2:add dl,30h
   	         mov [edi],dl           
   	         inc edi
   	         loop up2
   	         display buff,4
   ret	    
