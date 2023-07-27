%include	"library.s"

SECTION .data

msg	db	"Hi", 0h

SECTION .text

global _start

_start:
	xor eax, eax
	xor ebx, ebx
	xor edi, edi
	xor esi, esi

_socket:
	push byte 6		; IPPROTO_TCP
	push byte 1		; SOCK_STREAM
	push byte 2		; PF_INET
	mov ecx, esp
	mov ebx, 1		; invoke subroutine SOCKET(1)
	mov eax, 102		; SYS_SOCKETCALL
	int 80h			; KERNEL!!!

	call iprintln		; print the file descriptor in EAX

_exit:
	call exit
