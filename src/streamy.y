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
%token NEWLINE
%token OPEN_BRACE CLOSE_BRACE
%token VARIABLE

%%

program:
        html NEWLINE
        {
            $$ = $1;
            printf("program %s\n", yytext );
            exit(0);
        }
        |
        html OPEN_BRACE
        {

             $$ = $1;
            printf("program %s\n", yytext );
        }
        |
        OPEN_BRACE VARIABLE CLOSE_BRACE
        {
            $$ = $1;
            $$ = $2;
            $$ = $3;
            printf("program %s\n", yytext );
        }
        ;
html:
        TEXT
        {
            $$ = *yytext;
            printf("PT %s\n", yytext);
        }
        |
        html TEXT
        {
            $$ = *yytext;
            printf("PHT %s\n", yytext);
        }
        |
        OPEN_BRACE
        {
            $$ = *yytext;
            printf("PHT %s\n", yytext);
            //unput(yytext);
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
    if(argc < 2)
    {
        fprintf(stderr, "Error: missing paramter\n");
        fprintf(stderr, "lex [OPTION]... [FilE]...\n");
    }

    // commnad line
    yyparse();
    return 0;
}
/*
int maint_()
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
    filename = argv[1];
    yyparse();

}  */