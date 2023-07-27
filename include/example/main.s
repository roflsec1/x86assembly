%include	"library.s"

SECTION .data

msg1	db	"Hi", 0h	; 0Ah is line feed, 0h is null byte
msg2	db	"Lol", 0h	; don't have to explain what null byte is

SECTION .text

global _start

_start:
	mov eax, msg1
	call println

	mov eax, msg2
	call println

	call exit

