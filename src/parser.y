%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "parser.tab.h"
    #include "bash_color.h"
    #include "symtab.h"

    int yylex(void);
    int yyerror(char * s);

    /* string literal buffer */
    char buf[100];
    char *s;
%}

%union
{
    int ival;
    char* sval;
};


%type block
%type<sval> expr
%type<sval> name_value
%token<sval> SYMBOL NUMBER
%token<sval> DOT INDIRECT_MEMBER
%token<sval> STRING_LITERAL NUMERIC_LITERAL
%token<sval> IDENTIFIER CONST_ID QUALAFIED_ID
%token<sval> IF END_IF ELSE END_ELSE ELSEIF END_ELSEIF
%token<sval> FOREACH END_FOREACH FOREACHELSE END_FOREACHELSE
%token<sval> LBRACE RBRACE LBRACKET RBRACKET LPAREN RPAREN
%token<sval> COLON SEMI_COLON QUOTE SINGLE_QUOTE SLASH BACK_SLASH AT VBAR AMPERSAND AND OR NOT
%token<sval> LESS_THAN LESS_THAN_EQUAL GREATER_THAN GREATER_THAN_EQUAL PLUS MINUS ASTERIK EQUAL PERCENT NOT_EQUAL
%token<sval> CONFIG_LOAD INCLUDE REQUIRE INSERT ASSIGN ISSET SECTION LDELIM RDELIM VERSION CYCLE COUNTER CONFIG FUNC
%token<sval> VAR_ATTRIB VALUE_ATTRIB FILE_ATTRIB FILE_NAME
%token END_OF_FILE
%start file;

%%

file:                                                           {
                                                                    printf( "\n*** RUN ***\n" );
                                                                    printf("Terminate listing with ; to see parsed AST\n");
                                                                    printf("Terminate parser with Ctrl-D ... \n*********** \n\n");
                                                                }
        blocks END_OF_FILE                                      { printf("PARSER file: | blocks END_OF_FILE\n"); exit(0); }
        ;

blocks:
    block                                                       { printf("PARSER blocks: | block\n"); }
    | blocks block                                              { printf("PARSER blocks: | blocks block\n"); }
    ;

block:
    LBRACE expr RBRACE                                          { printf("PARSER block: | LBRACE expr RBRACE\n"); }
    ;

expr:
    SYMBOL                                                      {
                                                                    printf("PARSER expr: | SYMBOL=\"%s\"\n", $1);
                                                                    $$=$1;
                                                                }
    | CONST_ID                                                  {
                                                                    printf("PARSER expr: | CONST_ID=\"%s\"\n", $1);
                                                                    $$=$1;
                                                                }
    | CONFIG_LOAD name_value                                    {
                                                                    printf("PARSER expr: | CONFIG_LOAD name_value=\"%s\"\n", $2);
                                                                    $$=$2;
                                                                }
    | ASSIGN VAR_ATTRIB EQUAL STRING_LITERAL                    {
                                                                    printf("PARSER expr: | ASSIGN VAR_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"\n", $2, buf);
                                                                    if(!find_symbol($2))
                                                                    {
                                                                        add_symbol($2, buf);
                                                                    }
                                                                    $$=buf;
                                                                }
    | INCLUDE name_value                                        { printf("PARSER expr: | INCLUDE name_value=\"%s\"\n", $2); $$=$2; }
    | REQUIRE name_value                                        { printf("PARSER expr: | REQUIRE name_value=\"%s\"\n", $2); $$=$2; }
    | INSERT name_value                                         { printf("PARSER expr: | INSERT name_value=\"%s\"\n", $2); $$=$2; }
    | expr LBRACKET NUMERIC_LITERAL RBRACKET                    { printf("PARSER expr: | expr LBRACKET NUMERIC_LITERAL=\"%s\" RBRACKET\n", $3); $$=$1; }
    | expr LPAREN RPAREN                                        { printf("PARSER expr: | expr LPAREN RPAREN\n"); $$=$1; }
    ;

name_value:
    VALUE_ATTRIB EQUAL STRING_LITERAL                          { printf("PARSER name_value: | VALUE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"\n", $1, buf); $$=buf; }
    | FILE_ATTRIB EQUAL STRING_LITERAL                         { printf("PARSER name_value: | FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"\n", $1, buf); $$=buf; }
    ;

%%

int yyerror(char * s)
{
    fprintf(stderr, "%s\n", s);
    return 0;
};

int main(int argc, char** argv)
{
    init_streamy_symtable();
    extern FILE *yyin;
    if (argc > 0)
    {
        yyin = fopen(argv[1], "r");
    }
    else
    {
        yyin = stdin;
    };
    yyparse();
};
