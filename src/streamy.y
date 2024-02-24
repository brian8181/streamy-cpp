/*
   File Name:  streamy.y
   Build Date: Wed Feb 14 12:02:37 AM CST 2024
   Version:    0.0.1
*/
%{

#include <stdio.h>
#include "streamy.yy.h"

int fileno(char *);
int newfile(char* fn);
int yyerror(char *);
int yylex(void);

%}

%token NEWLINE
%token PLUS
%token MINUS
%token NUMBER

%%
program:
        program statement '\n'
        |
        ;

statement:
        expr    { printf("STMT %d\n", $1); }
        |
        ;
expr:
        NUMBER
            {
                $$ = $1;
                printf("NUMBER %d\n", $$);
            }
        |   NUMBER PLUS expr
            {
                $$ = $1 + $3;
                printf("PLUS %d\n", $1);
            }
        |   NUMBER MINUS expr
            {
                $$ = $1 - $3;
                printf("MINUS %d\n", $1);
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

int main(int argc , char* argv[])
{
    if(argc < 2)
    {
        fprintf(stderr, "Error: missing paramter\n");
        fprintf(stderr, "lex [OPTION]... [FilE]...\n");
        // commnad line
        yyparse();
        return 1;
    }

    if(newfile(argv[1]))
        yyparse();

    return 0;
}