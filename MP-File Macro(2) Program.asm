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
 
 %macro fopen 1
 mov ebx,%1
 mov eax,5
 mov ecx,0
 mov edx,0777
 int 80h
 %endmacro
 
 %macro wopen 1
 mov ebx,%1
 mov eax,5
 mov ecx,2
 mov edx,0777
 int 80h
 %endmacro
 
 %macro fread 3
 mov eax,3
 mov ebx,%1
 mov ecx,%2
 mov edx,%3
 int 80h
 %endmacro
 
 %macro fwrite 3
 mov eax,4
 mov ebx,%1
 mov ecx,%2
 mov edx,%3
 int 80h
 %endmacro
 
 %macro fseek 1
 mov eax,19
 mov ebx,%1
 mov ecx,0
 mov edx,2
 int 80h
 %endmacro
 
 %macro fclose 1
 mov eax,6
 mov ebx,%1
 int 80h
 %endmacro
 
 
%macro exit 0
mov eax,1
int 80h
%endmacro
