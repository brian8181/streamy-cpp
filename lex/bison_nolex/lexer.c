#include <ctype.h>
#include <stdlib.h>
#include <stdio.h>
#include "build/calc.tab.h"
#include "lexer.h"

int yyparse();

int yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
    return 0;
}

char* TOKS[] = { "3", "+", "2", ";", "\n", "\0" };

int yylex (void)
{
    static int i = 0;
    switch(i)
    {
    case 0:
        yylval.num = atoi(TOKS[i++]);
        return INTEGER;
    case 1:
        yylval.str = TOKS[i++];
        return PLUS;
    case 2:
        yylval.num = atoi(TOKS[i++]);
        return INTEGER;
    case 3:
        yylval.str = TOKS[i++];
        return SEMI_COLON;
     case 4:
        yylval.str = TOKS[i++];
        return NEWLINE;
     case 5:
        yylval.str = TOKS[i++];
        return 0;
    }
    return 0;
}

int main(void)
{
    yyparse();
    return 0;
}
