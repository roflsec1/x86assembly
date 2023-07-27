; O_RDONLY -> 0
; O_WRONLY -> 1
; O_RDWR   -> 2

%include	"library.s"

SECTION .data
filename	db	"readme.txt", 0h
contents	db	"Hello, lol.", 0h

SECTION .bss
fileContents	RESB	255

SECTION .text
global _start

_start:

	mov ecx, 0644o
	mov ebx, filename
	mov eax, 8
	int 80h

	call iprint		; print returned handle/file descriptor as integer (???)

	mov edx, 13
	mov ecx, contents
	mov ebx, eax
	mov eax, 4
	int 80h

	mov ecx, 0		; flag for readonly
	mov ebx, filename
	mov eax, 5		; SYS_OPEN
	int 80h

	call iprintln
	call exit
