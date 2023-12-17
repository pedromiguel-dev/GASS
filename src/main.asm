BITS 64

%include "includes/string_to_number.asm"
%include "includes/print_console.asm"

section .data
    PRN:        dd      1

    hello       db      "Guess my number: ",0
    hello_s     equ     $-hello

    oor_msg     db      "Please write a number between 1 and 10", 0xa, 0 ; out of range msg
    oor_msg_size equ    $-oor_msg

    user_buff_size equ    32
    
section .bss
    user_buff   resb      32

section .text
global _start

_start:
    call random_number

    guess_loop:
    mov rax, hello
    mov rdi, hello_s
    call print_console

    call get_input
    call compare_input
    call feedback

    loop guess_loop
exit:
    mov rax, 60
    mov rdi, 1
    syscall

;--------------------
; inputs:   none
; returns:  rax: number 
;
get_input:
    push rcx

    mov rax, 0
    mov rdi, 0
    mov rsi, user_buff
    mov rdx, user_buff_size
    syscall

    mov rax, user_buff
    call string_to_number

    dbf_1:
    mov [user_buff], rax

    cmp rax, 10
    jg out_of_range
    cmp rax, 0
    jl out_of_range

    pop rcx
    ret

    out_of_range:
        mov rax, oor_msg
        mov rdi, oor_msg_size
        call print_console

        jmp guess_loop

; TODO: compare imput
compare_input:
    ret

; TODO: feedback
feedback:
    ret    

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

; --------------------
; inputs: none  (modifies PRN seed variable)
; overwrite: RDX.
; returns: RAX = next random number
calc_new:                                               ; implements LCG
    mov rax, 25173                                       ; LCG multiplier
    mul qword [PRN]
    add rax, 13849
    mov qword [PRN], rax
    ret

