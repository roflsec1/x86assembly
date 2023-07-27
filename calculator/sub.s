%include	"library.s"

SECTION .text
global _start
_start:
	mov eax, 99
	mov ebx, 9
	sub eax, ebx
	call iprintln
	call exit
