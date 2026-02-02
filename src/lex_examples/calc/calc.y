%{
    #include <stdio.h>
    #include <iostream>
    int yyerror(char *s);
    int yylex();

    using std::cout;
    using std::endl;

%}

%union
{
    char* sval;
    int num;
}
%token<sval> ID
%type<sval> token tokens
%token<num> INTEGER
%type<num> expr
%start program

%%

program:
            program token '\n' { cout << "program token= " << $2 << endl; }
            |
            ;

tokens:
    token          { std::cout << "test" << std::endl; }
    | tokens token

token:
    ID {  cout << "ID" << endl; }

expr:
            INTEGER { $$ = $1; }
            | expr '+' expr { $$ = $1 + $3; }
            | expr '-' expr { $$ = $1 - $3; }
            ;

%%

int yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
    return 0;
}

int main(void)
{
    yyparse();
    return 0;
}
