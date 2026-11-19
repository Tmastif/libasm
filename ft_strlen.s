; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strlen.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ilazar <corach.am@gmail.com>               +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/11/13 13:15:36 by ilazar            #+#    #+#              ;
;    Updated: 2026/11/13 13:20:08 by ilazar           ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

section .text           ; code goes in the .text section
global ft_strlen        ; make the symbol visible to the linker (so C can call it)

ft_strlen:

    xor rax, rax        ; clear rax (this will hold the length)
.loop:
    cmp byte [rdi + rax], 0 ; compare the byte at address rdi + rax with 0 (null terminator)
    je .done            ; jump to label if the last cmp was equal
    inc rax             ; increment length
    jmp .loop           ; always jump to label loop
.done:
    ret                 ; return, length is in rax


; ---------------------------------------------------------------------------
;
; size_t ft_strlen(const char *s)
; {
;     size_t i = 0;              // xor rax, rax
;     while (s[i] != '\0')       // cmp byte [rdi + rax], 0  /  je .done
;         i++;                   // inc rax  /  jmp .loop
;     return i;                  // ret  (i is already in rax)
; }
