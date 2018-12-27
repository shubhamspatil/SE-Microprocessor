

; Program for accepting & displaying Array Elements

section .data
		msg1 db 10,"Enter elements of array"
		msglen1 equ $-msg1
		
		msg2 db 10,"Array elements are"
		msglen2 equ $-msg2
		
		nwln db 10
		cnt db 0
		arr times 80 db 0
		
section .bss					
	num resb 5                             
	buff resb 4
	
	%macro input 2     			;input macro                   	
		mov eax,3                       	
		mov ebx,0
		mov ecx,%1				   	
		mov edx,%2				   	
		int 80h
	%endmacro						   

	%macro output 2    			;output macro                    
		mov eax,4                       
		mov ebx,1
		mov ecx,%1				   	
		mov edx,%2				   	
		int 80h
	%endmacro		
	
	
section .text					
	global _start                 
	 
	_start: 	
	
	              				  ;print msg1
	       output msg1,msglen1
	       mov byte[cnt],5          ;counter:5 elements
	       mov edi,arr              ;ESI pointing to array variable
	   l1: input num,3              ;accept element of array
	       mov ax,[num]		       ;}	
	       mov [edi],ax			  ;} store element to array
	       inc edi                  ;increment index to store next element
	       inc edi
	       dec byte[cnt]            ; decrement counter
	       jnz l1 
	             
	       
	              				  ;print msg2
	       output msg2,msglen2
	       mov byte[cnt],5          ;dsiplay array elements
	       mov esi,arr
	   l2: mov bx,[esi]
	       mov [num],bx
	       output num,2
	       output nwln,1
	       inc esi
	       inc esi
	       dec byte[cnt]
	       jnz l2    
	       
	       mov eax,1
	       mov ebx,0
	       int 80h
	       
