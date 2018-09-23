ROOT=$(shell pwd)

SRC=$(ROOT)/src
OUT=$(ROOT)/output

ASM=$(shell which nasm)
QEMU=$(shell which qemu-system-x86_64)

boot: build_boot qemu_boot

clean:
	@rm -rf $(OUT)
	
check_tools:
ifeq ($(ASM),)
	sudo apt install nasm
endif
ifeq ($(QEMU),)
	sudo apt install qemu
endif
	
make_output: check_tools
	@mkdir -p $(OUT)
	
BOOT_BIN=$(OUT)/boot.bin
	
build_boot: make_output
	$(ASM) -f bin $(SRC)/boot/boot_sect_main.asm -o $(BOOT_BIN)
	
qemu_boot:
	$(QEMU) -curses $(BOOT_BIN)

simple_boot: build_simple_boot qemu_simple_boot
	
BOOT_SIMPLE_BIN=$(OUT)/boot_simple.bin
	
build_simple_boot: make_output
	$(ASM) -f bin $(SRC)/boot/boot_simple.asm -o $(BOOT_SIMPLE_BIN)
	
qemu_simple_boot:
	$(QEMU) -curses $(BOOT_SIMPLE_BIN)