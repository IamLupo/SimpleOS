cmake_minimum_required(VERSION 3.10)

project(SimpleOS)

# copy iso directory to build directory
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/iso DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

# Set NASM and GCC flags
set(CMAKE_ASM_NASM_OBJECT_FORMAT elf32)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -m32")

# Set custom linker
set(CMAKE_C_LINK_EXECUTABLE ld)

# Add NASM and C source files
set(NASM_SOURCES src/kernel.asm)
set(C_SOURCES src/kernel.c)

# Compile NASM sources
enable_language(ASM_NASM)
add_library(kasm OBJECT ${NASM_SOURCES})

# Compile C sources
add_library(kc OBJECT ${C_SOURCES})

# Add custom target for linking
add_custom_target(kernel.bin ALL
    COMMAND ld -m elf_i386 -T ${PROJECT_SOURCE_DIR}/src/link.ld -o kernel.bin $<TARGET_OBJECTS:kasm> $<TARGET_OBJECTS:kc>
    DEPENDS kasm kc
    COMMENT "Linking kernel.bin"
    VERBATIM
	COMMAND cp ${CMAKE_CURRENT_BINARY_DIR}/kernel.bin ${CMAKE_CURRENT_BINARY_DIR}/iso/boot/kernel.bin
	COMMAND grub-mkrescue -o os.iso ${CMAKE_CURRENT_BINARY_DIR}/iso
    COMMENT "Create os.iso"
    VERBATIM
)
