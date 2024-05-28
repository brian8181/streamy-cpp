%{

#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"

    extern char *yytext;
    extern int yylineno;
    int fileno(FILE *);
%}

ASCII [^{}]*
OPEN_BRACE "{"
CLOSE_BRACE "}"
SYMBOL "$"[A-Za-z]+[A-Za-z0-9_]*

%x streaming
%x escape

%%

{ASCII}                 {
                            BEGIN(escape);
                            printf( "Start ASCII: %s\n", yytext );
                            //return ASCII;
                        }
<streaming>{ASCII}      {
                            BEGIN(escape);
                            printf( "ASCII: %s\n", yytext );
                            //return ASCII;
                        }
<escape>{OPEN_BRACE}    {
                            printf( "found a opening brace...\n" );
                            //return OPEN_BRACE;
                        }
<escape>{CLOSE_BRACE}   {
                            BEGIN(streaming);
                            printf( "found a closing brace...\n" );
                            //return CLOSE_BRACE;
                        }
<escape>{SYMBOL}        {
                            printf( "symbol: %s\n", yytext );
                            //return SYMBOL;
                        }
<<EOF>>                 {
                            printf( "EOF\n");
                            yyterminate();
                        }

%%

int yywrap(void)
{
    return 1;
}

/* int main()
{
    while (yylex() != 0) ;
    return 0;
} */


int main(int argc, char** argv)
{
    if ( argc > 1 )
    {
        yyin = fopen( argv[1], "r" );
    }
    else
    {
        yyin = stdin;
    }
    yylex();
}