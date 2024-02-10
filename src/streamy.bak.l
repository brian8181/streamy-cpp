%{
    #include <stdio.h>
    #include "streamy.tab.h"
    int yylex(void);
    void yyerror(char *);
    int DIGIT;
    int LETTER;
    int TEXT_LITERAL;
    const unsigned int EQUAL = 1;
    const unsigned int PLUS = 2;
    const unsigned int ASTERISK = 3;
    const unsigned int T_PLUS = 4;
    const unsigned int T_MULTIPLY = 5;
    const unsigned int T_DIVIDE = 6;
    const unsigned int T_LEFT = 7;
    const unsigned int T_RIGHT = 8;
    const unsigned int SINGLE_QUOTE = 9;
    const unsigned int DOUBLE_QUOTE = 10;
    const unsigned int COMMA = 11;
    const unsigned int COLON = 12;
    const unsigned int SEMI_COLON = 13;
    const unsigned int BACK_SLASH = 14;
    const unsigned int TICK_MARK = 15;
    const unsigned int DOLLAR_SIGN = 16;
    const unsigned int T_POUND = 17;
    const unsigned int T_OPEN_CURLY = 18;
    const unsigned int T_CLOSE_CURLY = 19;
    const unsigned int T_OPEN_BRACE = 20;
    const unsigned int T_CLOSE_BRACE = 21

%};

DIGIT    [0-9]
LETTER   [A-Za-z]

%%

{DIGIT}+     printf( "DIGIT: %s\n", yytext );
{LETTER}+    printf( "LETTER: %s\n", yytext );
[ \t\n]+
.   printf( "Unrecognized character: %s\n", yytext );

%%

int main( int argc, char **argv )
{
    /* skip over program name */
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
