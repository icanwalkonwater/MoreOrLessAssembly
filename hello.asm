global main

extern printf

section .text			; code section

main:
	lea rdi, qword [hello]	; pointer string
	mov eax, 0
	call printf

section .rodata			; read only section (constant)
	hello		db "Hello World", 0x0a, 0x00