SECTION .bss
   Ibuf: RESB 80
   TMPbuf: RESB 80
   Obuf: RESB 80
SECTION .data
   wlcm: DB 'Enter a string, they should contain at least one number', 10
   wlcmLen: EQU $-wlcm
SECTION .text
   GLOBAL _start

SetBits:
   mov ecx, 0
   lp1:
	
	mov al, [esi]
	cmp al, 10
	   je end
	
	sub al, '0'
	cmp al, 0
	   jb lp2
	cmp al, 9
	   ja lp2
	
	mov cl, al
	mov edx, 1
	shl edx, cl
	or [TMPbuf], edx
	lp2:
	   inc esi

	jmp lp1
    end:
	ret

Convert:
   xor ecx, ecx
   xor ebx, ebx
   mov bl, 2
    
   .divide:
     xor edx, edx
     div ebx
     add dl, '0'
     push dx
     inc ecx
     cmp eax, 0
   jnz .divide
    
   .reverse:
     pop ax
     stosb
   loop .reverse
   ret

_start:
   mov eax, 4
   mov ebx, 1
   mov ecx, wlcm
   mov edx, wlcmLen
   int 80h

   mov eax, 3
   mov ebx, 0
   mov ecx, Ibuf
   mov edx, 80
   int 80h
   
   
   mov esi, Ibuf
   call SetBits

   mov eax, [TMPbuf]
   mov edi, Obuf
   call Convert

   mov eax, 4
   mov ebx, 1
   mov ecx, Obuf
   mov edx, 80
   int 80h
	 
   mov eax, 1
   mov ebx, 0
   int 80h
   




