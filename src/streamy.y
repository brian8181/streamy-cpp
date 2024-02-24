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
extern void* pyyval;

%}


%token NUMBER
%left PLUS
%left MINUS
%token NEWLINE

%%
program:
        program statement '\n' { printf("program %d\n", $$); }
        |
        ;
statement:
        expr    {
                    $$ = $1;
                    printf("STMT %d\n", $$);
                }
        |
        ;
expr:
        NUMBER
            {
                $$ = *((int*)pyyval);
                printf("NUMBER %d\n", $$);
            }
        |   expr PLUS expr
            {
                $$ = $1 + $3;
                printf("PLUS %d\n", $$);
            }
        |   expr MINUS expr
            {
                $$ = $1 - $3;
                printf("MINUS %d\n", $$);
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