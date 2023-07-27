%include	"library.s"

SECTION .data

fileName	db	"readme.txt", 0h

SECTION .text

global _start

_start:
	mov ebx, fileName
	mov eax, 10		; SYS_UNLINK
	int 80h

	call exit
