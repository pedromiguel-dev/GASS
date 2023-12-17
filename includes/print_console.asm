BITS 64

%include "includes/stdio.asm/write_syscall.asm"

;
; input: rax: buffer, rdi: buffer size
; outputs: rax: num bites written
;
print_console:
    mov rsi, rdi
    mov rdi, rax
    mov rax, 1
    call write_syscall
    ret