; Minimal bootloader for exp
; nasm -f bin bootloader.asm -o bootloader.bin
; qemu-system-x86_64 -drive format=raw,file=bootloader.bin
[org 0x7C00]
[BITS 16]

start:
    cli
    mov si, msg_cli
    call print
    
    xor ax, ax
    mov ds, ax
    mov si, msg_segments
    call print
    
    mov es, ax
    mov ss, ax
    
    mov sp, 0x7C00
    mov si, msg_stack
    call print
    
    sti
    mov si, msg_sti
    call print
    
    mov ax, 0x0003
    int 0x10
    mov si, msg_clear
    call print
    
    mov si, msg_complete
    call print
    
    mov si, msg_cpu
    call print
    
    mov cx, 10
.process_loop:
    mov al, '.'
    mov ah, 0x0E
    int 0x10
    
    push cx
    mov cx, 0xFFFF
.delay:
    loop .delay
    pop cx
    
    loop .process_loop
    
    call newline
    
    mov si, msg_ready
    call print

hang:
    cli
    hlt
    jmp hang

print:
    push ax
    mov ah, 0x0E
.loop:
    lodsb
    test al, al
    jz .done
    int 0x10
    jmp .loop
.done:
    pop ax
    ret

newline:
    push ax
    mov ah, 0x0E
    mov al, 0x0D
    int 0x10
    mov al, 0x0A
    int 0x10
    pop ax
    ret

msg_cli:      db "[1] CLI: Interrupts disabled", 0x0D, 0x0A, 0
msg_segments: db "[2] DS/ES/SS: Segments initialized", 0x0D, 0x0A, 0
msg_stack:    db "[3] SP=0x7C00: Stack ready", 0x0D, 0x0A, 0
msg_sti:      db "[4] STI: Interrupts enabled", 0x0D, 0x0A, 0
msg_clear:    db "[5] Video mode 3 set", 0x0D, 0x0A, 0
msg_complete: db "[6] Boot sequence complete", 0x0D, 0x0A, 0
msg_cpu:      db "[7] Processing", 0
msg_ready:    db 0x0D, 0x0A, "[8] System ready", 0x0D, 0x0A, 0

times 510-($-$$) db 0
dw 0xAA55
