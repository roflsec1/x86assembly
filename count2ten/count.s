%include 	"library.s"

SECTION .text

global _start

_start:
	mov ecx, 0	; initialize

nextNumber:
	inc ecx		; increment value of ecx
	mov eax, ecx	; move it to eax
	call iprintln	; call our library function
	cmp ecx, 10	; works like...
	jne nextNumber	; ...an if condition

	call exit	; exeunt
