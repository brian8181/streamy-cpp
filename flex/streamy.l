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

"a" | "b" { return yytext[0]; } // testing ...
*/

%}

%%

[ \t]	; // ignore all whitespace
"="		{ printf("=\n"); return T_EQUAL; }
"*"		{ printf("*\n"); return T_ASTREIK; }
"+"		{ return T_PLUS;}
"*"		{ return T_MULTIPLY; }
"/"		{ return T_DIVIDE; }
"("		{ return T_LEFT; }
")"		{ return T_RIGHT; }
"'"		{ return SINGLE_QUOTE; }
"\""		{ return DOUBLE_QUOTE; }
","		{ return COMMA; }
":"		{ return COLON; }
";"		{ return SEMI_COLON; }
"\\"		{ return BACK_SLASH; }
"`"		{ return TICK_MARK; }
"$"		{ return DOLLAR_SIGN; }
"#"		{ printf("*\n"); return T_POUND; }
"{"		{ printf("{\n"); return T_OPEN_CURLY; }
"}"		{ printf("}\n"); return T_CLOSE_CURLY; }
"["		{ printf("[\n"); return T_OPEN_BRACE; }
"]"		{ printf("]\n"); return T_CLOSE_BRACE; }
"|"		{ printf("]\n"); return VBAR; }
"&"		{ printf("]\n"); return AMPERSAND; }
"@"		{ printf("]\n"); return AT_SIGN; }
"-"		{ printf("]\n"); return DASH; }
"_"		{ printf("]\n"); return UNDERSCORE; }
"."		{ printf("]\n"); return DOT; }
"!"		{ printf("]\n"); return EXCLAMATION; }
"<"		{ printf("]\n"); return LESS_THAN; }
">"		{ printf("]\n"); return GREATER_THAN; }
"%"		{ printf("]\n"); return PERCENT; }
"^"		{ printf("]\n"); return CARROT; }
"~"		{ printf("]\n"); return TILDE; }
"?"		{ printf("]\n"); return QUESTION_MARK; }
"if"    { printf("if\n"); return IF_STATEMENT; }
"fi"    { printf("if\n"); return ENDIF_STATEMENT; }
"else"	{ printf("else\n"); return ELSE_STATEMENT;}
"elseif"	{ printf("elseif\n"); return ELSEIF_STATEMENT;}
"foreach"	{ printf("foreach\n"); return FOREACH_STATEMENT; }
"config_load|include|insert|literal|strip|capture|section|assign|debug|eval|fetch|math" { printf("$1\n"); return KEYWORD; }
[{]?[A-Za-z0-9\s]*[{] { printf("%s\n", yytext); return TEXT; }
[$][A-Za-z][A-Za-z0-9]* { printf("VAR\n"); return VARIABLE;};   
\"[A-Za-z]*\" { printf("STRING_LITERAL\n"); return STRING_LITERAL;} 
[1-9][0-9]* { printf("INT_LITERAL\n"); return INT_LITERAL;} 


[0-9]+\.[0-9]+ 	{yylval.fval = atof(yytext); return T_FLOAT;}
[0-9]+		{yylval.ival = atoi(yytext); return T_INT;}
\n		{ return T_NEWLINE; }

"exit"		{ return T_QUIT; }
"quit"		{ return T_QUIT; }

%%
