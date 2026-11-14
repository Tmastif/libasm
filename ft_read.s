; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_read.s                                          :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ilazar <corach.am@gmail.com>               +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/11/14 18:57:45 by ilazar            #+#    #+#              ;
;    Updated: 2026/11/14 18:57:45 by ilazar           ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

section .text
global ft_read
extern __errno_location     ; libc function: returns a pointer to errno

; ssize_t ft_read(int fd, void *buf, size_t count)
;   rdi = fd
;   rsi = buf     (where to put the bytes)
;   rdx = count   (max bytes to read)
;   return: rax = number of bytes read (0 = end of file)
;           or -1 on error, with errno set

ft_read:
    mov rax, 0 ; syscall number for read
    syscall
    test rax, rax
    js .error
    ret
.error:
    push rbx ; save rbx because we will use it to store errno
    neg rax ; make rax positive
    mov rbx, rax ; save the error number in rbx
    call __errno_location wrt ..plt ; get pointer to errno
    mov [rax], ebx ; set the error number to the memory at this adress
    mov rax, -1 ; return -1 to indicate error
    pop rbx ; restore rbx
    ret