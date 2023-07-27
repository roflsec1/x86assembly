; execxx
; xx is replaced by the following letters
; v - command line arguments are passed to the function as an array of pointers
; e - an array of pointers to environment variables is explicitly passed to the new process image.
; l - command-line arguments are passed individually to the function.
; p - uses PATH environment variable to find the file named in the path argument to be executed.

%include	"library.s"

SECTION .data

command		db	"/bin/ls", 0h		; command to execute
arg1		db 	"-l", 0h

;command 	db 	"/bin/sleep", 0h	; command to execute
;arg1		db	"5s", 0h

;command	db	"/bin/echo", 0h		; command to execute
;arg1		db	"Hello World!", 0h	; argument for the command

arguments	dd	command			; both stored in an array
		dd	arg1
		dd	0h			; end the structure

environment	dd	0h

SECTION .text

global _start

_start:
	mov edx, environment		; address of environment variables (NULL)
	mov ecx, arguments		; address of the arguments to pass to the command line
	mov ebx, command		; address of the file to execute
	mov eax, 11			; invoke SYS_EXECVE
	int 80h
	call exit
