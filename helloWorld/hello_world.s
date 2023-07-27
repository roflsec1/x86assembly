SECTION .data
msg 	db	'Hello World!', 0Ah

SECTION .text
global _start

_start:
	mov edx, 13	; mention the length of the string, line feed 0Ah included
	mov ecx, msg	; move the memory address of msg string to ecx
	mov ebx, 1	; write to STDOUT
	mov eax, 4	; invoke SYS_WRITE
	int 80h		; interrupt
	mov eax, 1	; invoke SYS_EXIT
	mov ebx, 0	; the code the program returned with, 0 meaning no errors
	int 80h		; to the kernel!
