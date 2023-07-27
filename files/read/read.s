%include	"library.s"

SECTION .data

filename	db	"readme.txt", 0h
contents	db	"fuck you", 0h

SECTION .bss

fileContents	RESB	255

SECTION .text

global _start

_start:

	mov ecx, 0644o		; read and write, read, read
	mov ebx, filename
	mov eax, 8		; SYS_CREAT
	int 80h

	mov edx, 9		; number of bytes to write
	mov ecx, contents	; yes
	mov ebx, eax 		; move the file descriptor into eax
	mov eax, 4		; SYS_WRITE
	int 80h

	mov ecx, 0		; open the file
	mov ebx, filename
	mov eax, 5		; SYS_OPEN
	int 80h

	mov edx, 9		; number of bytes to read
	mov ecx, fileContents	; move the memory address of our file contents
	mov ebx, eax		; move opened file descriptor into ebx
	mov eax, 3		; invoke SYS_READ
	int 80h

	mov eax, fileContents
	call println

	mov ebx, ebx
	mov eax, 6		; SYS_CLOSE
	int 80h

	call exit
