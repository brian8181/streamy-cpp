%{
#include <stdio.h>

int yywrap( );
void yyerror(const char* str);

/* the result variable */
//int result = 0;

%}


%union {
	char const*  str;   
}

%token <int> digit

/* declare non-terminals */
%type stmt
%type <int> number

%%

number:
  | digit 

stmt:
  | stmt number stmt


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
