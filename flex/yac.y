%{
#include <stdio.h>

int yywrap( );
void yyerror(const char* str);

/* the result variable */
double result = 0;

%}


%union {
	int ival;
}

%token<ival> digit

/* declare non-terminals */
%type <value> stmt

%%

stmt: digit {result = $1; printf($1); return "FU";}


%%

int yywrap( ) {
  return 1;
}

void yyerror(const char* str) {
  fprintf(stderr, "Compiler error: '%s'.\n", str);
}

int main(int argc, char **argv)
{
    yyparse( );
    //printf("The answer is %lf\n", result);
    return 0;
}
