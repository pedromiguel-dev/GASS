BITS 64

%include "includes/string_to_number.asm"
%include "includes/print_console.asm"
%include "includes/read_console.asm"
%include "includes/random_number.asm"

section .data
    PRN:        dd      1
    
    hello_msg       db      "Guess my number: ",0
    hello_msg_s     equ     $-hello_msg

    oor_msg     db      "Please write a number between 1 and 10", 0xa, 0 ; out of range msg
    oor_msg_size equ    $-oor_msg

    guessed_msg  db      "You got it, the right number is: ", 0
    guessed_msg_size  equ $-guessed_msg

    lower_msg   db      "This number is lower", 0xa, 0
    lower_msg_size equ  $-lower_msg

    greater_msg db      "This number is greater", 0xa,0
    greater_msg_size equ    $-greater_msg


    user_buff_size equ    32
    
section .bss
    user_string_buff   resb      32
    user_number_buff   resb      32

section .text
global _start

_start:
    mov rax, PRN
    call random_number

    mov rcx, 1
    guess_loop:
    push rcx

    mov rax, hello_msg
    mov rdi, hello_msg_s
    call print_console

    mov rax, user_string_buff
    mov rdi, user_number_buff
    call get_input

    mov rax, [user_number_buff]
    mov rdi, [PRN]
    pop rcx
    call compare_input

    cmp rcx, 0
    jnz guess_loop

exit:
    mov rax, 60
    mov rdi, 1
    syscall

;--------------------
; inputs:   rax: string buffer, rdi: number buffer 
; returns:  rax: number
; 
get_input:
    mov rsi, rax ; string buf
    push rdi     ; number buf

    mov rax, rsi
    mov rdi, user_buff_size
    call read_console

    mov rax, rsi
    call string_to_number

    dbf_1:
    pop rdi
    mov [rdi], rax

    cmp rax, 10
    jg out_of_range
    cmp rax, 0
    jl out_of_range

    ret ; number in eax and in the user_number_buff

    out_of_range:
        mov rax, oor_msg
        mov rdi, oor_msg_size
        call print_console

        jmp guess_loop

compare_input:
    cmp rax, rdi
    je  got_it
    jl  lower
    jg  greater

    got_it:
        mov rax, guessed_msg
        mov rdi, guessed_msg_size
        call print_console

        mov rax, user_string_buff
        mov rdi, user_buff_size
        call print_console

        xor rcx, rcx
        ret
    lower:
        mov rax, lower_msg
        mov rdi, lower_msg_size
        call print_console
        ret
    greater:
        mov rax, greater_msg
        mov rdi, greater_msg_size
        call print_console
        ret
