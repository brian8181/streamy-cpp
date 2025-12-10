%{

#include <stdio.h>
#include "parser_esc.tab.h"
#include "lex_esc.yy.h"

int yylex(void);
int yyerror(char* s);

%}


%union
{
    int ival;
    char* sval;
};

%token <ival> NUMBER;
%token <sval> STRING;
%token<sval> IDENTIFIER
%token<sval> ID
%token<sval> CONST_ID
%token<sval> IF
%token<sval> FOREACH
%token<sval> FOREACHELSE
%token<sval> ELSE
%token<sval> VBAR
%token<sval> LBRACKET
%token<sval> RBRACKET
%token<sval> LBRACE RBRACE LPAREN RPAREN
%token<sval> COLON SEMICOLON QUOTE SINGLE_QUOTE SLASH BACK_SLASH AT AMPERSAND AND OR
%token<sval> LESS_THAN GRATER_THAN PLUS MINUS ASTERIK EQUAL DOT PERCENT
%token<sval> config_load config section LDELIM RDELIM version file cycle counter
%token assign isset
%token INTEGER SYMBOL PLAIN_TEXT OPEN_BRACE CLOSE_BRACE FUNCTION BAR;

%type<sval> ESCAPE
%type EXPRESSION;

%start document;

%%

document:
        document '\n' { ; }
        |
        number
        ;
identifier:
    ID     { printf("bison:ID"); };
    | FUNCTION

number:
    INTEGER { printf("bison:INTEGER"); };
    |
    NUMBER { printf("bison:NUMBER"); };

%%

int yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
    return 0;
};

int main(int argc, char** argv)
{
    printf("parsing ...\n");
    extern FILE *yyin;
    if ( argc > 0 )
    {
        yyin = fopen( argv[1], "r" );
    }
    else
    {
        yyin = stdin;
    };
    yyparse();
};
