SimpleOS with kernel in C and Assembly

## Building manually the kernel

	nasm -f elf32 src/kernel.asm -o src/kasm.o
	gcc -m32 -c src/kernel.c -o kc.o
	ld -m elf_i386 -T link.ld -o iso/boot/kernel.bin kasm.o kc.o
	grub-mkrescue -o os.iso iso


## Build cmake

	mkdir build
	cd build
	cmake ..
	make


## Run in qemu

	qemu-system-i386 -kernel build/kernel.bin -vnc :1

