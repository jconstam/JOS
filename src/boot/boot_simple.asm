; Setup to write the contents of al in tty mode
mov ah, 0x0e

; Setup counter, inititalize to ASCII '0'
mov bl, 0x30

outLoop:
	; Copy each character into a1 and raise an interrupt
	mov al, 'H'
	int 0x10
	mov al, 'e'
	int 0x10
	mov al, 'l'
	int 0x10
	int 0x10 		; al still has 'l' in it
	mov al, 'o'
	int 0x10
	mov al, ' '
	int 0x10
	mov al, bl
	int 0x10
	mov al, 0xA		; Newline
	int 0x10
	mov al, 0xD		; Carriage return
	int 0x10
	inc bl			; Increment counter
	cmp bl, 0x39	; Check if equal to ASCII '9'
	jle outLoop		; Go back to top if less than or equal to '9'
	
end:
	; Infinite loop
	jmp $

; Fill with 510 zeroes minus the above code
times 510-($-$$) db 0

; Magic number
dw 0xaa55