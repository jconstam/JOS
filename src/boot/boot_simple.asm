; Setup to write the contents of al in tty mode
mov ah, 0x0e

; Setup counter, inititalize to ASCII '9'
mov cl, 0x39

; Setup stack
mov bp, 0x8000
mov sp, bp

pushLoop:
	push 0xD
	push 0xA
	push ecx	; cl is the LSB of ecx
	push ' '
	push 'o'
	push 'l'
	push 'l'
	push 'e'
	push 'H'
	dec cl			; Decrement counter
	cmp cl, 0x30	; Check if equal to ASCII '0'
	jge pushLoop		; If greater than or equal to '0', go back to top

; Setup counter, initialize to 0
mov cl, 0

popLoop:
	pop bx
	mov al, bl
	int 0x10
	inc cl
	cmp cl, 100
	jl popLoop
	
infLoop:
	; Infinite loop
	jmp infLoop

; Fill with 510 zeroes minus the above code
times 510-($-$$) db 0

; Magic number
dw 0xaa55