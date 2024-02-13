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
    |
    ;
    x: INTEGER;
    y: TEXT;
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