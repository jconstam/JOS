; SUBROUTINE - Load sectors from disk
;	Number of sectors in 'dh'
;	Drive index in 'dl'
;	Loads into ES:BX

disk_load:
	pusha
	
	; Need to save value in dx to use later
	push dx
	
	; Set ah to hold 'disk read' function (0x02)
	mov ah, 0x02
	; Set al to hold number of sectors to read (0x01-0x80)
	mov al, dh
	; Set cl to hold sector number (0x01-0x11) - 0x01 is boot, 0x02 is the first available
	mov cl, 0x02
	; Set ch to hold cylinder number (0x0-0x3FF), includes upper 2 bits in cl
	mov ch, 0x00
	; Already have dl set to driver number from caller
	; Set dh to drive type (0=floppy, 1=floppy2, 0x80=hdd, 0x81=hdd2)
	mov dh, 0x00
	
	; [es:bx] <- points to buffer where data will be stored
	; Set up by caller
	int 0x13
	; If there was an error, the carry bit gets set
	jc disk_load_read_error
	
	; Get back value of dx
	pop dx
	
	; BIOS sets al to number of sectors read
	cmp al, dh
	jne disk_load_sectors_error
	
	popa
	ret
	
disk_load_read_error:
	; Print error message
	mov bx, DISK_LOAD_READ_ERROR
	call print_string
	call print_newline
	; ah contains the error code, dl has the disk drive that dropped the error
	mov dh, ah
	call print_hex_4
	jmp disk_load_loop
	
disk_load_sectors_error:
	mov bx, DISK_LOAD_SECTORS_ERROR
	call print_string
	call print_newline
	
disk_load_loop:
	jmp $
	
DISK_LOAD_READ_ERROR:
	db "Disk read error", 0
DISK_LOAD_SECTORS_ERROR:
	db "Incorrect number of sectors read", 0