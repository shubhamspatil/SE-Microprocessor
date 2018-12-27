section .data
	
	msg1 db 10,10,"Enter the first number (4-digit) : "
	msglen1 equ $-msg1
	
	msg2 db "Enter the second number (4-digit) : "
	msglen2 equ $-msg2
	
	msg3 db 10,"The product of the numbers is : "
	msglen3 equ $-msg3
	
	msg4 db 10,"ERROR : Please enter the correct choice ",10
	msglen4 equ $-msg4
	
	msg5 db 10,10,"(1) Multiplication by successive addition"
	msglen5 equ $-msg5
	
	msg6 db 10,"(2) Multiplication by add and shift method"
	msglen6 equ $-msg6
	
	msg7 db 10,"Enter any of the above options : "
	msglen7 equ $-msg7
	
	msg8 db 10,10,"(1) Continue ?"
	msglen8 equ $-msg8
	
	msg9 db 10,"(2) Exit"
	msglen9 equ $-msg9
	
	msg10 db 10,"Enter choice : "
	msglen10 equ $-msg10
	
	nwln db 1
	cnt db 0
	
section .bss

	num1 resb 5     ; 4 for no and 1 for enter so total 5
	num2 resb 5
	buff resb 4
	choice resb 2
	ans resb 2
	
	%macro accept 2
		mov eax,3
		mov ebx,0
		mov ecx,%1
		mov edx,%2
		int 80h
	%endmacro
	
	%macro display 2
		mov eax,4
		mov ebx,1
		mov ecx,%1
		mov edx,%2
		int 80h
	%endmacro
	
section .text
	global _start
	
_start:
	
l7:
	display msg5,msglen5
	display msg6,msglen6
	display msg7,msglen7
	accept choice,2
	sub byte[choice],30h
	cmp byte[choice],01h
	je l1
	cmp byte[choice],02h
	je l2
	display msg4,msglen4
	jmp l7
	
l1:
	display msg1,msglen1
	accept num1,5
	mov esi,num1
	call ascii_original
	mov [num1],bx
	
	display msg2,msglen2
	accept num2,5
	mov esi,num2
	call ascii_original
	mov [num2],bx
	
	display msg3,msglen3
	mov ax,[num1]
	mov cx,[num2]
	mov bx,0
	
l4:add bx,ax
	dec cx
	jnz l4
	call original_ascii
	

	jmp l3


l2:
	display msg1,msglen1
	accept num1,5
	mov esi,num1
	call ascii_original
	mov [num1],bx
	
	display msg2,msglen2
	accept num2,5
	mov esi,num2
	call ascii_original
	mov [num2],bx
	
	display msg3,msglen3
	mov ax,0
	mov bx,0
	mov cx,16
	mov ax,[num1]
	mov bx,[num2]
	mov dx,0
l5:
	shl dx,1
	shl ax,1
	jnc l6
	add dx,bx
l6:
	dec cx
	jnz l5
	mov bx,dx
	call original_ascii
	
	jmp l3
	

l3:
	display msg8,msglen8
	display msg9,msglen9
	display msg10,msglen10
	accept ans,2
	sub byte[ans],30h
	cmp byte[ans],01h
	je l7
	cmp byte[ans],02h
	je l8
	display msg4,msglen4
	jmp l3
	
l8:
	
	mov eax,1
	int 80h
	
	
	
 ascii_original:        ;input in esi
                        ;output in bx
            mov ecx,4
            mov ebx,0
            mov eax,0
    up1:
            rol bx,4
            mov al,[esi]
            cmp al,39h
            jbe down1   ; jump if zero or neg i.e jump if decimal
            sub al,07h
    down1:
            sub al,30h
            add bx,ax
            inc esi
            loop up1
            ret
            
            
     original_ascii:    ;input bx
                        ;output buff
            mov esi,buff
            mov ecx,4
    up2:
            rol bx,4
            mov dl,bl
            and dl,0fh
            cmp dl,09h
            jbe down2   ; decimal
            add dl,07h
    down2:
            add dl,30h
            mov [esi],dl
            inc esi
            loop up2
            display buff,4
            ret
            
            
