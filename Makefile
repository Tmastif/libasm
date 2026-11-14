# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ilazar <corach.am@gmail.com>               +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/11/13 13:16:37 by ilazar            #+#    #+#              #
#    Updated: 2026/11/14 19:11:14 by ilazar           ###   ########.fr        #
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
			  #ft_strdup.s \
			  ft_calloc.s

# Bonus sources (must end in _bonus.s)
SRCS_BONUS	= ft_atoi_base_bonus.s \
			  ft_list_push_front_bonus.s \
			  ft_list_size_bonus.s \
			  ft_list_sort_bonus.s \
			  ft_list_remove_if_bonus.s \
			  ft_simd_memchr_bonus.s

OBJS		= $(SRCS:.s=.o)
OBJS_BONUS	= $(SRCS_BONUS:.s=.o)

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

# Bonus: add the bonus objects into the same library.
# The .bonus file is a marker so `make bonus` doesn't relink every time.
bonus: .bonus

.bonus: $(OBJS) $(OBJS_BONUS)
	ar rcs $(NAME) $(OBJS) $(OBJS_BONUS)
	@touch .bonus

# Build the test program against the library
$(TEST): $(NAME) $(TEST_SRC) libasm.h
	$(CC) $(CFLAGS) $(TEST_SRC) -L. -lasm -o $(TEST)

clean:
	rm -f $(OBJS) $(OBJS_BONUS) .bonus

fclean: clean
	rm -f $(NAME) $(TEST)

re: fclean all

.PHONY: all bonus clean fclean re
