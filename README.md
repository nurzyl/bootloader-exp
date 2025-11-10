## bootloader-exp

A 16-bit real-mode experimental bootloader written in NASM that demonstrates BIOS interrupt usage for memory querying, text output, and system reboot. It is written entirely in 16-bit NASM syntax and intended for educational and experimental BIOS-level testing, verified on QEMU 10.1.2 (qemu-system-i386) running on Arch Linux x86_64.

### Features
- Initializes real-mode segments and stack
- Clears video mode using INT 10h (mode 3)
- Queries conventional memory size via INT 12h
- Converts and prints memory size in decimal format
- Waits for a keypress before rebooting with INT 19h
- Minimal 512-byte boot sector with 0xAA55 signature

### Build
```
nasm -f bin bootloader.asm -o bootloader.bin
```

### Run 
```
qemu-system-i386 -drive format=raw,file=bootloader.bin
```
or 
```
qemu-system-x86_64 -drive format=raw,file=bootloader.bin
```

