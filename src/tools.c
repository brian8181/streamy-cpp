#include "stdio.h"
#include "stddef.h"
#include "string.h"
#include "tools.h"
#include "regex.h"

void lex(char* s)
{
    strchr(s, '{');
    char* opers = "+-=*";
    strpbrk(s, opers);
}

int regx(char* s, char* reg)
{
    // compile
    regex_t rexp;
    int ret;
    ret = regcomp( &rexp, reg, 0);

    // compile error
    if(ret != 0)
        return ret;

    // match
    regmatch_t match;
    return regexec(&rexp, s, 0, &match, 0);
}

int _find(const char* s, const char c)
{
    int i = 0;
    while(s[i] != c)
        ++i;
    return i;
}

int _char_find(const char* s, const char c)
{
    return _find(s, c);
}

int _str_len(const char* s)
{
    return _find(s, '\0');
}


// get str len of null terminated string
int str_len(const char* s)
{
    int i = 0;
    while(s[i] != '\0')
        ++i;
    return i;
}

// find first of
int find(const char* s, const char c)
{
    int sz = str_len(s);
    for(int i = 0; i < sz; ++i)
    {
        if(s[i] ==  c)
            return i;
    }
}

void main()
{
    char* s = "{$state}\0";
    char c = '{';
    char* r = strchr(s, c);
    printf("String after |%c| is - |%s|\n", c, r);
    int pos = find(s, c);
    printf("found |%c| @ |%d| in |%s|\n", c, pos, s);
    char* name = "Boby";
    int len = str_len(name);
    printf("name len=%i\n", len);

    char* s2 = "abc";
    if(regx(s2, s2) != 0)
    {
        printf("regx: error, return %i\n", -1);
    }

}