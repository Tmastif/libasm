/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ilazar <ilazar@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/11/13 13:37:38 by ilazar            #+#    #+#             */
/*   Updated: 2026/11/19 17:42:02 by ilazar           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdint.h>
#include "libasm.h"

void test_strlen(void);
void test_strcpy(void);
void test_strcmp(void);
void test_write(void);
void test_read(void);
void test_strdup(void);
void test_calloc(void);


int main(void)
{
    test_strlen();
    test_strcpy();
    test_strcmp();
    test_write();
    test_read();
    test_strdup();
    test_calloc();
    
    return 0;
}

void test_strlen(void)
{
    printf("\nTesting ft_strlen...\n");
    const char *tests[] = {"", "a", "five5", "A fox doesn't need an umbrella"};
    for (int i = 0; i < 4; i++)
        printf("[%s] mine=%zu real=%zu\n", tests[i], ft_strlen(tests[i]), strlen(tests[i]));
    printf("\n");
}

void test_strcpy(void)
{
    printf("\nTesting ft_strcpy...\n");
    const char *tests[] = {"", "a", "five5", "A fox doesn't need an umbrella"};
    for (int i = 0; i < 4; i++)
    {
        char mine[100];
        char real[100];
        char *r = ft_strcpy(mine, tests[i]);
        strcpy(real, tests[i]);
        printf("[%s] mine=[%s] real=[%s] result=%s return same=%s\n", tests[i], mine, real,
        strcmp(mine, real) == 0 ? "OK" : "KO", r == mine ? "OK" : "KO"); // check same contact, check return the string pointer
    }
    printf("\n");
}
void test_strcmp(void)
{
    printf("\nTesting ft_strcmp...\n");
    const char *s1[] = {"abc", "abc", "abd", "", "a", "\200", "five5"};
    const char *s2[] = {"abc", "abd", "abc", "a", "", "a", "five"};
    for (int i = 0; i < 7; i++)
    {
        int m = ft_strcmp(s1[i], s2[i]);
        int r = strcmp(s1[i], s2[i]);
        printf("[%s] vs [%s] mine=%d real=%d result=%s\n", s1[i], s2[i], m, r,
        ((m > 0) == (r > 0) && (m < 0) == (r < 0)) ? "OK" : "KO"); // check only for negative or positive sign, not the exact value
    }
    printf("\n");
}

void test_write(void)
{
    printf("\nTesting ft_write...\n");
    const char *tests[] = {"", "a\n", "beetroot\n", "A fox doesn't need an umbrella\n"};
    for (int i = 0; i < 4; i++)
    {
        fflush(stdout);
        ssize_t m = ft_write(1, tests[i], strlen(tests[i]));
        ssize_t r = write(1, tests[i], strlen(tests[i]));
        printf("mine=%zd real=%zd result=%s\n", m, r, m == r ? "OK" : "KO");
    }
    errno = 0;
    ssize_t m = ft_write(-1, "x", 1);
    int m_errno = errno;
    errno = 0;
    ssize_t r = write(-1, "x", 1);
    int r_errno = errno;
    printf("[bad fd] mine=%zd errno=%d real=%zd errno=%d result=%s\n", m, m_errno, r, r_errno,
    (m == r && m_errno == r_errno) ? "OK" : "KO");
    printf("\n");
}

void test_read(void)
{
    printf("\nTesting ft_read...\n");
    const size_t sizes[] = {0, 1, 10, 100};
    for (int i = 0; i < 4; i++)
    {
        char mine[101] = {0}; //fill buffer with zeros to avoid garbage values
        char real[101] = {0};
        int fd1 = open("libasm.h", O_RDONLY);
        int fd2 = open("libasm.h", O_RDONLY);
        ssize_t m = ft_read(fd1, mine, sizes[i]);
        ssize_t r = read(fd2, real, sizes[i]);
        close(fd1);
        close(fd2);
        printf("[%zu bytes] mine=%zd real=%zd result=%s\n", sizes[i], m, r,
        (m == r && memcmp(mine, real, sizeof(mine)) == 0) ? "OK" : "KO"); // check how many bytes read, check if buffers content is identical
    }
    errno = 0;
    char buf[10];
    ssize_t m = ft_read(-1, buf, 10);
    int m_errno = errno;
    errno = 0;
    ssize_t r = read(-1, buf, 10);
    int r_errno = errno;
    printf("[bad fd] mine=%zd errno=%d real=%zd errno=%d result=%s\n", m, m_errno, r, r_errno,
    (m == r && m_errno == r_errno) ? "OK" : "KO");
    printf("\n");
}

void test_strdup(void)
{
    printf("\nTesting ft_strdup...\n");
    const char *tests[] = {"", "a", "beetroot", "A fox doesn't need an umbrella"};
    for (int i = 0; i < 4; i++)
    {
        char *m = ft_strdup(tests[i]);
        char *r = strdup(tests[i]);
        printf("[%s] mine=[%s] real=[%s] result=%s new_ptr=%s\n", tests[i], m, r,
        (m && strcmp(m, r) == 0) ? "OK" : "KO", (m && m != tests[i]) ? "OK" : "KO"); // check if the content is identical, check if new pointer is different from the original string
        free(m);
        free(r);
    }
    printf("\n");
}

void test_calloc(void)
{
    printf("\nTesting ft_calloc...\n");
    const size_t nmemb[] = {0, 1, 10, 5, 100};
    const size_t size[] = {0, 1, 1, 4, 8};
    for (int i = 0; i < 5; i++)
    {
        unsigned char *m = ft_calloc(nmemb[i], size[i]);
        int zeros = 1; // assume the memory is fully zeroed until proven otherwise
        for (size_t j = 0; m && j < nmemb[i] * size[i]; j++)
            if (m[j] != 0)
                zeros = 0; //found a non-zero byte, so the memory is not fully zeroed
        printf("[%zu x %zu] ptr=%s all_zero=%s\n", nmemb[i], size[i],
        m ? "OK" : "NULL", zeros ? "OK" : "KO"); // check if the pointer is not NULL, check if all bytes are zero
        free(m);
    }
    errno = 0;
    void *m = ft_calloc(SIZE_MAX, 2);
    void *r = calloc(SIZE_MAX, 2);
    int m_errno = errno;
    int r_errno = errno;
    printf("[overflow] mine=%p my errno=%d real=%p real errno=%d result=%s\n", m, m_errno, r, r_errno,
    (m == NULL && m_errno == ENOMEM) ? "OK" : "KO");
    printf("\n");
}
