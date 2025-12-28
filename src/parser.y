%{
    #include <stdio.h>
    #include <string.h>
    #include "parser.tab.h"
    #include "lex_parse.yy.h"
    #include "bash_color.h"

    int yylex(void);
    int yyerror(char * s);

    /* string literal buffer */
    char buf[100];
    char *s;
%}

%union
{
    int ival;
    char* sval;
};

%token END_OF_FILE
%type<sval> tag tags symbol
%token<ival> NUMBER
%token<sval> DOT INDIRECT_MEMBER
%token<sval> STRING_LITERAL NUMERIC_LITERAL
%token<sval> IDENTIFIER CONST_ID QUALAFIED_ID
%token<sval> IF END_IF ELSE END_ELSE ELSEIF END_ELSEIF
%token<sval> FOREACH END_FOREACH FOREACHELSE END_FOREACHELSE
%token<sval> LBRACKET RBRACKET LBRACE RBRACE LPAREN RPAREN
%token<sval> DOLLAR_SIGN COLON SEMI_COLON QUOTE SINGLE_QUOTE SLASH BACK_SLASH AT VBAR AMPERSAND AND OR NOT
%token<sval> LESS_THAN LESS_THAN_EQUAL GREATER_THAN GREATER_THAN_EQUAL PLUS MINUS ASTERIK EQUAL PERCENT NOT_EQUAL
%token<sval> CONFIG_LOAD SECTION LDELIM RDELIM VERSION CYCLE COUNTER FILE_NAME FILE_ATTRIB
%token CONFIG;
%token ASSIGN ISSET
%token FUNC
%start file;

%%

file:
        END_OF_FILE
        | sym_list END_OF_FILE                      { printf("bison:file:tags END_OF_FILE\n"); }
        | tags END_OF_FILE
        ;
tags:
        tag                                   {  printf("bison:tags:tag\n"); printf("TAGS: { \"%s\" }\n", $1); $$=$1; }
        | tags tag                            {
                                                  printf("bison:tags:tags tag\n");
                                                  // char* tags = $1;
                                                  // char* tag = $2;
                                                  // strcat(tags, tag);
                                                  // $$ = $1;
                                              }
                                              ;
sym_list:
    symbol
    | sym_list symbol
    ;
symbol:
    DOLLAR_SIGN IDENTIFIER               {
                                            printf("bison:symbol:DOLLAR_SIGN IDENTIFIER\n");
                                            // char* id = $2;
                                            // int len = strlen(id);
                                            // char* symbol[len+2];
                                            // strcat(symbol, "$");
                                            // strcat(symbol, id);
                                            // $$ = symbol;
                                            $$ = $2;
                                         }
    | symbol DOT IDENTIFIER              { printf("bison:symbol:symbol DOT IDENTIFIER\n"); $$ = $1; }
    | symbol INDIRECT_MEMBER IDENTIFIER  { printf("bison:symbol:symbol INDIRECT_MEMBER IDENTIFIER\n"); $$ = $1; }
    | symbol LBRACKET NUMBER RBRACKET    { printf("bison:symbol:symbol:symbol LBRACKET NUMBER RBRACKET\n"); $$ = $1; }
    | symbol LPAREN RPAREN               { printf("bison:symbol:symbol:LPAREN RPAREN\n"); $$ = $1; }
    ;

tag:
        CONFIG_LOAD                           { printf("bison:tag:CONFIG_LOAD\n"); $$=$1; }
        | EQUAL                               { printf("bison:tag:EQUAL\n"); $$=$1; }
        | FILE_ATTRIB                         { printf("bison:tag:FILE_ATTRIB\n"); $$=$1; }
        | STRING_LITERAL                      { printf("bison:tag:STRING_LITERAL: { \"%s\" }\n", buf); $$=$1; }
        ;

terminal:
    IF
    | END_IF
    | ELSE
    | FOREACH
    | FOREACHELSE
    | ELSEIF
    | SEMI_COLON
    | COLON
    | SLASH
    | BACK_SLASH
    | VBAR
    | AT
    | AMPERSAND
    | AND
    | OR
    | NOT
    | LESS_THAN
    | LESS_THAN_EQUAL
    | GREATER_THAN
    | GREATER_THAN_EQUAL
    | PLUS
    | MINUS
    | ASTERIK
    | PERCENT
    | NOT_EQUAL
    | NUMERIC_LITERAL
    | NUMBER
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
