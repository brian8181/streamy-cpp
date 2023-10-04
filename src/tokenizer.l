
%{
/* need this for the call to atof() below */
#include <math.h>
%}

OPEN_CURLY       "{"
CLOSE_CURLY      "}"
OPEN_PAREN       "("
CLOSE_PAREN      ")"
VARIABLE         "$"[a-zA-Z_]+[a-zA-Z0-9_]*

%%

{OPEN_CURLY}                                        printf( "OPEN_CURLY: %s\n", yytext );
{CLOSE_CURLY}                                       printf( "CLOSE_CURLY: %s\n", yytext );
{OPEN_PAREN}                                        printf( "OPEN_PAREN: %s\n", yytext );
{CLOSE_PAREN}                                       printf( "CLOSE_PAREN: %s\n", yytext );
{VARIABLE}                                          printf( "VARIABLE: %s\n", yytext );
[ \t\n]                                             { printf( "WHITESPACE: %s\n", yytext ); };
.                                                   printf( "Unrecognized character: %s\n", yytext );

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