
;Program to copy elements of array

section .data
		msg1 db 10,"Enter elements of 1st array"
		msglen1 equ $-msg1
		
		msg2 db 10,"Copied Array elements are"
		msglen2 equ $-msg2
		
		nwln db 10
		cnt db 0
		arr1 times 80 db 0
		arr2 times 80 db 0
		
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
	       mov edi,arr1              ;ESI pointing to array variable
	   l1: input num,5              ;accept element of array
	       mov esi,num
	       	call ascii_original      ;call to proc
	       mov [edi],bx			  ; store converted element to array
	       inc edi                  ;increment index to store next element
	       inc edi
	       dec byte[cnt]            ; decrement counter
	       jnz l1 
	             
	       
	        				;copy array elements
	       mov esi,arr1
	       mov edi,arr2
	       mov byte[cnt],5
	    l2:mov ax,[esi]
	       mov [edi],ax
	       inc esi
	       inc esi
	       inc edi
	       inc edi
	       dec byte[cnt]
	       jnz l2
	         	        
	              				  ;print msg2
	       output msg2,msglen2
	       mov byte[cnt],5          ;dsiplay array 2 elements
	       mov esi,arr2
	   l3: mov bx,[esi]
	       	call original_ascii
	       output nwln,1
	       inc esi
	       inc esi
	       dec byte[cnt]
	       jnz l3    
	       
	       mov eax,1
	       mov ebx,0
	       int 80h
	       
	       
	       
   ascii_original:                      ;procedure defination
   			mov eax,0
   			mov ebx,0
   			mov ecx,4	          	
   		 up1:rol bx,4
   		     mov al,[esi]             
   		     cmp al,39h			
   		     jbe down1
   		     sub al,07
   	    down1:sub al,30h
   	          add bx,ax 
   	          inc esi
   	          loop up1
   ret
   
   original_ascii:	                   ;procedure defination      
   	         mov edx,0
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
   	         output buff,4
   ret	                  
	       
