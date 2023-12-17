BITS 64

section .data
    PRN:        dd      1
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

    call random_number

exit:
    mov rax, 60
    mov rdi, 1
    syscall

random_number:                                         ;pseudo-random number generator using LCG 
    rdtsc
    mov [PRN], rdx

    call calc_new

    xor rdx, rdx
    mov rcx, 10
    div rcx                                              ; dx contains the remainder - from 0 to 9
    add rdx, '0'                                         ; to ASCII from '0' to '9'

    mov [PRN], rdx
    ret

; ----------------
; inputs: none  (modifies PRN seed variable)
; overwrite: RDX.
; returns: RAX = next random number
calc_new:                                               ; implements LCG
    mov rax, 25173                                       ; LCG multiplier
    mul qword [PRN]
    add rax, 13849
    mov qword [PRN], rax
    ret

