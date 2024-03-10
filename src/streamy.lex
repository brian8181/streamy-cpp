/*
   File Name:  streamy.l
   Build Date: Wed Feb 14 12:02:37 AM CST 2024
   Version:    0.0.1
*/
%{
    #include <stdlib.h>
    #include <stdio.h>
    #include <string.h>
    //#include "streamy.yy.h"
    #include "streamy.tab.h"

    extern char *yytext;
    // extern int yyleng;
    extern int yylineno;
    // int yylex(void);
    // void yyerror(char *);
    // extern YYSTYPE yylval;
    int fileno(FILE *);

%}

NEWLINE                     '\n'
OPEN_BRACE                  "{"
CLOSE_BRACE                 "}"
EQUALS_EQUALS               "=="
SYMBOL                       $[A-Za-z]+[A-Za-z0-9]*
TEXT                         [\\w\\s\\=$><^/#@~&*.%!~`_:\"'\\\\,]*
STRING_LITERAL               \\"[\\w\\s\\=$><^/#@~&*.%!~`_:\"'\\\\,]*\\"
NUMERIC_LITERAL              [\\d]+.[\\d]*

%%

{NEWLINE} return NEWLINE;
{OPEN_BRACE} return OPEN_BRACE;
{CLOSE_BRACE} return CLOSE_BRACE;
{EQUALS_EQUALS} return EQUALS_EQUALS;
{SYMBOL} return SYMBOL;
{TEXT} return TEXT;
{STRING_LITERAL} return STRING_LITERAL;
{NUMERIC_LITERAL} return NUMERIC_LITERAL;

%%