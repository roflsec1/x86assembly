%include	"library.s"

SECTION .data

msg	db	"Time -> ", 0h

SECTION .text

global _start

_start:
	mov eax, msg
	call print
	mov eax, 13		; invoke SYS_TIME
	int 80h
	call iprintln
	call exit
