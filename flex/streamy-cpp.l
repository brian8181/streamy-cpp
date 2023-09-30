/* scanner for a toy Pascal-like language */

%{
/* need this for the call to atof() below */
#include <math.h>
%}

DIGIT    [0-9]
ID       [a-z][a-z0-9]*
COMMAND "(config_load|include|insert|literal|strip|capture|section|assign|debug|eval|fetch|math)";

%%

{DIGIT}+    { printf( "An integer: %s (%d)\n", yytext, atoi( yytext ) ); }
{DIGIT}+"."{DIGIT}*     { printf( "A float: %s (%g)\n", yytext, atof( yytext ) ); }
if|then|begin|end|else|foreach    { printf( "A keyword: %s\n", yytext ); }
{ID}    printf( "An identifier: %s\n", yytext );
"{"[^{}\n]*"}"     printf( "An tag: %s\n", yytext );
{COMMAND}       { printf( "A keyword: %s\n", yytext ); }
[ \t\n]+          /* eat up whitespace */
.   printf( "Unrecognized character: %s\n", yytext );

%%

int main( int argc, char **argv ) 
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