; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strdup.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ilazar <corach.am@gmail.com>               +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/11/16 12:32:37 by ilazar            #+#    #+#              ;
;    Updated: 2026/11/16 12:32:37 by ilazar           ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

section .text
global ft_strdup
extern malloc               ; libc: void *malloc(size_t size)
extern ft_strlen            ; my function: size_t ft_strlen(const char *s)
extern ft_strcpy            ; my function: char *ft_strcpy(char *dst, const char *src)

; char *ft_strdup(const char *s)
;   rdi = s
;   return: rax = pointer to a new malloc'd copy of s
;           or NULL if malloc failed (malloc already sets errno = ENOMEM)

ft_strdup:
    push rdi ; keep s safe and align stack
    call ft_strlen ; uses rdi, result is on rax
    mov rdi, rax ; add space for null terminator
    inc rdi
    call malloc wrt ..plt ; rax = dup - new memory, or 0 if failed
    test rax, rax ; check if null
    jz .fail
    mov rdi, rax ; new memory add in rdi for strcpy
    mov rsi, [rsp] ; read top of the stack, where s is kept. rsi is ready for strcopy
    call ft_strcpy ; returns dst the new pointer to rax
    pop rdi ; undo the push
    ret ; caller gets copy
.fail:
    pop rdi
    ret



; ---------------------------------------------------------------------------
; in C:
;
; char *ft_strdup(const char *s)
; {
;     size_t len = ft_strlen(s);
;     char *dup = malloc(len + 1);        // +1 for the '\0'
;     if (dup == NULL)
;         return NULL;
;     ft_strcpy(dup, s);
;     return dup;
; }
