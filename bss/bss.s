%include	"library.s"

SECTION .data

msg1	db	"Please enter your name: ", 0h
msg2	db	"Hello, ", 0h

SECTION .bss

sinput:		RESB	255

SECTION .text

global _start

_start:
	mov eax, msg1
	call print

	mov edx, 255		; number of bytes to read
	mov ecx, sinput		; reserved space to store our input
	mov ebx, 0		; read from the STDIN file
	mov eax, 3		; invoke SYS_READ (kernel opcode 3)
	int 80h

	mov eax, msg2
	call print

	mov eax, sinput
	call println

	call exit
