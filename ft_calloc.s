; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_calloc.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ilazar <corach.am@gmail.com>               +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/11/19 15:30:09 by ilazar            #+#    #+#              ;
;    Updated: 2026/11/19 15:30:09 by ilazar           ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

section .text
global ft_calloc
extern malloc               ; libc: void *malloc(size_t size)
extern __errno_location     ; libc: returns a pointer to errno

; void *ft_calloc(size_t nmemb, size_t size)
;   rdi = nmemb   (how many elements)
;   rsi = size    (size of one element)
;   return: rax = pointer to nmemb * size bytes, all set to 0
;   Ex: calloc(5, 4) gives 20 bytes of zeros, like an int[5] set to 0.
;           or NULL if nmemb * size overflows (errno = ENOMEM = 12)
;           or NULL if malloc fails (malloc sets errno itself)

ft_calloc:
    mov rax, rdi
    mul rsi ; rax * rsi -> rax = total (uses rdx and destroys it)
    jo .overflow ; result didn't fit
    push rax ; save total, align stack
    mov rdi, rax
    call malloc wrt ..plt ; rax = p or 0
    test rax, rax ; null check
    jz .fail
    mov rdx, [rsp] ; take saved total from stack
    xor rcx, rcx
.loop:
    cmp rcx, rdx ; if i == total
    je .done
    mov byte [rax + rcx], 0 ; p[i] = 0
    inc rcx
    jmp .loop
.done:
    pop rcx ; align stack, rcx is free to use
    ret ; rax is pointer p
.overflow:
    push rax ; just for aligning
    call __errno_location wrt ..plt
    mov ecx, 12 ; write int to 4 bytes
    mov [rax], ecx ; errno = ENOMEM 12
    pop rax ; align
    xor rax, rax ; return null 0
    ret
.fail:
    pop rcx ; align
    ret ; rax = 0 and malloc has set errno


; ---------------------------------------------------------------------------
; in C:
;
; void *ft_calloc(size_t nmemb, size_t size)
; {
;     size_t total;
;     if (__builtin_mul_overflow(nmemb, size, &total))  // if nmemb * size is too big
;     {
;         errno = ENOMEM;
;         return NULL;
;     }
;     unsigned char *p = malloc(total);
;     if (p == NULL)
;         return NULL;
;     for (size_t i = 0; i < total; i++)               // zero every byte
;         p[i] = 0;
;     return p;
; }
