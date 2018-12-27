
section .data
	
	msg1 db 10,"Enter the BCD number : "
	msglen1 equ $-msg1
	
	msg2 db 10,"Enter the hex number : "
	msglen2 equ $-msg2
	
	msg3 db 10,"The BCD equivalent is : "
	msglen3 equ $-msg3
	
	msg4 db 10,"The hex equivalent is : "
	msglen4 equ $-msg4
	
	msg5 db 10,"(1) BCD to hex"
	msglen5 equ $-msg5
	
	msg6 db 10,"(2) Hex to BCD"
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

	num1 resb 5
	num2 resb 6
	buff resb 4
	rem resb 1
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
	jmp l3
	
l1:
	display msg1,msglen1
	accept num2,6
	display msg4,msglen4
	mov eax,0h
	mov ebx,10
	mov esi,num2
	mov ecx,05h
l4:
	mov edx,0
	mul ebx
	mov edx,0
	mov dl,[esi]
	sub dl,30h
	add eax,edx
	inc esi
	dec ecx
	jnz l4
	mov ebx,eax
	call original_ascii

	jmp l3


l2:
	display msg2,msglen2
	accept num1,5
	display msg3,msglen3
	call ascii_original
	mov eax,ebx
	mov ebx,10
	mov byte[cnt],0
l5:
	mov edx,0h
	div ebx
	push dx
	inc byte[cnt]
	cmp ax,0
	jnz l5
l6:
	pop dx
	add dl,30h
	mov [rem],dl
	display rem,1
	dec byte[cnt]
	jnz l6
	
	jmp l3
	

l3:
	display msg8,msglen8
	display msg9,msglen9
	display msg10,msglen10
	accept ans,2
	sub byte[ans],30h
	cmp byte[ans],01h
	je l7
	
	mov eax,1
	int 80h
	
	
	
 ascii_original:
            mov ecx,4
            mov ebx,0
            mov eax,0
            mov esi,num1
    up1:
            rol bx,4
            mov al,[esi]
            cmp al,39h
            jbe down1
            sub al,07h
    down1:
            sub al,30h
            add bx,ax
            inc esi
            loop up1
            ret
            
            
     original_ascii:
            mov esi,buff
            mov ecx,4
    up2:
            rol bx,4
            mov dl,bl
            and dl,0fh
            cmp dl,09h
            jbe down2
            add dl,07h
    down2:
            add dl,30h
            mov [esi],dl
            inc esi
            loop up2
            display buff,4
            ret
            
            
