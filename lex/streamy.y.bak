
%token INTEGER VARIABLE LITERAL
%left '+' '-'
%left '*' '/'
%right '$'

%{


#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <stdlib.h>
#include "y.tab.h"

int yyerror(char *);
int yylex(void);
int sym[26];

%}

%%

program: program statement '\n'
    |
;
statement: expr
expr:
INTEGER
    |  LITERAL
    | expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | '(' expr ')'
    ;


%%

#include <stdio.h>
#include "y.tab.h"
int yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
    return 0;
}

int main(void)
{
    yyparse();
    return 0;
}