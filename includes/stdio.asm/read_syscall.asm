BITS 64

;
; inputs: rax file descriptor, rdi: buffer, rsi: size
; outputs: rax: number of bites read
read_syscall:
    mov rdx, rsi
    mov rsi, rdi
    mov rdi, rax

    mov rax, 0
    syscall
    ret