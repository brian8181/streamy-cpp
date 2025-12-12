%{
    #include <stdio.h>
    #include "parser.tab.h"
    #include "lex.yy.h"
    #include "bash_color.h"

    int yylex(void);
    int yyerror(char * s);
%}


%union
{
    int ival;
    char* sval;
};

%token END_OF_FILE;
%type<sval> tag;
%type<sval> config;
%token<ival> NUMBER
%token<sval> STRING
%token<sval> IDENTIFIER
%token<sval> ID
%token<sval> CONST_ID
%token<sval> IF END_IF
%token<sval> FOREACH END_FOREACH
%token<sval> FOREACHELSE END_FOREACHELSE
%token<sval> ELSE END_ELSE
%token<sval> ELSEIF END_ELSEIF
%token<sval> VBAR
%token<sval> LBRACKET
%token<sval> RBRACKET
%token<sval> LBRACE RBRACE LPAREN RPAREN
%token<sval> COLON SEMI_COLON QUOTE SINGLE_QUOTE SLASH BACK_SLASH AT AMPERSAND And Or Not
%token<sval> LESS_THAN LESS_THAN_EQUAL GREATER_THAN GREATER_THAN_EQUAL PLUS MINUS ASTERIK EQUAL DOT PERCENT NOT_EQUAL
%token<sval> CONFIG_LOAD SECTION LDELIM RDELIM VERSION CYCLE COUNTER FILE_NAME
%token CONFIG;
%token ASSIGN ISSET
%token FUNC
%start file;

%%

file:
        tags END_OF_FILE              { printf("bison:file:tags END_OF_FILE\n"); }
        ;
tags:
        tag
        | tags tag
tag:
        ID                       { printf("bison:tag:ID\n"); $$ = $1; }
        | CONST_ID               { printf("bison:tag:CONST_ID\n"); $$ = $1; }
        ;
config:
        CONFIG_LOAD               { printf("bison:config:CONFIG_LOAD\n");  }
        ;

%%

int yyerror(char * s)
{
    fprintf(stderr, "%s\n", s);
    return 0;
};

int main(int argc, char** argv)
{
    printf("parsing ...\n");
    extern FILE *yyin;
    if (argc > 0)
    {
        yyin = fopen(argv[1], "r");
    }
    else
    {
        yyin = stdin;
    };
    yyparse();
};
