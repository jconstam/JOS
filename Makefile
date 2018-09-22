ROOT=$(shell pwd)

SRC=$(ROOT)/src
OUT=$(ROOT)/output

ASM=$(shell which nasm)
QEMU=$(shell which qemu-system-x86_64)

simple_boot: build_simple_boot qemu_simple_boot

clean:
	@rm -rf $(OUT)
	
make_output:
	@mkdir -p $(OUT)
	
BOOT_SIMPLE_BIN=$(OUT)/boot_simple.bin
	
build_simple_boot: make_output
	$(ASM) -f bin $(SRC)/boot/boot_simple.asm -o $(BOOT_SIMPLE_BIN)
	
qemu_simple_boot:
	$(QEMU) -curses $(BOOT_SIMPLE_BIN)