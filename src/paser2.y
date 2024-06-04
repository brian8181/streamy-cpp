/*
 * integer calculator
 */

%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
%}

%pure_parser

%token OPEN_BRACE CLOSE_BRACE ASCII SYMBOL PLUS MINUS MULTIPLY INTEGER
%type escape
%type expr
%left '+' '-'
%left '*' '/'

%%

document:
        ASCII
        |
        ;

escape:
        expr
        |
        OPEN_BRACE expr CLOSE_BRACE { $$ = $2; }
        ;

expr:
        INTEGER         { $$ = $1; }
        | expr '+' INTEGER { $$ = $1 + $3; }
        | expr '+' SYMBOL { $$ = $1 + $3; }
        | expr '-' INTEGER { $$ = $1 + $3; }
        | expr '-' SYMBOL { $$ = $1 + $3; }
        | expr '*' INTEGER { $$ = $1 + $3; }
        | expr '*' SYMBOL { $$ = $1 + $3; }
        ;

TOKINIZED:
        ASCII
        |
        ESC_TOKEN
        |
        TOKINIZED ESC_TOKEN
        ;

ESC_TOKEN:
        SYMBOL
        |
        PLUS
        |
        MINUS
        |
        MULTIPLY
        ;
%%

#if YYPURE
#define YYLEXARGS YYSTYPE *yylvalp
#define YYLVAL (*yylvalp)
#endif /* YYPURE */

#if !YYPURE
#define YYLEXARGS
#define YYLVAL yylval
#endif

int yylex(YYLEXARGS)
{
    int c;
    char *p;
    char buf[100];

 again:
    c = getc(stdin);
    if (c == EOF)
        return 0;
    else if (c == ' ' || c == '\t')
        goto again;
    else if (isdigit(c)) {
        for (p = buf; isdigit(c); ) {
            *p++ = c;
            c = getc(stdin);
        }
        *p = '\0';
        ungetc(c, stdin);
        YYLVAL = atoi(buf);
        return NUMBER;
    } else
        return c;
}

int yyerror(s)
{
    char *s;
    fprintf(stderr, "%s\n", s);
}

int main()
{
#ifdef YYDEBUG
    yydebug = 1;
#endif

    return yyparse();
}
