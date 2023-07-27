%include	"library.s"

SECTION .text
global _start
_start:
	mov eax, 99
	mov ebx, 9
	mul ebx
	call iprintln
	call exit

