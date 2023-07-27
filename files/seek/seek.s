; SEEK_SET	0
; SEEK_CUR	1
; SEEK_END	2

%include	"library.s"

SECTION .data

filename	db	"readme.txt", 0h
contents	db	"touched.", 0h

SECTION .text
global _start

_start:

	mov ecx, 1		; WRITE_ONLY
	mov ebx, filename
	mov eax, 5		; SYS_OPEN
	int 80h

	mov edx, 2		; SEEK_END
	mov ecx, 0		; move the cursor to 0 bytes
	mov ebx, eax		; move the opened file descriptor into ebx
	mov eax, 19		; SYS_LSEEK
	int 80h

	mov edx, 9		; number of bytes to write
	mov ecx, contents	; move the memory address of our contents string into ecx
	mov ebx, ebx		; move the opened file descriptor back to where it was XD
	mov eax, 4		; SYS_WRITE
	int 80h

	call exit
