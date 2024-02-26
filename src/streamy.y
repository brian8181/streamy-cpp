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
void yyerror(char *);
int yylex(void);
extern void* pyyval;

%}

%token TEXT
%token OPEN_BRACE
%token CLOSE_BRACE
%token NEWLINE
%token CHAR
%token SPACE

%%
program:

        NEWLINE CHAR
        |
        CHAR
        {
            $$ = $1;
            printf("%s", $$);
        }

        ;

%%

#include <stdio.h>

//extern void* pyyval;
extern char* yytext;
extern int column;


int fileno(char *)
{
    return 0;
}

void yyerror(char *s)
{
    fprintf(stderr, "line %d: %s\n", yylineno, s);
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