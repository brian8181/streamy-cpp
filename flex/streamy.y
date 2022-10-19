%{

#include <stdio.h>
#include <stdlib.h>

%}


%token INTEGER
%token OP
%token NEWLINE


%%

program:
	program expr '\n'
	|
;

expr: 
	INTEGER { $$ = $1; }
	| expr '+' expr { $$ = $1 + $3; }
	| expr '-' expr { $$ = $1 - $3; }
;
%%

