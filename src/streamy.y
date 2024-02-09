%{
#include <stdio.h>
#include "streamy.tab.h"
#include "streamy.yy.h"
%}

%token INTEGER VARIABLE NUMBER LITERAL_TEXT
%%

page:
    text '\n' { printf("%d\n", $2); }
    |
    tag
    |
    page text
    |
    page tag
    |
    '\n'
    ;

text:

tag:
    ';'
    | expr ';'
    ;


expr:
    INTEGER         { $$ = $1; }
    | expr '+' INTEGER { $$ = $1 + $3; }
    | expr '+' VARIABLE { $$ = $1 + $3; }
    | expr '-' INTEGER { $$ = $1 + $3; }
    | expr '-' VARIABLE { $$ = $1 + $3; }
    | expr '*' INTEGER { $$ = $1 + $3; }
    | expr '*' VARIABLE { $$ = $1 + $3; }
    ;

%%

int yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
    return 0;
}