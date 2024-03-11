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
char* argv[255];
char* str;

%}

%type program
%type  escape
%token TEXT
%token NEWLINE
%token OPEN_BRACE
%token CLOSE_BRACE
%token SYMBOL
%token EQUALS_EQUALS
%token STRING_LITERAL
%token NUMERIC_LITERAL

%%

program: /* nothing */
        NEWLINE { exit(0); }
        |
        program NEWLINE
        {
            printf("program %s\n", yytext );
        }
        |
        escape
        {
            // char* a[1];
            // a[0]= YSYMBOL_YYEMPTY;
            // printf("esc %s\n", yytext );

            printf("Escape %s\n", yytext );
        }
        |
        html
        {
            //  $$ = $1;
            // printf("html esc %s\n", yytext );
            // //exit(0);
            // printf("html %s\n", yytext );

            printf("html %s\n", yytext );
        }
        |
        escape html
        {

            // printf("html %s\n", yytext );
            // $$ = $1;
            // printf("html esc %s\n", yytext );

            printf("html %s\n", yytext );
        }
        |
        token
        {
            printf("token %s\n", yytext );
        }
        ;
escape:
        OPEN_BRACE SYMBOL CLOSE_BRACE
        {
            //  $$ = $1;
            // yytext--;
            // yytext--;
            // yytext--;
            // argv[0] = yytext;
            // argv[1] = yytext;
            // argv[2] = yytext;
            // printf("v=%s", yytext);
            // printf("OUT %s, %s", argv[0], argv[1]);

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

token:
        EQUALS_EQUALS
        |
        STRING_LITERAL
        |
        NUMERIC_LITERAL
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
        fprintf(stderr, "Missing filename paramter, help ->\n");
        fprintf(stderr, "lex [OPTION]... [FilE]...\n");
        fprintf(stderr, "Interactive mode...\n");
    }
    yyparse();
}