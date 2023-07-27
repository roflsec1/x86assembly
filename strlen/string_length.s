SECTION .data
msg	db	"You know my length?", 0Ah	; the string

SECTION .text
global _start

_start:
	mov ebx, msg	; move the string to ebx register
	mov eax, ebx	; copy the string to eax for later comparison

nextchar:
	cmp byte [eax], 0	; compare the byte pointed to by eax at this address against zero (to check if it's end of string), this will set the zero flag if true.
	jz finished		; jump to the point in the code labeled as zero
	inc eax			; increment the address of the start of the string by one byte if the zero flag has not been set
	jmp nextchar		; this is a loop with an if condition!

finished:
	sub eax, ebx 		; subtract the address in ebx with from the address in eax to find the number of bytes in the string, and store it in eax
	mov edx, eax		; move the number of bytes from eax to edx
	mov ecx, msg		; the rest of the program is the same as hello_world, only difference being that we used the length of the string stored in a register
	mov ebx, 1		; SYS_WRITE parameter set to STDOUT, or 1.
	mov eax, 4		; using SYS_WRITE syscall
	int 80h			; GO TO KERNEL HAHAHAHAHA
	mov ebx, 0		; exit...
	mov eax, 1		; properly
	int 80h
