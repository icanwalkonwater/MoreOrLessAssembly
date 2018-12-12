global main

extern printf, scanf
extern open, read, close
extern exit

section .text

main:
		; Function header
		push rbp
		mov rbp, rsp
		sub rsp, 0x10

		call read_random

sta		call ask_number
		cmp eax, dword [number]
		jl is_less
		jg is_more

		lea rdi, qword [win]
		xor eax, eax
		call printf
		jmp finish

is_less	lea rdi, qword [low]
		xor eax, eax
		call printf
		jmp sta

is_more	lea rdi, qword [high]
		xor eax, eax
		call printf
		jmp sta

finish	xor eax, eax
		call exit

ask_number:
		push rbp
		mov rbp, rsp
		sub rsp, 0x10

		lea rdi, qword [ask]		; format
		xor eax, eax
		call printf					; printf(format)

		lea rsi, qword [rbp - 0x04]	; integer pointer
		lea rdi, qword [prompt]		; format string
		call scanf					; scanf(format, &pointer)

		mov rax, qword [rbp - 0x04]	; return pointer

		leave
		ret

read_random:
		push rbp
		mov rbp, rsp
		sub rsp, 0x10

		lea rdi, qword [dev_random]
		xor eax, eax
		call open
		mov dword [rbp - 0x04], eax	; file descriptor at 0x04

		mov edx, 1
		lea rsi, qword [rbp - 0x08]
		mov edi, dword [rbp - 0x04]
		xor eax, eax
		call read
		movzx eax, byte [rbp - 0x08]
		mov byte [number], al

		mov edi, dword [rbp - 0x04]
		call close

		leave
		ret

section .data
	number 		db 0x32

section .rodata
	; Strings ends with a null byte
	; 0x0a is \n
	ask			db "Enter a number: ", 0x00
	high		db "Too high", 0x0a, 0x00
	low			db "Too low", 0x0a, 0x00
	win			db "Hell yeah", 0x0a, 0x00
	prompt		db "%d", 0x00

	dev_random	db "/dev/random", 0x00