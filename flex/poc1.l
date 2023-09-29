/* scanner for a toy Pascal-like language */

%{
/* need this for the call to atof() below */
#include <math.h>
%}

DIGIT    [0-9]
ID       [a-z][a-z0-9]*

%x expect

%%

expect-floats        yybegin(expect);

<expect>[0-9]+.[0-9]+      {
            printf( "found a float, = %f\n",
                    atof( yytext ) );
                }
<expect>\n  {
            /* that's the end of the line, so
             * we need another "expect-number"
             * before we'll recognize any more
             * numbers
             */
            yybegin(INITIAL);
                }
{DIGIT}+    { printf( "An integer: %s (%d)\n", yytext, atoi( yytext ) ); }
{DIGIT}+"."{DIGIT}*     { printf( "A float: %s (%g)\n", yytext, atof( yytext ) ); }
if|then|begin|end|else|foreach    { printf( "A keyword: %s\n", yytext ); }
{ID}    printf( "An identifier: %s\n", yytext );
"+"|"-"|"
"{"[^{}\n]*"}"     printf( "An tag: %s\n", yytext );
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