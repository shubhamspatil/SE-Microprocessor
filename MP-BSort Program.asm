
%include"macro.asm"
section .data

	filemsg db 10,"Enter the file name : "
	filemsg_len equ $-filemsg
	
	errmsg db 10,"File opening error...... in real mode",10
	errmsg_len equ $-errmsg
	
	errmsg1 db 10,"File opening error...... in r/w mode",10
	errmsg1_len equ $-errmsg1
	
	openmsg db 10,"File opened successfully ",10
	openmsg_len equ $-openmsg
	
	successmsg db 10,"File content written successfully",10
	successmsg_len equ $-successmsg
	
	sortmsg db 10,"Sorted array in function.....",10
	sortmsg_len equ $-sortmsg
	
	writemsg db 10,"File content written..... done.....",10
	writemsg_len equ $-writemsg
	
	dispmsg db 10,"Displaying sorted array",10
	dispmsg_len equ $-dispmsg
	
	exitmsg db 10,"Exiting code.......",10
	exitmsg_len equ $-exitmsg
	
	arrformedmsg db 10,"Array formed from buffer.......",10
	arrformed_len equ $-arrformedmsg
	
	nline db 10,10
	nlen equ $-nline
	
	array times 10 db 0
	
section .bss

	char resb 3
	len resb 1
	filename resb 50
	filehandle resw 1
	abuf_len resb 1
	arr_size resb 1
	iteration_cnt resb 1
	comparison_cnt resb 1
	buf2 resb 20
	cnt resb 1
	buf resb 20
	buf_len equ $-buf
	temp_arr_size1 resb 1
	
section .text

global _start
 _start:
 
   display filemsg,filemsg_len
   accept filename,20
   dec eax
   
   mov byte[filename + eax],0
   fopen filename
   test eax,eax
   js error
   mov[filehandle],eax
   
   display openmsg,openmsg_len
   
   fread [filehandle],buf,buf_len
   dec eax
   mov [abuf_len],eax
   call get_array
   call b_sort
   
   fclose [filehandle]
   
   display dispmsg,dispmsg_len
   wopen filename
   test eax,eax
   js error1
   
   mov [filehandle],eax
   fseek [filehandle]
   mov esi,array
   mov al,[arr_size]
   mov [temp_arr_size1],al
   
   again:
   
         xor edi,edi
         mov edi,char
         mov al,[esi]
         cmp al,0Ah
         je dwn1
         
         mov [edi],al
         inc edi
         mov byte[edi],0Ah
         inc esi
         
         fwrite [filehandle],char,2
         fseek [filehandle]
         display char,2
         dec byte[temp_arr_size1]
         cmp byte[temp_arr_size1],0
         jnz again
         
  dwn1: 
         fseek [filehandle]
         fwrite [filehandle],nline,nlen
         fwrite [filehandle],writemsg,writemsg_len
         fclose [filehandle]

         display successmsg,successmsg_len
         
         display exitmsg,exitmsg_len
         exit
   error:
           display errmsg,errmsg_len
           jmp down
           
   error1:
           display errmsg1,errmsg1_len
           jmp down
           
    down : exit




   
   b_sort:
          xor eax,eax
          mov al,[arr_size]
          mov [iteration_cnt],al
          dec byte[iteration_cnt]
          mov [comparison_cnt],al
          dec byte[comparison_cnt]
          
          xor ecx,ecx
          xor edx,edx
          xor esi,esi
          xor edi,edi
          mov cx,0
          
     up1: mov ebx,0
          mov esi,array
          
     up2:
          mov edi,esi
          inc edi
          mov al,[esi]
          cmp al,[edi]
          jbe next
          
          mov dl,0
          mov dl,[edi]
          mov [edi],al
          mov [esi],dl
          
     next:  
          inc esi
          inc ebx
          cmp bl,[comparison_cnt]
          jb up2
          
          dec byte[comparison_cnt]
          inc ecx
          cmp cl,[iteration_cnt]
          jb up1
          
          display sortmsg,sortmsg_len
          
          ret
        
     get_array:
               xor ecx,ecx
               xor esi,esi
               xor edi,edi
               mov ecx,[abuf_len]
               mov esi,buf
               mov edi,array
               mov byte[arr_size],0
               
      next_num: 
                mov al,[esi]
                mov [edi],al
                inc esi
                inc esi
                inc edi
                inc byte[arr_size]
                dec ecx
                dec ecx
                jnz next_num
                mov byte[edi],0Ah
                
                display arrformedmsg,arrformed_len
                
                ret
                
                
	
	
