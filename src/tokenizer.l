%{

%}

ASCII [^}{\n]*

%%

{ASCII}            printf( "ASCII: %s\n", yytext );
"{"[a-z]*"}"           printf( "TEXT: %s\n", yytext );
"{"[0-9]*"}"           printf( "NUMBER: %s\n", yytext );

%%

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
