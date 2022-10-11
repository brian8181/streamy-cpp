%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "streamy.tab.h"



/*

\{\s*\$([A-Za-z]\w*)\s*\} { printf("VARIABLE\n"); return 0;};               // {$ABC} 
\{(" + cmds + "\\=(" + variable + "|" + string_literal + "))\} { printf("CONFIG\n"); return 0;}; 
string string_literal1 = "(\\\"[\\w\\.]*\\\")";                    // "ABC"
string string_literal2 = "(\\'[\\w*\\.]*\\')";                     // 'ABC'

{TEST} { printf("TEST"); return 0;}


\{\s*(config_load|include|insert|literal|strip|capture|section|assign|debug|eval|fetch|math)\s*\}  { printf("COMMAND\n"); return 0;};
\{\s*\$([A-Za-z0-9]+\w*)\s*\} { printf("VARIABLE\n"); return 0;};               
\{\s*\*[A-Za-z0-9]*\*\s*\}  { printf("COMMENT\n"); return 0;};
\{\s*#([A-Aa-z]+\w*)#\s*\} { printf("CONFIG\n"); return 0;}
'[A-Za-z]*' { printf("STRING_LITERAL2\n"); return 0;} 
\{\s*\*[\w\s\p]*\*\s*\}  { printf("COMMENT"); return 0;};
[a]+"x"  { printf("TEXT2 %s\n", yytext); }
*/

%}

%%



[^}{]*[.]*"\{" { printf("TEXT %s\n", yytext); }

"if"		{return IF_STATEMENT;}
"else"		{return ELSE_STATEMENT;}
'\{\s*\$([A-Za-z0-9]+\w*)\s*\}' { printf("VARIABLE\n"); return 0;};   
'[A-Za-z]*' { printf("STRING_LITERAL\n"); return 0;} 

[ \t]	; // ignore all whitespace
[0-9]+\.[0-9]+ 	{yylval.fval = atof(yytext); return T_FLOAT;}
[0-9]+		{yylval.ival = atoi(yytext); return T_INT;}
\n		{return T_NEWLINE;}
"}"		{return T_CLOSE_CURLY;}
"{"		{return T_OPEN_CURLY;}
"+"		{return T_PLUS;}
"*"		{return T_MULTIPLY;}
"/"		{return T_DIVIDE;}
"("		{return T_LEFT;}
")"		{return T_RIGHT;}
"="		{return T_EQUAL;}
"exit"		{return T_QUIT;}
"quit"		{return T_QUIT;}

%%
