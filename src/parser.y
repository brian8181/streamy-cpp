%{
    #include <stdio.h>
    #include <string.h>
    #include "parser.tab.h"
    #include "lex_parse.yy.h"
    #include "bash_color.h"

    int yylex(void);
    int yyerror(char * s);

    char buf[100];
    char *s;

%}


%union
{
    int ival;
    char* sval;
};

%token END_OF_FILE
%type<sval> tag tags
%token<ival> NUMBER
%token<sval> STRING_LITERAL NUMERIC_LITERAL
%token<sval> IDENTIFIER ID CONST_ID QUALAFIED_ID
%token<sval> IF END_IF ELSE END_ELSE ELSEIF END_ELSEIF
%token<sval> FOREACH END_FOREACH FOREACHELSE END_FOREACHELSE
%token<sval> LBRACKET RBRACKET LBRACE RBRACE LPAREN RPAREN
%token<sval> COLON SEMI_COLON QUOTE SINGLE_QUOTE SLASH BACK_SLASH AT VBAR AMPERSAND And Or Not
%token<sval> LESS_THAN LESS_THAN_EQUAL GREATER_THAN GREATER_THAN_EQUAL PLUS MINUS ASTERIK EQUAL DOT PERCENT NOT_EQUAL
%token<sval> CONFIG_LOAD SECTION LDELIM RDELIM VERSION CYCLE COUNTER FILE_NAME FILE_ATTRIB
%token CONFIG;
%token ASSIGN ISSET
%token FUNC
%start file;

%%

file:
        tags END_OF_FILE        { printf("bison:file:tags END_OF_FILE\n"); }
        ;
tags:
        tag                     {  printf("bison:tags:tag\n"); printf("TAGS: { %s }\n", $1); $$=$1; }
        | tags tag              {
                                    printf("bison:tags:tags tag\n");
                                    // char* tags = $1;
                                    // char* tag = $2;
                                    // strcat(tags, tag);
                                    // $$ = $1;
                                }
        ;

tag:
        ID                      { printf("bison:tag:ID\n"); $$ = $1; }
        | CONST_ID              { printf("bison:tag:CONST_ID\n"); $$ = $1; }
        | CONFIG_LOAD           { printf("bison:tag:CONFIG_LOAD\n"); $$=$1; }
        | EQUAL                 { printf("bison:tag:EQUAL\n"); $$=$1; }
        | FILE_ATTRIB           { printf("bison:tag:FILE_ATTRIB\n"); $$=$1; }
        | STRING_LITERAL        { printf("bison:tag:STRING_LITERAL=%s\n", buf); $$=$1; }
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
