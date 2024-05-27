%{
    extern char *yytext;
    extern int yylineno;
    int fileno(FILE *);
%}

ASCII [^{}]*
OPEN_BRACE "{"
CLOSE_BRACE "}"
SYMBOL $[A-Za-z]+[A-Za-z0-9_]*

%x streaming
%x escape

%%

{ASCII}                 {
                            BEGIN(escape);
                            printf( "Start ASCII: %s\n", yytext );
                        }
<streaming>{ASCII}      {
                            BEGIN(escape);
                            printf( "ASCII: %s\n", yytext );
                        }

<escape>{OPEN_BRACE}    {

                            printf( "found a opening brace...\n" );
                        }

<escape>{CLOSE_BRACE}   {
                            BEGIN(streaming);
                            printf( "found a closing brace...\n" );
                        }

<escape>{SYMBOL}        {
                            printf( "symbol: %s\n", yytext );
                        }

<<EOF>>                 {
                            printf( "EOF: %s\n", yytext );
                        }


%%

int yywrap(void)
{
    return 1;
}

int main(int argc, char** argv)
{
    /* skip over program name */
    ++argv, --argc;

    if ( argc > 0 )
    {
        yyin = fopen( argv[1], "r" );
    }
    else
    {
        yyin = stdin;
    }
    yylex();
}