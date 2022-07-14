%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "smarty-cpp.tab.h"

%}

%%

\{\s*\$([A-Za-z]\w*)\s*\} { printf("VARIABLE\n"); return 0;};               // {$ABC}
[ \t]	; // ignore all whitespace
[a-z][0-9]* ECHO;
[0-9]+\.[0-9]+ 	{yylval.fval = atof(yytext); return T_FLOAT;}
[0-9]+		{yylval.ival = atoi(yytext); return T_INT;}
\n		{return T_NEWLINE;}
"+"		{return T_PLUS;}
"*"		{return T_MULTIPLY;}
"/"		{return T_DIVIDE;}
"("		{return T_LEFT;}
")"		{return T_RIGHT;}
"exit"		{return T_QUIT;}
"quit"		{return T_QUIT;}

%%
