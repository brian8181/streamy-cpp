%{

#include <stdio.h>
#include "stext.tab.h"
#include "stext.yy.h"

//int fileno(char *);
//void yyerror(char *);
int yylex(void);
char* argv[255];
char* str;

%}

%union
{
	int num;
	char* str;
}

/* %token<str> TEXT
%token<str> NEWLINE */
%type<str> program
%token OPEN_BRACE CLOSE_BRACE DOLLAR_SIGN NEWLINE
%type<str> PLAIN_TEXT
%token<str> TEXT
%type<str> VAR
%type<str> TAG


%{
	#include <stdio.h>
	int sym[26];
	int yyerror(char *s);
	int yylex();
%}

%%

program:
			PLAIN_TEXT { printf("TEXT %s", yytext); }
			|
			TAG
			|
			VAR
			;
VAR:

	DOLLAR_SIGN TEXT {$$;}
	;


TAG:
		OPEN_BRACE { printf("OPEN %s", yytext); }
		|
		OPEN_BRACE PLAIN_TEXT CLOSE_BRACE { printf("TAG %s", yytext ); }
		;
PLAIN_TEXT:

			TEXT { printf("TEXT %s", yytext); }
			|
			TEXT TEXT { printf("TT %s", yytext); }
			|
			TEXT NEWLINE { printf("TNEW %s", yytext); }
			|
			NEWLINE TEXT { printf("NEWT %s", yytext); }
			|
			PLAIN_TEXT TEXT { printf("PTEXT %s", yytext); }
			;

%%

int yyerror(char *s)
{
	fprintf(stderr, "%s\n", s);
	return 0;
}

/* int main(void)
{
	yyparse();
	return 0;
} */