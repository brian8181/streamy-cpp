/*
   File Name:  streamy.l
   Build Date: Wed Feb 14 12:02:37 AM CST 2024
   Version:    0.0.1
*/
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "streamy.tab.h"

    extern char *yytext;
    extern int yylineno;
    // int yylex(void);
    // void yyerror(char *);
    // extern YYSTYPE yylval;
    int fileno(FILE *);
%}

NEWLINE                     '\n'
OPEN_BRACE                  "{"
CLOSE_BRACE                 '}'
EQUALS_EQUALS               "=="
SYMBOL                       $[A-Za-z]+[A-Za-z0-9]*
TEXT                         [\\w\\s\\=$><^/#@~&*.%!~`_:\"'\\\\,]*
STRING_LITERAL               \\"[\\w\\s\\=$><^/#@~&*.%!~`_:\"'\\\\,]*\\"
NUMERIC_LITERAL              [\\d]+.[\\d]*

%%

{NEWLINE} { return NEWLINE; }
{OPEN_BRACE} { return OPEN_BRACE; }
{CLOSE_BRACE} { return CLOSE_BRACE; }
{EQUALS_EQUALS} { return EQUALS_EQUALS; }
{SYMBOL} { return SYMBOL; }
{TEXT} { return TEXT; }


%%