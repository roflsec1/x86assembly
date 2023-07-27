; This program literally just prints all the arguments
; ./args argument1 argument2
; When you run the program with arguments, the first argument is the number of arguments
; The number of arguments will be found on top of the stack
; This is copied to the ecx register using the pop instruction
; And subsequently the esp is moved to a higher memory address

%include	"library.s"

SECTION .text
global _start

_start:
	pop ecx		; pop doesn't delete, it simply moves the esp to higher memory address. Also, the first argument after the program name is the argument count, so that is copied to ecx first, then the esp moves to higher memory address on the stack

next_arg:
	cmp ecx, 0h	; checks if the number of arguments left is zero.
	jz noMoreArgs	; goes to the respective label if zero flag is set to 0
	pop eax		; mov esp address to eax, and increase the esp value
	call println	; now eax points to the topmost value on the stack, which is full of the necessary arguments. It will act as the argument for println
	dec ecx		; decrease the number of arguments left by 1, ecx is a loop counter
	jmp next_arg	; last two arguments left on the stack would be program name and the number of arguments

noMoreArgs:
	call exit	; so using pop instructions we set the necessary parameters and ran the program with arguments. Ez.
