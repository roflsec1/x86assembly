;-----------------------------------------
; int strlen(string message)
; returns the length of the string given in the parameter

strlen:
	push ebx
	mov ebx, eax

.nextchar:
	cmp byte [eax], 0
	jz .finished
	inc eax
	jmp .nextchar

.finished:
	sub eax, ebx
	pop ebx
	ret

;----------------------------------------
; void print(string message)

print:
	push edx
	push ecx
	push ebx
	push eax
	call strlen

	mov edx, eax
	pop eax

	mov ecx, eax
	mov ebx, 1
	mov eax, 4
	int 80h

	pop ebx
	pop ecx
	pop edx
	ret

;--------------------------------------------
; void println(string message)
; String printing with line feed function

println:
	call print

	push eax	; push the returned string onto the stack so that we can use the eax register for further operations
	mov eax, 0Ah	; add the line feed character to eax
	push eax	; push this to the stack as well
	mov eax, esp	; mov the top-most address in the stack to eax as a parameter to the print subprocess
	call print	; using the value at the top of the stack, which is the line-feed as a parameter, call print
	pop eax		; remove the line feed from the stack
	pop eax		; remove the string from the stack, so that the topmost address on the stack would point to the caller instruction
	ret		; go back where you came from

;--------------------------------------------
; void iprint(int number)
; Integer printing function

iprint:
	push eax	; preserve the register on the stack to be restored after the function runs
	push ecx
	push edx
	push esi
	mov ecx, 0	; initialize counter

.divideLoop:
	inc ecx		; count each byte to print
	mov edx, 0	; empty edx
	mov esi, 10	; move 10 into esi
	idiv esi	; divide eax by esi
	add edx, 48	; convert edx to it's ascii representation by adding base ascii value, which is 0
	push edx	; and push it on to the stack
	cmp eax, 0	; check if the interger can be divided further
	jnz .divideLoop	; conditional jump, jump if not zero

.printLoop:
	dec ecx		; count down each byte that we put on the stack
	mov eax, esp	; copy the esp to eax and
	call print	; send it to print
	pop eax		; remove it from the stack
	cmp ecx, 0	; check if we have print all the bytes
	jnz .printLoop

	pop esi
	pop edx
	pop ecx
	pop eax
	ret

;---------------------------------------------------
; void iprintln(int number)
; Integer printing function with line feed

iprintln:
	call iprint

	push eax
	mov eax, 0Ah
	push eax
	mov eax, esp
	call print
	pop eax
	pop eax
	ret

;---------------------------------------------------
; void exit
; Exit program properly

exit:
	mov ebx, 0
	mov eax, 1
	int 80h
	ret
