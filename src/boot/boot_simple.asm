; Set the offset to be bootsector code
[org 0x7c00]

; Print greeting message
mov bx, HELLO
call print_string
call print_newline

call print_newline

mov dx, 0x1234
call print_hex_4
call print_newline
mov dx, 0x12fe
call print_hex_4
call print_newline
mov dx, 0xabcd
call print_hex_4
call print_newline

call print_newline

; Print farewell message
mov bx, GOODBYE
call print_string
call print_newline

; Infinite Loop
jmp $

; Include subroutines
%include "src/boot/boot_sect_print.asm"
%include "src/boot/boot_sect_print_hex.asm"

; Data
HELLO:
	db 'Hello, World!', 0
	
GOODBYE:
	db 'Goodbye!', 0

; Fill with 510 zeroes minus the above code
times 510-($-$$) db 0

; Magic number
dw 0xaa55