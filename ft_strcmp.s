; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcmp.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ilazar <corach.am@gmail.com>               +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/11/14 17:28:17 by ilazar            #+#    #+#              ;
;    Updated: 2026/11/14 17:28:17 by ilazar           ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

section .text
global ft_strcmp

; int ft_strcmp(const char *s1, const char *s2)
;   rdi = s1
;   rsi = s2
;   return: eax = (unsigned char)s1[i] - (unsigned char)s2[i]
;           at the first difference (or 0 if equal)

ft_strcmp:
    xor rcx, rcx
.loop:
    movzx eax, byte [rdi + rcx] ; load a byte from s1 into eax, zeros the upper bits of eax
    movzx edx, byte [rsi + rcx] ; same for s2 into edx
    cmp eax, edx
    jne .done
    cmp eax, 0 ; check for null terminator
    je .done
    inc rcx
    jmp .loop
.done:
    sub eax, edx ; eax = eax - edx
    ret ; returns int in this case of strcmp, therefore eax is used instead of rax



; ---------------------------------------------------------------------------
; in C:
;
; int ft_strcmp(const char *s1, const char *s2)
; {
;     size_t i = 0;
;     while (s1[i] != '\0' && s1[i] == s2[i])
;         i++;
;     return (unsigned char)s1[i] - (unsigned char)s2[i];
; }
