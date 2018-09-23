; Set the offset to be bootsector code
[org 0x7c00]
	; Set the stack somewhere safely away from us
    mov bp, 0x8000
    mov sp, bp
	
	; Print greeting message
	mov bx, GREETING
	call print_string
	call print_newline
	
	; es:bx = 0x0000:0x9000 = 0x09000
	mov bx, 0x9000 
	
	; Note - BIOS sets dl for the boot disk number
    mov dh, 2 
	call disk_load
	
	mov bx, DISK_SECTOR1_HEADER
	call print_string
	; Get first word
	mov dx, [0x9000]
	call print_hex_4
	call print_newline
	
	mov bx, DISK_SECTOR2_HEADER
	call print_string
	; Get first word
	mov dx, [0x9000 + 512]
	call print_hex_4
	call print_newline

	; Infinite Loop
	jmp $

; Include subroutines
%include "src/boot/boot_sect_print.asm"
%include "src/boot/boot_sect_print_hex.asm"
%include "src/boot/boot_sect_disk.asm"

; Data
GREETING:
	db 'Starting Low-level Boot...', 0
DISK_SECTOR1_HEADER:
	db 'First word of sector 1: ', 0
DISK_SECTOR2_HEADER:
	db 'First word of sector 2: ', 0

; Fill with 510 zeroes minus the above code
times 510-($-$$) db 0
; Magic number
dw 0xaa55

; Note: the boot sector is sector 1, cylinder 0, head 0, hdd 0
; Here we start sector 2, etc
times 256 dw 0xcafe ; sector 2 = 512 bytes
times 256 dw 0xbabe ; sector 3 = 512 bytes