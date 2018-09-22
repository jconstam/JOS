; Infinite loop
loop:
	jmp loop

; Fill with 510 zeroes minus the above code
times 510-($-$$) db 0

; Magic number
dw 0xaa55