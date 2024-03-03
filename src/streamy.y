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


%token TEXT
%token NEWLINE
%token OPEN_BRACE CLOSE_BRACE NAME TAG
/* 0%token <d> NUMBERn */
/* %token <symp> NAME */

%%

program:
        html NEWLINE
        {
            printf("program %s\n", yytext );
            exit(0);
        }
        |
        NAME
        {
            printf("NAME %s\n", yytext );
        }
        |
        tag
        {
            printf("TAG %s\n", yytext );
        }
        |
        html tag
        {
            printf("program %s\n", yytext );
        }
        ;
tag:
        OPEN_BRACE NAME
        {
            printf("name%s\n", yytext );
        }
html:
        TEXT
        {
            printf("PT %s\n", yytext);
        }
        |
        html TEXT
        {
            printf("PHT %s\n", yytext);
        }
        |
        OPEN_BRACE
        {
            printf("PHT %s\n", yytext);
            //unput(yytext);
        }
        |
        CLOSE_BRACE
        {
            printf("PHT %s\n", yytext);
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

/* int main(int argc , char* argv[])
{
    if(argc < 2)
    {
        fprintf(stderr, "Missing filename paramter\n interactive mode");
        fprintf(stderr, "lex [OPTION]... [FilE]...\n");
        fprintf(stderr, "Interactive mode...\n");
    }

    // commnad line
    yyparse();
    return 0;
} */

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