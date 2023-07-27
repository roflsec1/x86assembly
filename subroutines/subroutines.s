SECTION .data
	msg	db	"I'm gonna subroutine now", 0Ah

SECTION .text

global _start

_start:
	xor eax, eax	; lmao
	mov eax, msg	; move the memory address of the string to eax
	call strlen	; I will be back
	mov edx, eax	; Ok I'm back and now I'll place the result of subroutine to edx
	mov ecx, msg	; I will also put the original string for comparison in ecx
	mov ebx, 1	; parameter STDOUT for
	mov eax, 4	; SYS_WRITE syscall
	int 80h

	mov ebx, 0	; ...with exit code 0...
	mov eax, 1	; exeunt
	int 80h

strlen:
	push ebx
	mov ebx, eax

nextchar:
	cmp byte [eax], 0	; compare the byte in the memory address of the value in eax with 0, and set the return value in the flag (1 or 0)
	jz finished		; jump to the 'finished' label if the flag is zero
	inc eax			; if not, increment the memory address in eax by 1
	jmp nextchar		; loop

finished:
	sub eax, ebx		; subtract the memory address of eax with ebx and store it in eax
	pop ebx
	ret			; return with the resultant value in eax and end the subroutine
