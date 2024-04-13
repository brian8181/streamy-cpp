%{

#include <stdio.h>
#include "stdlib.h"
//#include "lexer.yy.h"
#define YYSTYPE int


int fileno(char *);
void yyerror(char *);
// int yylex(void);`
// char* argv[255];
// char* str;
//int yylval;

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

%union
{
    int num;
}
%type<num> expr
%token<num> NUMBER

%%

program:
        expr  { printf("PROGRAM\n"); }
        |
        expr NEWLINE { printf("END\n"); }
        ;
expr:
        NUMBER PLUS NUMBER
        {
            printf("NUMBER PLUS NUMBER\n");
        }
        |
        NUMBER { printf("NUMBER\n"); }
        |
        PLUS  { printf("PLUS\n"); }
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