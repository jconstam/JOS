; SUBROUTINE - Print 4-digit hexadecimal number
;	Expected to be in dx
print_hex_4:
	pusha
	
	; Setup index variable
	mov cx, 0
	
print_hex_4_top:
	; Copy to working register
	mov ax, dx
	; Mask nibble we want to work on
	and ax, 0x000f
	; Check for number
	cmp ax, 0x09
	jle print_hex_4_number_to_ASCII
	; Must be letter
	jmp print_hex_4_letter_to_ASCII

print_hex_4_number_to_ASCII:
	; Convert to ASCII number
	add al, 0x30
	jmp print_hex_4_move
	
print_hex_4_letter_to_ASCII:
	; Convert to ASCII letter
	; 'A' is 0x41, letters start at 0x0A => need to add 0x37
	add al, 0x37
	jmp print_hex_4_move

print_hex_4_move:
	; Get the base address -> base address + length - index
	mov bx, PRINT_HEX_4_OUT + 5
	sub bx, cx
	; Copy character
	mov [bx], al
	
	; Rotate for next character
	ror dx, 4
	
	; Increment Counter
	add cx, 1
	
	; If less than 4, go back to top
	cmp cx, 4
	jl print_hex_4_top
	
	
end_print_hex_4:
	mov bx, PRINT_HEX_4_OUT
	call print_string
	
	popa
	ret
	
; Reserve space for the string
PRINT_HEX_4_OUT:
	db '0x0000', 0