%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%union {
	int ival;
	float fval;
	char* strval;
}

%token<ival> T_INT  STRING_LITERAL INT_LITERAL
%token<fval> T_FLOAT
%token<strval> TEXT ESCAPE  T_CLOSE_BRACE T_OPEN_BRACE
%token T_CLOSE_CURLY T_OPEN_CURLY IF_STATEMENT ELSE_STATEMENT test T_EQUAL VARIABLE FOREACH_STATEMENT T_POUND T_ASTREIK
%token VBAR AMPERSAND AT_SIGN DASH UNDERSCORE DOT LESS_THAN GREATER_THAN PERCENT CARROT TILDE QUESTION_MARK EXCLAMATION ENDIF_STATEMENT ELSEIF_STATEMENT KEYWORD SINGLE_QUOTE DOUBLE_QUOTE
%token DOLLAR_SIGN TICK_MARK BACK_SLASH COLON SEMI_COLON COMMA
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT 
%token T_NEWLINE T_QUIT 
%left T_PLUS T_MINUS 
%left T_MULTIPLY T_DIVIDE


%type<strval> text
%type escaped
%type<const char*> code
%type<const char*> test
%type<ival> expression
%type<fval> mixed_expression

%start text
%%

text:
	| T_EQUAL { printf("=", $$); return 0; }
	| T_ASTREIK { printf("*", $$); return 0; }
;

escaped: { return 42; }
	| T_OPEN_BRACE 
	| T_CLOSE_BRACE 
	| escaped T_CLOSE_BRACE 
	| T_OPEN_BRACE escaped 
	| T_OPEN_BRACE escaped T_CLOSE_BRACE
;

open_brace:
	| T_OPEN_BRACE
;


line: T_NEWLINE
	| mixed_expression T_NEWLINE { printf("\tResult: %f\n", $1);}
    | expression T_NEWLINE { printf("\tResult: %i\n", $1); }
    | T_QUIT T_NEWLINE { printf("bye!\n"); exit(0); }
	
;

mixed_expression: 
	  T_FLOAT                 		 { $$ = $1; }
	  | T_OPEN_CURLY { $$; }
	  | T_CLOSE_CURLY { $$;}
	  | IF_STATEMENT { $$; }
	  | ELSE_STATEMENT { $$;}
	  
	  | mixed_expression T_PLUS mixed_expression	 { $$ = $1 + $3; }
	  | mixed_expression T_MINUS mixed_expression	 { $$ = $1 - $3; }
	  | mixed_expression T_MULTIPLY mixed_expression { $$ = $1 * $3; }
	  | mixed_expression T_DIVIDE mixed_expression	 { $$ = $1 / $3; }
	  | T_LEFT mixed_expression T_RIGHT		 { $$ = $2; }
	  | expression T_PLUS mixed_expression	 	 { $$ = $1 + $3; }
	  | expression T_MINUS mixed_expression	 	 { $$ = $1 - $3; }
	  | expression T_MULTIPLY mixed_expression 	 { $$ = $1 * $3; }
	  | expression T_DIVIDE mixed_expression	 { $$ = $1 / $3; }
	  | mixed_expression T_PLUS expression	 	 { $$ = $1 + $3; }
	  | mixed_expression T_MINUS expression	 	 { $$ = $1 - $3; }
	  | mixed_expression T_MULTIPLY expression 	 { $$ = $1 * $3; }
	  | mixed_expression T_DIVIDE expression	 { $$ = $1 / $3; }
	  | expression T_DIVIDE expression		 { $$ = $1 / (float)$3; }
	  | T_OPEN_CURLY IF_STATEMENT expression T_CLOSE_CURLY { printf(""); }
		  | test { printf(""); }
		  |  mixed_expression T_OPEN_CURLY IF_STATEMENT VARIABLE T_EQUAL STRING_LITERAL { $$ = $1; }
;

expression: T_INT				{ $$ = $1; }
	| STRING_LITERAL { $$ = $1; }
	| VARIABLE {}

	  | expression T_PLUS expression	{ $$ = $1 + $3; }
	  | expression T_MINUS expression	{ $$ = $1 - $3; }
	  | expression T_MULTIPLY expression	{ $$ = $1 * $3; }
	  | T_LEFT expression T_RIGHT		{ $$ = $2; }
	  |  VARIABLE T_EQUAL STRING_LITERAL		{ printf(""); }
	  
;	

code: 
	T_OPEN_CURLY IF_STATEMENT { printf("IFFFF"); }
	
	| code T_CLOSE_CURLY { printf("IF"); }
	| VARIABLE { printf($$); }
	| STRING_LITERAL { printf(""); }
	| IF_STATEMENT { printf(""); }
	| ELSE_STATEMENT { printf(""); }
	| T_EQUAL { printf(""); }
	
	| code VARIABLE T_EQUAL STRING_LITERAL code { printf($1)); }
	| code ELSE_STATEMENT code { printf(""); }

;



%%

int main() {
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
