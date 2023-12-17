BITS 64

;
; inputs: rax file descriptor, rdi: buffer, rsi: size
; outputs: rax: number of bites read
write_syscall:
    mov rdx, rsi
    mov rsi, rdi
    mov rdi, rax

    mov rax, 1
    syscall
    ret