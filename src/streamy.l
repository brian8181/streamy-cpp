%{
    #include <stdio.h>
    #include "streamy.tab.h"
    int yylex(void);
    void yyerror(char *);
    int TEXT_LITERAL;
%}

%%

[0-9]+  {
                yylval = atoi(yytext);
                return INTEGER;
        }
[-+\n]      return *yytext;
[ \t]; /* skip whitespace */
.   {
        printf("Text literal: %s", yytext);
        return TEXT_LITERAL;
    }

%%

int yywrap(void) {
    return 1;
}

/* void yyerror(char* s)
{

} */

/* int main(int argc, int* argv[])
{
    yyin = fopen(argv[1], "r");
    yylex();
    fclose(yyin);
} */

/* int main(int argc, char* argv[])
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
    do_parse();
    return 0;
} */