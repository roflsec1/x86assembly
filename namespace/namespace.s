%include	"library.s"

SECTION .data
msg1	db	"Jumping to .finished label.", 0h	; a message string
msg2	db	"Inside subroutine number: ", 0h	; a message string
msg3	db	"finished", 0h				; a message string

SECTION .text
global _start

_start:

subroutineOne:
	mov eax, msg1
	call println
	jmp .finished

.finished:
	mov eax, msg2
	call print
	mov eax, 1
	call iprintln

subroutineTwo:
	mov eax, msg1
	call println
	jmp .finished

.finished:
	mov eax, msg2
	call print
	mov eax, 2
	call iprintln

	mov eax, msg1
	call println
	jmp finished

finished:
	mov eax, msg3
	call println
	call exit
