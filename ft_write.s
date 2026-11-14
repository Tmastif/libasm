; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_write.s                                         :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ilazar <corach.am@gmail.com>               +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/11/14 18:24:29 by ilazar            #+#    #+#              ;
;    Updated: 2026/11/14 18:24:29 by ilazar           ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

section .text
global ft_write
extern __errno_location     ; libc function: returns a pointer to errno

; ssize_t ft_write(int fd, const void *buf, size_t count)
;   rdi = fd
;   rsi = buf
;   rdx = count
;   return: rax = number of bytes written
;           or -1 on error, with errno set

ft_write:
    mov rax, 1 ; syscall number for write
    syscall
    test rax, rax ; check if rax is negative (error)
    js .error
    ret ; rax is a positive number of bytes written
.error:
    push rbx ; save rbx because we will use it to store errno
    neg rax ; make rax positive
    mov rbx, rax ; save the error number in rbx
    call __errno_location wrt ..plt ; get pointer to errno
    mov [rax], ebx ; set the error number to the memory at this adress
    mov rax, -1 ; return -1 to indicate error
    pop rbx ; restore rbx
    ret