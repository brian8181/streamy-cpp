%{
    #include "calc.tab.h"
    int yyerror(char *s);
    int yylex();

%}


%%
[0-9]+  {
           yylval.num = atoi(yytext);
           return INTEGER;
        }
[a-z]+  {
            printf("lex ID=%s\n", yytext);
            yylval.sval = yytext;
            return ID;
        }
[-+\n]  return *yytext;
[ \t];  /* skip whitespace */


%%

int yywrap(void)
{
    return 1;
}
