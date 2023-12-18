BITS 64

random_number:                                           ;pseudo-random number generator using LCG 
    mov rdi, rax
    rdtsc
    mov [rdi], rdx

    call calc_new

    xor rdx, rdx
    mov rcx, 10
    div rcx
    add rcx, 1                                           ; dx contains the remainder - from 0 to 9
    ;add rdx, '0'                                         ; to ASCII from '0' to '9'

    mov [rdi], rdx
    ret

; --------------------
; inputs: none  (modifies PRN seed variable)
; overwrite: RDX.
; returns: RAX = next random number
calc_new:                                                   ; implements LCG
    mov rax, 25173                                          ; LCG multiplier
    mul qword [rdi]
    add rax, 13849
    mov qword [rdi], rax
    ret
