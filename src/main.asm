BITS 64

section .data
    hello       db      "Guess my number", 0xa,0
    hello_s     equ     $-hello
    
section .text
global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, hello
    mov rdx, hello_s
    syscall

exit:
    mov rax, 60
    mov rdi, 1
    syscall
