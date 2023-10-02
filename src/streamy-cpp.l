/* scanner for a toy Pascal-like language */

%{
/* need this for the call to atof() below */
#include <math.h>
%}

OPEN_CURLY "{"
CLOSE_CURLY "}"
OPEN_PAREN "("
CLOSE_PAREN ")"
NUMBER [-+]?([0-9]*\.?[0-9]+|[0-9]+\.[0-9]*)
FORTRAN_PATTERN  [-+]?([0-9]*\.?[0-9]+|[0-9]+\.)(E(+|-)?[0-9]+)?
DIGIT    [0-9]
ALPHA_NUMERIC [a-z0-9]
PUNCT [*&^%$#@_]
VARIABLE    [a-z]+[a-z0-9]*(\[{DIGIT}+\])?(\.[a-z][a-z0-9]+)* 
INDIRECT_SELECTOR "->"
FUNC_PARAMS "(\${VARIABLE}+(, \${VARIABLE})*)"
FUNC = "\${VARIABLE}{FUNC_PARMS}"
ARRARY "\[{DIGIT}+\]""

COMMAND "(config_load|include|insert|literal|strip|capture|section|assign|debug|eval|fetch|math)"
COMMENT "\\{\\*a*\\*\\}"
CONFIG  "config_load "[ \t]*"file='".*"'"
INCLUDE  "include "[ \t]*"file='".*"'"
INSERT  "insert "[ \t]*"file='".*"'"
GLOBAL  "\{\#".*"\#\}"
FILE_NAME [a-zA-Z.]+[a-zA-Z0-9.]*[a-zA-Z0-9]+
TEXT [a-zA-Z0-9 <>=#$_'"\\/\t\n]
IF "\{if (\${VARIABLE})|({STRING_LITERAL})\}"
END_IF "\{/if\}"
ELSE "\{else\}"
ELSE_IF "\{elseif $"{VARIABLE}"\}"
FOREACH "\{foreach from=${VARIABLE} item={VARIABLE} (name={ALPHA_NUMERIC}+)? (key={ALPHA_NUMERIC}+)?\}"
FOREACHELSE "\{foreachelse\}"
END_FOREACH "\{/foreach\}"
LITERAL "\{literal\}"
END_LITERAL "\{/literal\}"
LIT L?\"([^"\\]|\\['"?\\abfnrtv]|\\[0-7]{1,3}|\\[Xx][0-9a-fA-F]+|{UCN})*\"
STRING_LITERAL \"{ALPHA_NUMERIC}+\"

%%

{DIGIT}+    { printf( "An integer: %s (%d)\n", yytext, atoi( yytext ) ); }
{DIGIT}+"."{DIGIT}*     { printf( "A float: %s (%g)\n", yytext, atof( yytext ) ); }
"$"{VARIABLE}    printf( "VARIABLE: %s\n", yytext );
"$"{VARIABLE}{INDIRECT_SELECTOR}{ALPHA_NUMERIC}*    printf( "IDIRECT_SELECTION: %s\n", yytext );
{FUNC_PARAMS}   printf( "IDIRECT_SELECTION: %s\n", yytext );
{FILE_NAME} printf( "File name: %s\n", yytext );
{FOREACH}   printf( "FOREACH: %s\n", yytext );
{TEXT}*  printf( "\nText/Html %s\n\n", yytext ); 
{COMMENT}   printf( "COMMENT: %s\n", yytext );
{OPEN_CURLY}    printf( "OPEN_CURLY: %s\n", yytext );
{CLOSE_CURLY}   printf( "CLOSE_CURLY: %s\n", yytext );
{OPEN_PAREN}    printf( "OPEN_PAREN: %s\n", yytext );
{CLOSE_PAREN}    printf( "CLOSE_PAREN: %s\n", yytext );
"\*".*"\*"        printf( "COMMENT: %s\n", yytext );
{CONFIG}    printf( "LOAD_CONFIG: %s\n", yytext );
{INCLUDE}    printf( "INCLUDE: %s\n", yytext );
{GLOBAL}    printf( "Global: %s\n", yytext );
{IF}    printf( "IF: %s\n", yytext );
{ELSE}    printf( "ELSE: %s\n", yytext );
{ELSE_IF}    printf( "ELSE_IF: %s\n", yytext );
{END_IF}    printf( "END_IF: %s\n", yytext );

{FOREACHELSE}   printf( "FOREACHELSE: %s\n", yytext );
{END_FOREACH}   printf( "END_FOREACH: %s\n", yytext );
{COMMAND}       printf( "A keyword: %s\n", yytext ); 
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