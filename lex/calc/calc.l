%{
    #include "calc.tab.h"
    int yyerror(char *s);
    char *yytext;
    int yylex();

%}


%%
[0-9]+  {
           yylval.num = atoi(yytext);
           return INTEGER;
        }
[-+\n]  return *yytext;
[ \t];  /* skip whitespace */
.       yyerror("invalid character");

%%

int yywrap(void)
{
    return 1;
}