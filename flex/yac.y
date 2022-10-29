%{
#include <stdio.h>

%}


%union {
  int nval;
	char const*  str;   
}

%token digit
%token add

/* declare non-terminals */

%type term
%type exp

%%
term: 
  | exp
;

exp: digit
  | exp add exp
;


%%
