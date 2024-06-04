%{

#include <stdio.h>
#include "parser.tab.h"
#include "lex.yy.h"

%}

/*
%union
{
    int ival;
    std::string* sval;
}
%token <ival> NUMBER;
%token <sval> STRING; */

%token INTEGER SYMBOL PLAIN_TEXT OPEN_BRACE CLOSE_BRACE FUNCTION BAR
%type escape
%type expression
%start document

%%

document:
        document expression '\n' { printf("%d\n", $2); }
        |
        ;

escape:
        expression CLOSE_BRACE { $$ = $2; }
        ;

expression:
        OPEN_BRACE expression CLOSE_BRACE
        SYMBOL
        |
        SYMBOL BAR FUNCTION
        ;

stream:
       PLAIN_TEXT;
       |
       stream PLAIN_TEXT

%%

int yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
    return 0;
}

int main(int argc, char* argv[])
{
    int tok;
    FILE* f = fopen(argv[1], "r");
    if(!f)
    {
        perror(argv[1]);
        return -1;
    }

    while((tok = yylex()))
    {
        printf("%d", tok);
        if(tok == NUMBER)
            printf(" = %d\n", yylval);
        else
            printf("\n");
    }
    yyparse();
    return 0;
}
