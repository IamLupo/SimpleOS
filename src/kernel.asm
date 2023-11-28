;; kernel.asm
;; version 0.0.1

bits 32             ; NASM directive
section .text
    ; Multiboot spec
    align 4
    dd 0x1BADB002    ; Magic
    dd 0x00          ; Flags
    dd - (0x1BADB002 + 0x00) ; Checksum

    ; Additional Multiboot fields
    dd entry_point   ; Entry point
    dd initial_esp   ; Initial stack pointer
    dd 0x00          ; Bootloader name (null-terminated string)

global start
extern k_main       ; k_main is defined in the kernel.c file

start:
    cli              ; Stop interrupts

    call k_main

    hlt              ; Halt the CPU

section .data
    ; Additional Multiboot fields
    entry_point dd kernel_entry   ; Set to the actual entry point of your kernel
    initial_esp dd 0x0            ; Set to the initial stack pointer value
    bootloader_name db 'MyKernel', 0  ; Bootloader name (replace 'MyKernel' with your name)

section .bss
    ; Additional Multiboot fields
    kernel_entry resd 1   ; Reserve space for the entry point variable