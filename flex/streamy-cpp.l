/* scanner for a toy Pascal-like language */

%{
/* need this for the call to atof() below */
#include <math.h>
%}

DIGIT    [0-9]
ID       [a-z][a-z0-9]*
COMMAND "(config_load|include|insert|literal|strip|capture|section|assign|debug|eval|fetch|math)"
COMMENT "\\{\\*a*\\*\\}"
CONFIG  "\{config_load "[ \t]*"file='".*"'\}"
INCLUDE  "\{include "[ \t]*"file='".*"'\}"
GLOBAL  "\{\#".*"\#\}"
FILE_NAME [a-zA-Z]+[a-zA-Z0-9.]*[a-zA-Z0-9]+
TEXT [a-zA-Z0-9 =#$_'"<>\\/\t\n]+
IF "\{if $"{ID}"\}"
END_IF "\{/if\}"
ELSE else

%%

{DIGIT}+    { printf( "An integer: %s (%d)\n", yytext, atoi( yytext ) ); }
{DIGIT}+"."{DIGIT}*     { printf( "A float: %s (%g)\n", yytext, atof( yytext ) ); }
{ID}    printf( "An identifier: %s\n", yytext );
{FILE_NAME} printf( "File name: %s\n", yytext );
{COMMENT}   printf( "COMMENT: %s\n", yytext );
"{""*".*"*""}"     printf( "An comment: %s\n", yytext );
"{""$".*\|?"}"     printf( "An variable: %s\n", yytext );
{CONFIG}    printf( "Load config: %s\n", yytext );
{INCLUDE}    printf( "Include: %s\n", yytext );
{GLOBAL}    printf( "Global: %s\n", yytext );
{IF}    printf( "if: %s\n", yytext );
{END_IF}    printf( "end if: %s\n", yytext );
{ELSE}  printf( "else: %s\n", yytext );
{COMMAND}       printf( "A keyword: %s\n", yytext ); 
{TEXT}  printf( "Text/Html %s\n", yytext ); 
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