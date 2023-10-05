
%{
/* need this for the call to atof() below */
#include <math.h>
%}

DIGIT            [0-9]
NUMBER           [0-9]+
OPEN_CURLY       "{"
CLOSE_CURLY      "}"
OPEN_BRACE       "["
CLOSE_BRACE      "]"
OPEN_PAREN       "("
CLOSE_PAREN      ")"
LESS_THAN        "<"
GREATER_THAN     ">"
SINGLE_QUOTE     "'"
DOUBLE_QUOTE     "\""
EQUAL            "="
DOT              "."
PLUS             "+"
MINUS            "-"
MULTIPLY         "*"
EXPONET          "^"
FOREWARD_SLASH    "/"
BACKWARD_SLASH   "\\"
BAR              "|"
HASH             "#"
UNDERSCORE       "-"
SEMI_COLON       ";"
COLON            ":"
AMPERSAND        "&"
TILDE            "~"
TICK_MARK        "`"
AT_SYMBOL        "@"
EXCLAMATION      "!"
PERCENT          "%"
COMMA            ","
QUESTION         "?"
VARIABLE         "$"[a-zA-Z]+[a-zA-Z0-9]*
TEXT             [a-zA-Z0-9]+[a-zA-Z0-9]*

%%

{OPEN_CURLY}                printf( "OPEN_CURLY: %s\n", yytext );
{CLOSE_CURLY}               printf( "CLOSE_CURLY: %s\n", yytext );
{OPEN_BRACE}                printf( "OPEN_BRACE: %s\n", yytext );
{CLOSE_BRACE}               printf( "CLOSE_BRACE: %s\n", yytext );
{OPEN_PAREN}                printf( "OPEN_PAREN: %s\n", yytext );
{CLOSE_PAREN}               printf( "CLOSE_PAREN: %s\n", yytext );
{LESS_THAN}                 printf( "LESS_THAN: %s\n", yytext );
{GREATER_THAN}              printf( "GREATER_THAN: %s\n", yytext );
{SINGLE_QUOTE}              printf( "SINGLE_QOUTE: %s\n", yytext );
{DOUBLE_QUOTE}              printf( "DOUBLE_QOUTE: %s\n", yytext );
{EQUAL}                     printf( "EQUAL: %s\n", yytext );
{DOT}                       printf( "DOT: %s\n", yytext );
{PLUS}                      printf( "PLUS: %s\n", yytext );
{MINUS}                     printf( "MINUS: %s\n", yytext );
{MULTIPLY}                  printf( "MULTIPLY: %s\n", yytext );
{FOREWARD_SLASH}            printf( "FOREWARD_SLASH: %s\n", yytext );
{BACKWARD_SLASH}            printf( "BACKWARD_SLASH: %s\n", yytext );
{BAR}                       printf( "BAR: %s\n", yytext );
{HASH}                       printf( "HASH: %s\n", yytext );
{UNDERSCORE}                printf( "UNDERSCORE: %s\n", yytext );
{SEMI_COLON}                printf( "SEMI_COLON: %s\n", yytext );
{COLON}                     printf( "COLON: %s\n", yytext );
{AMPERSAND}                 printf( "AMPERSAND: %s\n", yytext );
{TILDE}                     printf( "TILDE: %s\n", yytext );
{TICK_MARK}                 printf( "TICK_MARK: %s\n", yytext );
{AT_SYMBOL}                 printf( "AT_SYMBOL: %s\n", yytext );
{EXCLAMATION}               printf( "EXCLAMATION: %s\n", yytext );
{PERCENT}                   printf( "PERCENT: %s\n", yytext );
{COMMA}                     printf( "COMMA: %s\n", yytext );
{QUESTION}                  printf( "QUESTION: %s\n", yytext );
{VARIABLE}                  printf( "VARIABLE: %s\n", yytext );
{NUMBER}                    printf( "NUMBER: %s\n", yytext );
{TEXT}                      printf( "TEXT: %s\n",  yytext );
[ \t\n]                     {};
.                           printf( "Unrecognized character: %s\n", yytext );

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