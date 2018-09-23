; SUBROUTINE: PRINT STRING
;   Expected to be in bx
;   Must be null terminated
print_string:
	pusha
	; Set TTY mode
	mov ah, 0x0e
	
print_string_start:
	; Note: bx is the base address for the string
	mov al, [bx]
	; Check for null terminator
	cmp al, 0
	je print_string_done
	
	; Call print interrupt (al already has the character)
	int 0x10
	
	; Incremement pointer
	add bx, 1
	jmp print_string_start
	
print_string_done:
	popa
	ret

; SUBROUTINE: PRINT NL/CR
print_newline:
    pusha
	; Set TTY mode
    mov ah, 0x0e
	
	; Newline
    mov al, 0x0a
    int 0x10
	
	; Carriage return
    mov al, 0x0d
    int 0x10
    
    popa
    ret