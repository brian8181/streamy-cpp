#ifndef _UTILITY_H_
#define _UTILITY_H_

#include <stdio.h>
#include <regex.h>

int regex_match(char * pattern, char* search, size_t n, regmatch_t* pmatch)
{
    // create regular expression
    regex_t reegex;
    if(regcomp( &reegex, pattern, 0))
    {
        return regexec( &reegex, search, n, pmatch, 0);
    }
}
size_t regex_error(int errcode, const regex_t *preg, char *errbuf, size_t errbuf_size)
{
    return regerror(errcode, preg, errbuf, errbuf_size);
}

void regex_free(regex_t* preg)
{
    regfree(preg);
}

#endif
