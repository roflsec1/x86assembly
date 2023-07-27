%include	"library.s"

SECTION .data
fizz	db	"Fizz", 0h
buzz	db	"Buzz", 0h

SECTION .text
global _start

_start:
	mov esi, 0	; initialize our checkFizz boolean variable
	mov edi, 0	; initialize our checkBuzz boolean variable
	mov ecx, 0	; initialize our counter variable

nextNumber:
	inc ecx

.checkFizz:
	mov edx, 0	; clear the register being used to hold the remainder after division
	mov eax, ecx	; move the value of our counter into eax for division
	mov ebx, 3	; move our (divisor) number to divide by into ebx (in this case the value is 3, which means fizz)
	div ebx		; divide eax (dividend) by ebx (divisor) and store the remainder in edx
	mov esi, edx	; move the remainder into edi, the boolean variable
	cmp esi, 0	; check if the remainder is 0
	jne .checkBuzz	; if the remainder is not 0
	mov eax, fizz	; move the address of our buzz string into eax for printing.
	call print	; print it

.checkBuzz:
	mov edx, 0
	mov eax, ecx	; move the value of our counter into eax for division
	mov ebx, 5	; move our number to divide by into ebx (in this case the value is 5)
	div ebx		; divide eax by ebx
	mov edi, edx
	cmp edi, 0
	jne .checkInt	; if the remainder is not 0
	mov eax, buzz
	call print

.checkInt:
	cmp edi, 0
	je .continue
	cmp esi, 0
	je .continue
	mov eax, ecx
	call iprint

.continue:
	mov eax, 0Ah
	push eax
	mov eax, esp
	call print
	pop eax
	cmp ecx, 100
	jne nextNumber

	call exit
