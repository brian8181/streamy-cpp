/*
   File Name:  streamy.y
   Build Date: Wed Feb 14 12:02:37 AM CST 2024
   Version:    0.0.1
*/
%{

#include <stdio.h>
#include "stdlib.h"
#include "tokenizer.yy.h"

int fileno(char *);
void yyerror(char *);
// int yylex(void);`
// char* argv[255];
// char* str;

%}

/* %token TEXT
%token NEWLINE
%token OPEN_BRACE
%token CLOSE_BRACE
%token SYMBOL
%token EQUALS_EQUALS
%token STRING_LITERAL
%token NUMERIC_LITERAL */


%token PLUS
%token NEWLINE
%token SPACE
%union
{
    int num;
}

%type<num> expr
%token<num> NUMBER


%%

program: /* nothing */
        expr { printf("PRG\n"); }
        |
        NEWLINE { printf("END\n"); return 0; }
        ;
expr:
        NUMBER { printf("NUMBER %d\n", $1); }
        |
        NUMBER SPACE PLUS SPACE NUMBER
        {
            $$ = $1 + $5;
            printf("EXPR\n");
            printf("PLUS %d\n", $1);
        }
        ;
%%

#include <stdio.h>
//extern char* yytext;
// extern int column;

void yyerror(char *s)
{
    fprintf(stderr, "line %d: %s\n", yylineno, s);
}

int main(int argc , char* argv[])
{
    extern FILE *yyin;
    if(argc > 1)
    {
        if((yyin = fopen(argv[1], "r")) == NULL)
        {
            perror(argv[1]);
            exit(1);
        }
    }
    else
    {
        fprintf(stderr, "Missing filename paramter, help ->\n");
        fprintf(stderr, "lex [OPTION]... [FilE]...\n");
        fprintf(stderr, "Interactive mode...\n");
    }
    yyparse();
}