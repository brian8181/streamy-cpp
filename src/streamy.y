/*
   File Name:  streamy.y
   Build Date: Wed Feb 14 12:02:37 AM CST 2024
   Version:    0.0.1
*/
%{

#include <stdio.h>
#include "streamy.yy.h"

int fileno(char *);
void yyerror(char *);
int yylex(void);
extern void* pyyval;

%}

//%type  escape
%token TEXT
%token NEWLINE
%token OPEN_BRACE
%token CLOSE_BRACE
%token SYMBOL
%token EQUALS_EQUALS
%token STRING_LITERAL
%token NUMERIC_LITERAL

%%

program:
        program NEWLINE
        {
            printf("program %s\n", yytext );
        }
        |
        escape
        {
            printf("Escape %s\n", yytext );
        }
        |
        html
        {
            printf("html %s\n", yytext );
        }
        |
        escape html
        {
            printf("html %s\n", yytext );
        }
        ;

escape:
        OPEN_BRACE SYMBOL CLOSE_BRACE
        {
            $$ = $1;
            yytext--;
            yytext--;
            printf("v=%s", yytext);
        }
        ;
html:

        html TEXT
        {
            printf("HTML%s\n", yytext);
        }
        |
        TEXT
        {
            printf("TEXT%s\n", yytext);
        }
        ;


%%

#include <stdio.h>
extern char* yytext;
extern int column;

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
        fprintf(stderr, "Missing filename paramter\n interactive mode");
        fprintf(stderr, "lex [OPTION]... [FilE]...\n");
        fprintf(stderr, "Interactive mode...\n");
    }
    yyparse();
}