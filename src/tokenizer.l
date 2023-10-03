
%{
/* need this for the call to atof() below */
#include <math.h>
%}

DIGIT            [0-9]
TEXT             [a-zA-Z0-9 <>=#$_'"\\/\t\n]
OPEN_CURLY       "{"
CLOSE_CURLY      "}"
OPEN_PAREN       "("
CLOSE_PAREN      ")"

%%

{DIGIT}+                                            printf( "INTEGER: %s (%d)\n", yytext, atoi( yytext ) ); 
{DIGIT}+"."{DIGIT}*                                 printf( "FLOAT: %s (%g)\n", yytext, atof( yytext ) );
{TEXT}*                                             printf( "\nText/Html %s\n\n", yytext ); 
{OPEN_CURLY}                                        printf( "OPEN_CURLY: %s\n", yytext );
{CLOSE_CURLY}                                       printf( "CLOSE_CURLY: %s\n", yytext );
{OPEN_PAREN}                                        printf( "OPEN_PAREN: %s\n", yytext );
{CLOSE_PAREN}                                       printf( "CLOSE_PAREN: %s\n", yytext );
    
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