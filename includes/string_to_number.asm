BITS 64
;--------------------
; input: rax: buffer pointer
; returns: rax: number or 0 if NAN, rbx: 0 or 1 if NAN
;
string_to_number:
    
	; initialize registers
	mov rsi, rax
	
	xor rcx, rcx
	xor rax, rax
	xor rbx, rbx
	
	loop_input:
	; Load the current character from the string into bl
    mov bl, [rsi + rcx] ; get first number
	
	; Check for the terminator (end of the string)
    cmp bl, 0xA
    je  done_parse
	
	; Convert ASCII to integer
    sub bl, 48
	cmp bl, 9
	jg  NAN
	
	; Multiply the current result by 10 (shift left by one decimal place)
	imul rax, 10
	add rax, rbx
		
	; Move to the next character in the string
    inc ecx
	
	; Repeat the loop
    jmp loop_input
	
	NAN:
	mov rbx, 1
	ret
	
	done_parse:
	xor rbx, rbx
	ret