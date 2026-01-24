%%

a |
ab |
abc |
abcd |
ECHO; REJECT;
.|\n /* eat up any unmatched character */

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
        yyin = fopen( argv[0], "r" );
    }
    else
    {
        yyin = stdin;
    }
    yylex();
}
