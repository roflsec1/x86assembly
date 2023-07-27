%include	"library.s"

SECTION .data

msg1	db	"Remainder: "

SECTION .text
global _start

_start:
	mov eax, 99
	mov ebx, 9
	div ebx
	call iprintln
	mov eax, msg1
	call print
	mov eax, edx
	call iprintln

	call exit
