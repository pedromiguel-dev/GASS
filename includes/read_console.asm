BITS 64

%include "includes/stdio.asm/read_syscall.asm"

;
; input: rax: buffer, rdi: buffer size
; outputs: rax: num bites written
;
read_console:
    mov rsi, rdi
    mov rdi, rax
    mov rax, 0
    call read_syscall
    ret