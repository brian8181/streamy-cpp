%{
    #include <stdio.h>
    #include "lexer.h"

    int sym[26];
    int yyparse(void);
    int yylex(void);
%}

%union
{
    int num;
    char* str;
}

%token<num> INTEGER
token<str> SEMI_COLON NEWLINE;
%type<num> expr statement
%left<str> PLUS MINUS
%left<str> MULT DIV

%%

program:
            | program statement NEWLINE { printf("%d\n", $2cd); }
            ;
statement:
            expr SEMI_COLON { printf("%d\n", $1); $$=$1; }
            ;
expr:
            INTEGER          { printf("%d\n", $1); $$=$1;  }
            | expr PLUS expr { printf("%d %s %d\n", $1, $2, $3); $$ = $1 + $3; };
            | expr MINUS expr { $$ = $1 - $3; };
            | expr MULT expr { $$ = $1 * $3; };
            | expr DIV expr { $$ = $1 / $3; };
            | '(' expr ')' { $$ = $2; }

%%
