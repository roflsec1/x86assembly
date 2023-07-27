%include	"library.s"

SECTION .text

global _start

_start:
	xor eax, eax
	xor ebx, ebx
	xor esi, esi
	xor edi, edi

_socket:
	push byte 6
	push byte 1
	push byte 2
	mov ecx, esp
	mov ebx, 1
	mov eax, 102		; SYS_SOCKETCALL
	int 80h

_bind:
	mov edi, eax		; SYS_SOCKETCALL handle moved to edi
	push dword 0x00000000	; push 0 dec onto the stack IP ADDRESS (0.0.0.0)
	push word 0x2923	; push 9001 dec onto the stack PORT
	push word 2		; push 2 dec onto the stack AF_INET
	mov ecx, esp
	push byte 8		; argument's length, not sure why they used 16 bytes
	push ecx		; push the address of arguments onto the stack
	push edi		; push the file descriptor onto the stack
	mov ecx, esp		; move address of arguments into ecx
	mov ebx, 2
	mov eax, 102
	int 80h
_exit:
	call exit
