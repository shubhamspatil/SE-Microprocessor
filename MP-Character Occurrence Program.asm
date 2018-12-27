
extern  filehandle,char,buf,abuf_len                   ;extern directive to include variables from other file

global far_proc                                        ;declare far_proc globally

%include "macro.asm"                                   ;include all macros

section .data

	nline db 10,10
	nline_len equ $-nline
	
	smsg db 10,"Number of spaces are : "
	smsg_len equ $-smsg
	
	nmsg db 10,"Number of new lines are : "
	nmsg_len equ $-nmsg
	
	cmsg db 10,"Number of character occurences are : "
	cmsg_len equ $-cmsg
	
	vmsg db 10,"Number of vowels are : "
	vmsg_len equ $-vmsg
	
section .bss

	scount resb 1
	ncount resb 1
	ccount resb 1
	vcount resb 1
	
section .text
	global _main
	
_main:

far_proc:                             ;define far_proc procedure

	xor eax,eax                      ;clear all bits of eax
	xor ebx,ebx                      ;reset ebx
	xor ecx,ecx
	xor esi,esi
	
	mov bl,[char]
	mov esi,buf                      ;point to first character
	mov ecx,[abuf_len]               ;initialize counter with actual buf length
	
up:
	mov al,[esi]                     ;mov one character into al
	
case_s:
	cmp al,20h                       ;compare for space
	jne case_n                       ;check next case if not equal
	inc byte[scount]                 ;increment scount if space present
	jmp next                         ;jump for next character
	
case_n:
	cmp al,0Ah                       ;compare for newline
	jne case_v
	inc byte[ncount]
	jmp next
	
case_v:                               ;compare all vowels
	
	case_a:
		cmp al,'a'
		jne case_e
		inc byte[vcount]
		jmp next
		
	case_e:
		cmp al,'e'
		jne case_i
		inc byte[vcount]
		jmp next
		
	case_i:
		cmp al,'i'
		jne case_o
		inc byte[vcount]
		jmp next
		
	case_o:
		cmp al,'o'
		jne case_u
		inc byte[vcount]
		jmp next
		
	case_u:
		cmp al,'u'
		jne case_A
		inc byte[vcount]
		jmp next
	
	case_A:
		cmp al,'A'
		jne case_E
		inc byte[vcount]
		jmp next
		
	case_E:
		cmp al,'E'
		jne case_I
		inc byte[vcount]
		jmp next
		
	case_I:
		cmp al,'I'
		jne case_O
		inc byte[vcount]
		jmp next
		
	case_O:
		cmp al,'O'
		jne case_U
		inc byte[vcount]
		jmp next
		
	case_U:
		cmp al,'U'
		jne case_c
		inc byte[vcount]
		jmp next
	
	
case_c:                                      ;compare for given character
	cmp al,bl
	jne next
	inc byte[ccount]
	
next:
	inc esi                                 ;point to next character
	dec ecx                                 ;decrement counter
	jnz up                                  ;repeat comparisons
	
	display smsg,smsg_len
	mov eax,[scount]
	add al,30h                              ;convert original to ascii
	mov [scount],al
	display scount,1                        ;display space count
	
	display nmsg,nmsg_len
	mov eax,[ncount]
	add al,30h
	mov [ncount],al
	display ncount,1                        ;display newline count
	
	display vmsg,vmsg_len
	mov eax,[vcount]
	add al,30h
	mov [vcount],al
	display vcount,1                        ;display vowel count
	
	display cmsg,cmsg_len
	mov eax,[ccount]
	add al,30h
	mov [ccount],al
	display ccount,1                        ;display character count
	display nline,nline_len           
	
	fclose [filehandle]                     ;close the file
	ret                                     ;return from procedure
