/*
   File Name:  streamy.y
   Build Date: Wed Feb 14 12:02:37 AM CST 2024
   Version:    0.0.1
*/
%{

#include <stdio.h>
#include "streamy.yy.h"

int fileno(char *);
int yyerror(char *);
int yylex(void);

%}


%token PLUS
%token MINUS
%token NUMBER

%%
program:
        program statement '\n'
        |
        ;

statement:
        expr    { printf("%d\n", $1); }
        |
        ;
expr:
        NUMBER
            {
                $$ = $1;
                printf("%d\n", $$);
            }
        |   NUMBER PLUS expr
            {
                $$ = $1 + $3;
                printf("%d\n", $1);
            }
        |   NUMBER MINUS expr
            {
                $$ = $1 - $3;
            }
        ;

%%

int fileno(char *)
{
    return 0;
}

int yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
    return 0;
}

int main(void)
{
    yyparse();
    return 0;
}