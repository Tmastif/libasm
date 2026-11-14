; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcpy.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ilazar <corach.am@gmail.com>               +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/11/13 14:12:15 by ilazar            #+#    #+#              ;
;    Updated: 2026/11/13 14:12:15 by ilazar           ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

section .text
global ft_strcpy

; char *ft_strcpy(char *dst, const char *src)
;   rdi = dst
;   rsi = src
;   return: rax = original dst

ft_strcpy:
    xor rcx, rcx
.loop:
    mov dl, [rsi + rcx] ; load a byte from src. dl - is only 1 byte, fits a char
    mov [rdi + rcx], dl ; store it in dst
    cmp dl, 0 ; check for '\0'
    je .done
    inc rcx
    jmp .loop
.done:
    mov rax, rdi ; return dst
    ret

; ---------------------------------------------------------------------------
; in C:
;
; char *ft_strcpy(char *dst, const char *src)
; {
;     size_t i = 0;
;     while (src[i] != '\0')
;     {
;         dst[i] = src[i];
;         i++;
;     }
;     dst[i] = '\0';
;     return dst;
; }
