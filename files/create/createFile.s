; Permission bits
; r -> 4, w -> 2, x -> 1
; 4 + 2 + 1 = 7 -> rwx

%include	"library.s"

SECTION .data

filename	db	"readme.txt", 0h	; the file name to create

SECTION .text

global _start

_start:
	mov ecx, 0644o		; Give permissions to read and write to user, read permission to group, read permission to all
	mov ebx, filename	; the file name
	mov eax, 8		; invoke SYS_CREAT
	int 80h			; kernel!

	call exit		; bye
