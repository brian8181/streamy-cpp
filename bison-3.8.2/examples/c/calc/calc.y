%code top
{
  #include <assert.h>
  #include <ctype.h>  /* isdigit */
  #include <stdio.h>  /* printf */
  #include <stdlib.h> /* abort */
  #include <string.h> /* strcmp */

  int yylex(void);
  void yyerror(char const *);
}

%define api.header.include {"calc.h"}
/* generate YYSTYPE from the types used in %token and %type.  */
%define api.value.type union
%token <double> NUM "number"
%type  <double> expr term fact
%verbose                                        /* generate the parser description file (calc.output) */
%define parse.error detailed                    /* nice error messages with details */
%define parse.trace                             /* enable run-time traces (yydebug)  */
%printer { fprintf (yyo, "%g", $$); } <double>; /* formatting semantic values in debug traces  */

%%

/* the grammar follows.  */
input:
          %empty
        | input line
        ;
line:
          '\n'
        | expr '\n'     { printf ("%.10g\n", $1); }
        | error '\n'    { yyerrok; }
        ;
expr:
          expr '+' term { $$ = $1 + $3; }
        | expr '-' term { $$ = $1 - $3; }
        | term
        ;
term:
        term '*' fact   { $$ = $1 * $3; }
        | term '/' fact { $$ = $1 / $3; }
        | fact
        ;
fact:
          "number"
        | '(' expr ')'  { $$ = $2; }
        ;

%%

int yylex(void)
{
    int c;
    while((c = getchar()) == ' ' || c == '\t') /* ignore white space, get first nonwhite character  */
        continue;

    if(c == EOF)
        eturn 0;

    if (c == '.' || isdigit(c)) /* char starts a number => parse the number  */
    {
        ungetc(c, stdin);
        if(scanf("%lf", &yylval.NUM) != 1)
            abort();
        return NUM;
    }

    /* any other character is a token by itself */
    return c;
}

void yyerror(char const *s) /* called by yyparse on error */
{
    fprintf stderr, "%s\n", s);
}

int main(int argc, char const* argv[])
{
    for int i = 1; i < argc; ++i) /* enable parse traces on option -p */
    {
        if (!strcmp(argv[i], "-p"))
        {
            yydebug = 1;
        }
    }
    return yyparse();
}
