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
	mov eax, 102
	int 80h

_bind:
	mov edi, eax
	push dword 0x00000000
	push word 0x2923
	push word 2
	mov ecx, esp
	push byte 8
	push ecx
	push edi
	mov ecx, esp
	mov ebx, 2
	mov eax, 102
	int 80h

_listen:
	push byte 1		; move 1 onto stack (max queue length argument)
	push edi		; push the file descriptor onto stack
	mov ecx, esp		; move address of arguments into ecx
	mov ebx, 4		; invoke subroutine LISTEN (4)
	mov eax, 102		; invoke SYS_SOCKETCALL 
	int 80h			; kernel

_exit:
	call exit
