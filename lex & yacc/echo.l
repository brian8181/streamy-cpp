%%
.
\n
/* match everything except newline */
ECHO;
/* match newline */
ECHO;
%%

#define ECHO fwrite(yytext, yyleng, 1, yyout)

int yywrap(void)
{
    return 1;
}

int main(void) {
    yylex();
    return 0;
}