%{

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
const unsigned int T_CLOSE_BRACE = 21;


// "|"		{ printf("VBAR\n"); return VBAR; }
// "&"		{ printf("]\n"); return AMPERSAND; }
// "@"		{ printf("]\n"); return AT_SIGN; }
// "-"		{ printf("]\n"); return DASH; }
// "_"		{ printf("]\n"); return UNDERSCORE; }
// "."		{ printf("]\n"); return DOT; }
// "!"		{ printf("]\n"); return EXCLAMATION; }
// "<"		{ printf("]\n"); return LESS_THAN; }
// ">"		{ printf("]\n"); return GREATER_THAN; }
// "%"		{ printf("]\n"); return PERCENT; }
// "^"		{ printf("]\n"); return CARROT; }
// "~"		{ printf("]\n"); return TILDE; }
// "?"		{ printf("]\n"); return QUESTION_MARK; }
// "if"    { printf("if\n"); return IF_STATEMENT; }
// "fi"    { printf("if\n"); return ENDIF_STATEMENT; }
// "else"	{ printf("else\n"); return ELSE_STATEMENT;}
// "elseif"	{ printf("elseif\n"); return ELSEIF_STATEMENT;}
// "foreach"	{ printf("foreach\n"); return FOREACH_STATEMENT; }
// "config_load|include|insert|literal|strip|capture|section|assign|debug|eval|fetch|math" { printf("$1\n"); return KEYWORD; }
// [{]?[A-Za-z0-9\s]*[{] { printf("%s\n", yytext); return TEXT; }
// [$][A-Za-z][A-Za-z0-9]* { printf("VAR\n"); return VARIABLE;};   
// \"[A-Za-z]*\" { printf("STRING_LITERAL\n"); return STRING_LITERAL;} 
// [1-9][0-9]* { printf("INT_LITERAL\n"); return INT_LITERAL;} 


%}

DIGIT    [0-9]

%%

{DIGIT}+    { printf( "An integer: %s (%d)\n", yytext, atoi( yytext ) ); }
"="		{ printf("EQUAL"); }
"+"		{ printf("PLUS"); return T_PLUS;}
"*"		{ printf("MULTIPLY"); return T_MULTIPLY; }
"{"		{ printf("T_OPEN_CURLY\n"); return T_OPEN_CURLY; }
"}"		{ printf("T_CLOSE_CURLY\n"); return T_CLOSE_CURLY; }
"["		{ printf("T_OPEN_BRACE\n"); return T_OPEN_BRACE; }
"]"		{ printf("T_CLOSE_BRACE\n"); return T_CLOSE_BRACE; }
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
