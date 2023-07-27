; We use SYS_FORK to create a new process that duplicates our current process.
; Both of these processes run concurrently
; Here's the catch though
; We can test the return value (in eax) to test whether we are in the parent or child process.
; The parent returns a non-negative, non-zero integer.
; In the child process, eax is zero
; This can be used to branch our logic between the parent and the child process.

%include	"library.s"

SECTION .data

childMsg	db	"In child process.", 0h
parentMsg	db	"In parent process.", 0h

SECTION .text

global _start

_start:
	mov eax, 2		; invoke SYS_FORK
	int 80h

	cmp eax, 0		; if eax is zero, we are in child process
	jz child		; jump to child label if eax is zero

parent:
	mov eax, parentMsg	; inside our parent process move parentMsg into eax
	call println
	call exit

child:
	mov eax, childMsg
	call println
	call exit
