%include	"library.s"

SECTION .bss

buffer	resb	255

SECTION .text

global _start

_start:
	xor eax, eax
	xor ebx, ebx
	xor esi, esi
	xor edi, edi

_socket:
	push 6
	push 1
	push 2
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
	push byte 16
	push ecx
	push edi
	mov ecx, esp
	mov ebx, 2
	mov eax, 102
	int 80h

_listen:
	push byte 1
	push edi
	mov ecx, esp
	mov ebx, 4
	mov eax, 102
	int 80h

_accept:
	push byte 0
	push byte 0
	push edi
	mov ecx, esp
	mov ebx, 5
	mov eax, 102
	int 80h

_fork:
	mov esi, eax	; move return value of SYS_SOCKETCALL into esi (handle)
	mov eax, 2	; invoke SYS_FORK
	int 80h		; kernel

	cmp eax, 0
	jz _read	; jmp in child process to _read

	jmp _accept	; jmp in parent process to _accept

_read:
	mov edx, 255	; number of bytes to read
	mov ecx, buffer ; move the memory address of our buffer variable in to ecx
	mov ebx, esi	; move the accepted socket handle
	mov eax, 3	; invoke SYS_READ
	int 80h

	mov eax, buffer	; move the memory address of our buffer variable into eax
	call println

_exit:
	call exit
