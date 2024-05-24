%{

%}


%%

"{"[a-z]*"} "                 printf( "TEXT: %s\n", yytext );
"{"[0-9]*"}"                     printf( "NUMBER: %s\n", yytext );
^[^}{\n]*                  printf( "NON_ESCAPED: %s\n", yytext );
.                      printf( "ANYTHING ELSE: %s\n", yytext );

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
