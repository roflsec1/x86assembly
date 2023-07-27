%include	"library.s"

SECTION .data

request		db	"GET / HTTP/1.1", 0Dh, 0Ah, "Host:127.0.0.1", 0Dh, 0Ah, 0Dh, 0Ah, 0h

SECTION .bss

response	RESB	1

SECTION .text
global _start

_start:
	xor eax, eax
	xor ebx, ebx
	xor edi, edi

_socket:
	push byte 6		; IPPROTO_TCP
	push byte 1		; SOCK_STREAM
	push byte 2		; PF_INET
	mov ecx, esp
	mov ebx, 1		; invoke subroutine SOCKET(1)
	mov eax, 102		; invoke SYS_SOCKETCALL
	int 80h			; call the kernel

_connect:
	mov edi, eax
	push dword 0x100007f	; push 127.0.0.1 onto the stack in reverse byte order
	push word 0x5000	; push 80 onto stack
	push word 2		; AF_INET
	mov ecx, esp		; move address of stack pointer in ecx
	push byte 16		; arguments length
	push ecx		; push the address of arguments onto stack
	push edi		; push the file descriptor onto stack
	mov ecx, esp		; move address of arguments into ecx
	mov ebx, 3		; invoke subroutine CONNECT(3)
	mov eax, 102		; invoke SYS_SOCKETCALL
	int 80h			; call the kernel

_write:
	mov edx, 43		; move 43 dec into edx (length in bytes to write)
	mov ecx, request	; move address of our request variable into ecx
	mov ebx, edi		; move file descriptor into ebx
	mov eax, 4		; invoke SYS_WRITE
	int 80h			; call the kernel

_read:
	mov edx, 1		; number of bytes to read (we will read 1 byte at a time)
	mov ecx, response	; move the memory address of our buffer variable into ecx
	mov ebx, edi		; move edi into ebx (created socket file descriptor)
	mov eax, 3		; invoke SYS_READ
	int 80h

	cmp eax, 0		; if return value of SYS_READ in eax is 0, we have reached EOF
	jz _close

	mov eax, response	; move the memory address of our buffer variable into eax for printing
	call print		; call our string printing function
	jmp _read		; jmp to _read

_close:
	mov ebx, edi
	mov eax, 6
	int 80h

_exit:
	call exit
