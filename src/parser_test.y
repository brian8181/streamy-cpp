%{
    #include <stdio.h>
    #include <string.h>
    #include "parser_test.tab.h"
    #include "lex.yy.h"
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
%type<sval> symbol sym_list terminal terminal_list
%token<sval> NUMBER
%token<sval> DOT INDIRECT_MEMBER
%token<sval> STRING_LITERAL NUMERIC_LITERAL
%token<sval> IDENTIFIER CONST_ID QUALAFIED_ID
%token<sval> IF END_IF ELSE END_ELSE ELSEIF END_ELSEIF
%token<sval> FOREACH END_FOREACH FOREACHELSE END_FOREACHELSE
%token<sval> LBRACKET RBRACKET LBRACE RBRACE LPAREN RPAREN
%token<sval> DOLLAR_SIGN COLON SEMI_COLON QUOTE SINGLE_QUOTE SLASH BACK_SLASH AT VBAR AMPERSAND AND OR NOT
%token<sval> LESS_THAN LESS_THAN_EQUAL GREATER_THAN GREATER_THAN_EQUAL PLUS MINUS ASTERIK EQUAL PERCENT NOT_EQUAL
%token ASSIGN ISSET
%token FUNC
%token END_OF_FILE
%start file;

%%

file:
        blocks END_OF_FILE                  { printf("PARSE:file:blocks END_OF_FILE\n"); exit(0); }
        ;

blocks:
    block
    | blocks block
    ;

block:
    LBRACE terminal_list RBRACE             { printf("PARSE:block:LBRACE terminal_list RBRACE\n"); }
    | LBRACE sym_list RBRACE                { printf("PARSE:block:LBRACE sym_list RBRACE\n"); }

sym_list:
        symbol                                    { printf("PARSE:sym_list:symbol\n"); $$=$1; }
        | sym_list symbol                         { printf("PARSE:sym_list:sym_list symbol\n"); $$=$2; }
        ;
symbol:
        DOLLAR_SIGN IDENTIFIER                  {
                                                    //int len = strlen($2);
                                                    //printf("%s - %s : len=%s", $1, $2, len);
                                                    printf("PARSE:symbol:DOLLAR_SIGN IDENTIFIER\n"); $$=$1;
                                                    //char* id = $2;

                                                    // char* sym[len+2];
                                                    //  strcat(sym, "$");
                                                    //  strcat(sym, id);
                                                    //  $$ = sym;
                                                }
        | symbol DOT IDENTIFIER                   { printf("PARSE:symbol:symbol DOT IDENTIFIER\n"); $$ = $1; }
        | symbol INDIRECT_MEMBER IDENTIFIER       { printf("PARSE:symbol:symbol INDIRECT_MEMBER IDENTIFIER\n"); $$ = $1; }
        | symbol LBRACKET NUMBER RBRACKET         { printf("PARSE:symbol:symbol:symbol LBRACKET NUMBER RBRACKET\n"); $$ = $1; }
        | symbol LPAREN RPAREN                    { printf("PARSE:symbol:symbol:LPAREN RPAREN\n"); $$ = $1; }
        ;

terminal_list:
        terminal                                   { printf("PARSE:terminal_list:terminal\n"); $$=$1; }
        | terminal_list terminal                   { printf("PARSE:terminal_list:terminal_list teminal\n"); $$=$2; }
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
        | STRING_LITERAL                      { printf("PARSER:terminal:STRING_LITERAL: { \"%s\" }\n", buf); $$=$1; }
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
