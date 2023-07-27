%include	"library.s"

SECTION .data

filename	db	"readme.txt", 0h
contents	db	"File written.", 0ah, 0h

SECTION .text

global _start

_start:
	mov ecx, 0644o
	mov ebx, filename
	mov eax, 8
	int 80h			; it returns the handle to the file in eax

	mov ecx, contents
	mov ebx, eax		; move the handle or file descriptor to eax
	mov edx, 15
	mov eax, 4
	int 80h

	call exit
