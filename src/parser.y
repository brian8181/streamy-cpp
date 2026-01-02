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


%type block
%type<sval> symbol symbols terminal terminal_list
%token<sval> SYMBOL NUMBER
%token<sval> DOT INDIRECT_MEMBER
%token<sval> STRING_LITERAL NUMERIC_LITERAL
%token<sval> IDENTIFIER CONST_ID QUALAFIED_ID
%token<sval> IF END_IF ELSE END_ELSE ELSEIF END_ELSEIF
%token<sval> FOREACH END_FOREACH FOREACHELSE END_FOREACHELSE
%token<sval> LBRACKET RBRACKET LBRACE RBRACE LPAREN RPAREN
%token<sval> COLON SEMI_COLON QUOTE SINGLE_QUOTE SLASH BACK_SLASH AT VBAR AMPERSAND AND OR NOT
%token<sval> LESS_THAN LESS_THAN_EQUAL GREATER_THAN GREATER_THAN_EQUAL PLUS MINUS ASTERIK EQUAL PERCENT NOT_EQUAL
%token<sval> CONFIG_LOAD SECTION LDELIM RDELIM VERSION CYCLE COUNTER FILE_NAME FILE_ATTRIB
%token CONFIG;
%token ASSIGN ISSET
%token FUNC
%token END_OF_FILE
%start file;

%%

file:
        blocks END_OF_FILE                          { printf("PARSER:file:blocks END_OF_FILE\n"); exit(0); }
               ;

blocks:
    block                                           { printf("PARSER:blocks:block\n"); }
    | blocks block                                  { printf("PARSER:blocks:blocks block\n"); }
    ;

block:
    LBRACE terminal_list RBRACE                     { printf("PARSER:block:LBRACE terminal_list RBRACE\n"); }
    | LBRACE symbols RBRACE                         { printf("PARSER:block:LBRACE symbols RBRACE\n"); }

symbols:
        symbol                                      { printf("PARSER:symbols:symbol\n"); $$=$1; }
         | symbols symbol                           { printf("PARSER:symbols:symbols symbol\n"); $$=$2; }
         ;
symbol:
        SYMBOL                                      { printf("PARSER:SYMBOL=%s\n", $1); $$ = $1; }
        | CONST_ID                                  { printf("PARSER:CONST_ID=%s\n", $1); $$=$1; }
        | symbol DOT IDENTIFIER                     { printf("PARSER:symbol:symbol DOT IDENTIFIER\n"); $$ = $1; }
        | symbol INDIRECT_MEMBER IDENTIFIER         { printf("PARSER:symbol:symbol INDIRECT_MEMBER IDENTIFIER\n"); $$ = $1; }
        | symbol LBRACKET NUMBER RBRACKET           { printf("PARSER:symbol:symbol:symbol LBRACKET NUMBER RBRACKET\n"); $$ = $1; }
        | symbol LPAREN RPAREN                      { printf("PARSER:symbol:symbol:LPAREN RPAREN\n"); $$ = $1; }
        ;

terminal_list:
        terminal                                    { printf("PARSER:terminal_list:terminal=%s\n", $1); $$=$1; }
        | terminal_list terminal                    { printf("PARSER:terminal_list:terminal_list teminal%s, %s\n", $1, $2); $$=$2; }
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
        | NUMERIC_LITERAL                           { printf("PARSER:terminal:NUMERIC_LITERAL=%s\n", $1); $$=$1; }
        | STRING_LITERAL                            { printf("PARSER:terminal:STRING_LITERAL: { \"%s\" }\n", buf); $$=buf; }
        | NUMBER                                    { printf("PARSER:terminal:NUMBER=%s\n", $1); $$=$1; }
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
