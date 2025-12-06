%x ESCAPED
%%

[{]             { printf("\nESCAPED\n"); BEGIN ESCAPED; }
<ESCAPED>[^}]   { ECHO; }
<ESCAPED>[}]    { printf("\nUNESCAPED\n"); BEGIN INITIAL; }

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
