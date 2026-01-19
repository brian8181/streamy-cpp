#include <ctype.h>
#include <stdlib.h>
#include <stdio.h>
#include "lexer.h"

int yyparse();

int yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
    return 0;
}

int yylex (void)
{
    return 1;
}

int main(void)
{
    yyparse();
    return 0;
}
