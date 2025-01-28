%macro io 4
    mov rax,%1
    mov rdi,%2
    mov rsi,%3
    mov rdx,%4
    syscall
%endmacro

%macro exit 0
    mov rax,60
    mov rdi,0
    syscall
%endmacro

section .data
    msg1 db "Write a 64-bit code to accept a string and to display its length",10,'Name - Ayush', 10,'Roll no - 17',10
    msg1len equ $-msg1
    msg2 db "Write the string whose length is to be calculated-",10
    msg2len equ $-msg2
    msg3 db "The length of the string is: "
    msg3len equ $-msg3
	new db 10

section .bss
    string1 resb 30
    temp resb 2

section .code
    global _start
	_start:
    io 1, 1, msg1, msg1len
    io 1, 1, msg2, msg2len
    io 0, 0, string1, 30

	dec al
	mov bl, al
	call hextoascii
 	exit

hextoascii:
	mov rsi, temp
	mov rcx, 2
next1:
    rol bl, 4
    mov dl, bl
    and dl, 0Fh
    cmp dl, 09h
    jbe copydigit
    add dl, 07h
 
copydigit:
    add dl, 30h
    mov [rsi], dl
    inc rsi
    dec rcx
    jnz next1

io 1,1,msg3,msg3len
io 1,1,temp,2
io 1, 1, new, 1
ret
