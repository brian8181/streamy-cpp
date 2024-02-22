/*
   File Name:  streamy.y
   Build Date: Wed Feb 14 12:02:37 AM CST 2024
   Version:    0.0.1
*/
%{
#include <stdio.h>
#include "streamy.tab.h"
#include "streamy.yy.h"
//#define YYDEBUG 1
%}

%token INTEGER
%token TEXT
%token VARIABLE NUMBER LITERAL_TEXT
%%

start:  x
        |
        y
        ;
x: INTEGER { printf("INT"); }
y: TEXT    { printf("TEXT"); }

%%

int fileno;

int parse()
{

}

int yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
    return 0;
}

/* int main(void)
{
    yyparse();
    return 0;
} */