/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ilazar <corach.am@gmail.com>               +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/11/13 13:37:38 by ilazar            #+#    #+#             */
/*   Updated: 2026/11/13 13:39:04 by ilazar           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <string.h>
#include "libasm.h"

int main(void)
{
    const char *tests[] = {"", "a", "hello", "A fox doesn't need an umbrella"};
    for (int i = 0; i < 4; i++)
        printf("[%s] mine=%zu real=%zu\n", tests[i], ft_strlen(tests[i]), strlen(tests[i]));
    return 0;
}