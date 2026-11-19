# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ilazar <corach.am@gmail.com>               +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/11/13 13:16:37 by ilazar            #+#    #+#              #
#    Updated: 2026/11/19 15:30:31 by ilazar           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


NAME		= libasm.a

# Assembler: NASM, 64-bit ELF output (Linux object format)
NASM		= nasm
NASMFLAGS	= -f elf64

# C compiler, only used for the test program
CC			= cc
CFLAGS		= -Wall -Wextra -Werror

# Mandatory sources
SRCS		= ft_strlen.s \
			  ft_strcpy.s \
			  ft_strcmp.s \
			  ft_write.s \
			  ft_read.s \
			  ft_strdup.s \
			  ft_calloc.s

OBJS		= $(SRCS:.s=.o)

# Test program
TEST		= test
TEST_SRC	= main.c

all: $(NAME)

# Pack the object files into a static library
$(NAME): $(OBJS)
	ar rcs $(NAME) $(OBJS)

# Pattern rule: how to turn any .s into a .o
%.o: %.s
	$(NASM) $(NASMFLAGS) $< -o $@

# Build the test program against the library
$(TEST): $(NAME) $(TEST_SRC) libasm.h
	$(CC) $(CFLAGS) $(TEST_SRC) -L. -lasm -o $(TEST)

clean:
	rm -f $(OBJS)

fclean: clean
	rm -f $(NAME) $(TEST)

re: fclean all

.PHONY: all clean fclean re
