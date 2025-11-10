[org 0x7C00]
[BITS 16]

start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7B00

    mov ax, 0x0003
    int 0x10

    mov si, msg_welcome
    call print
    mov si, msg_memory
    call print
    
    int 0x12
    call print_decimal
    
    mov si, msg_kb
    call print
    mov ah, 0x0E
    mov al, 0x0D
    int 0x10
    mov al, 0x0A
    int 0x10
    
    mov si, msg_press_key
    call print
    mov ah, 0
    int 0x16
    
    mov si, msg_reboot
    call print
    int 0x19

print:
    mov ah, 0x0E
.loop:
    lodsb
    test al, al
    jz .done
    int 0x10
    jmp .loop
.done:
    ret

print_decimal:
    mov bx, 10
    xor cx, cx
.convert:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz .convert
.print:
    pop ax
    add al, '0'
    mov ah, 0x0E
    int 0x10
    loop .print
    ret

msg_welcome:   db "Simple Bootloader", 0x0D, 0x0A, 0
msg_memory:    db "Conventional memory: ", 0
msg_kb:        db " KB", 0
msg_press_key: db "Press any key to reboot...", 0x0D, 0x0A, 0
msg_reboot:    db "Rebooting...", 0x0D, 0x0A, 0

times 510-($-$$) db 0
dw 0xAA55

