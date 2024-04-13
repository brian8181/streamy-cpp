%{
    #include "calc.tab.h"
    int yyerror(char *s);
    char *yytext;
    int yylex();
%}

%%

[a-z]       {
                yylval = *yytext - 'a';
                return VARIABLE;
            }
[0-9]+      {
                yylval = atoi(yytext);
                return INTEGER;
            }
[-+()=/*\n] { return *yytext; }
[ \t]       ;
.           yyerror("invalid character");

%%

int yywrap(void)
{
    return 1;
}