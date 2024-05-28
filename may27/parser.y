%{
#include <stdio.h>
#include "parser.tab.h"
#include "lex.yy.h"
%}

%token INTEGER VARIABLE NUMBER LITERAL_TEXT OPEN_BRACE CLOSE_BRACE ASCII SYMBOL
%%

page:
    page stmt '\n' { printf("%d\n", $2); }
    |
    ;

stmt:
    ';'
    | expr ';'
    ;


expr:
    INTEGER         { $$ = $1; }
    | expr '+' INTEGER { $$ = $1 + $3; }
    | expr '+' VARIABLE { $$ = $1 + $3; }
    | expr '-' INTEGER { $$ = $1 + $3; }
    | expr '-' VARIABLE { $$ = $1 + $3; }
    | expr '*' INTEGER { $$ = $1 + $3; }
    | expr '*' VARIABLE { $$ = $1 + $3; }
    ;

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


/* main(int argc, char **argv)
{
    yyparse();
}
yyerror(char *s)
{
    fprintf(stderr, "error: %s\n", s);
} */