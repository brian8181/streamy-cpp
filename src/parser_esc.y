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

%token <ival> NUMBER
%token <sval> STRING
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
%token<sval> COLON SEMI_COLON QUOTE SINGLE_QUOTE SLASH BACK_SLASH AT AMPERSAND AND OR NOT
%token<sval> LESS_THAN LESS_THAN_EQUAL GREATER_THAN GREATER_THAN_EQUAL PLUS MINUS ASTERIK EQUAL DOT PERCENT NOT_EQUAL
%token<sval> config_load config section LDELIM RDELIM version cycle counter
%token assign isset
%token INTEGER SYMBOL PLAIN_TEXT OPEN_BRACE CLOSE_BRACE FUNCTION BAR CONFIG

%start file;

%%

file:
        file '\n' { }
        | number { printf("bison:file:number");  }
        | identifier { printf("bison:file:identifier");  }
        | terminal { printf("bison:file:terminal");  }
        ;
identifier:
    ID     { printf("bison:ID"); }
    | FUNCTION
    ;

number:
    INTEGER { printf("bison:INTEGER"); }
    | NUMBER { printf("bison:NUMBER"); }
    ;

terminal:
    CONST_ID    {printf("bison:CONST_ID"); }
    | PLUS      {printf("bison:PLUS"); }
    | MINUS     {printf("bison:MINUS"); }
    | ASTERIK   {printf("bison:ASTERIK"); }
    | EQUAL     {printf("bison:EQUAL"); }
    | NOT_EQUAL {printf("bison:NOT_EQUAL"); }
    | DOT       {printf("bison:DOT"); }
    | PERCENT   {printf("bison:PERCENT"); }
    | COLON     {printf("bison:COLON"); }
    | LBRACKET  {printf("bison:LBRACKET");}
    | RBRACKET  {printf("bison:RBRACKET");}
    | LBRACE    {printf("bison:LBRACE"); }
    | RBRACE    {printf("bison:RBRACE"); }
    | VBAR    {printf("bison:VBAR"); }
    | SLASH    {printf("bison:SLASH"); }
    | BACK_SLASH    {printf("bison:BACK_SLASH"); }
    | QUOTE    {printf("bison:QUOTE"); }
    | SINGLE_QUOTE    {printf("bison:SINGLE_QUOTE"); }
    | IF    {printf("bison:IF"); }
    | ELSE    {printf("bison:ELSE"); }
    | FOREACH    {printf("bison:FOREACH"); }
    | LESS_THAN    {printf("bison:LESS_THAN"); }
    | LESS_THAN_EQUAL    {printf("bison:LESS_THAN_EQUAL"); }
    | GREATER_THAN    {printf("bison:GREATER_THAN"); }
    | GREATER_THAN_EQUAL    {printf("bison:GREATER_THAN_EQUAL"); }
    | AND    {printf("bison:AND"); }
    | OR    {printf("bison:OR"); }
    | CONFIG {printf("bison:CONFIG"); }
    ;


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
