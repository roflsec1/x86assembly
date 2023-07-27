%include	"library.s"

SECTION .text

global _start

_start:
	mov eax, 90	; move our first number to eax
	mov ebx, 9	; move our second number to ebx
	add eax, ebx	; add ebx to eax
	call iprintln	; print integer
	call exit	; bye
