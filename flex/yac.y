%{
#include <stdio.h>

int yywrap( );
void yyerror(const char* str);

%}


%union {
	int ival;
}

%token<ival> DIGIT

%%

digit: DIGIT 
;


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
