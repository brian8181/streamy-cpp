%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "bash_color.h"
    #include "parser.tab.h"
    #include "symtab.h"

    int yylex(void);
    int yyerror(char * s);

    /* string literal buffer */
    char buf[100];
    char *s;

    //typdef struct ASTNode
    //{
    //    char* value;
    //    struct ASTNode** children;
    //    int child_count;
	//} ASTNode;

    //typedef struct AST
    //{
	//	ASTNode* root;
	//} AST;

     // typedef struct nvlist
    // {
    //     struct nvalue* head;
    // } nvlist;

    // nvlist* nvalues =(nvlist*) malloc(sizeof(nvlist));
    // nvalues->head = 0;

    typedef struct nvalue
    {
        char* name;
        char* value;
        struct nvalue* next;
    } nvalue;

    static nvalue* pnv_head = 0;
    nvalue* alloc_nvalue(char* name, char* value);
%}

%union
{
    int ival;
    char* sval;
    struct nvalue* nval;
};


%type block
%type<nval> attribute
%type<nval> attributes
%token<sval> NUMBER
%token<sval> DOLLAR_SIGN DOT INDIRECT_MEMBER
%token<sval> STRING_LITERAL NUMERIC_LITERAL
%token<sval> ID CONST_ID
%token<sval> IF END_IF ELSE END_ELSE ELSEIF END_ELSEIF
%token<sval> FOREACH END_FOREACH FOREACHELSE END_FOREACHELSE
%token<sval> LBRACE RBRACE LBRACKET RBRACKET LPAREN RPAREN
%token<sval> COLON SEMI_COLON QUOTE SINGLE_QUOTE SLASH BACK_SLASH AT VBAR AMPERSAND AND OR NOT
%token<sval> LESS_THAN LESS_THAN_EQUAL GREATER_THAN GREATER_THAN_EQUAL PLUS MINUS ASTERIK COMMA EQUAL PERCENT NOT_EQUAL
%token<sval> CONFIG_LOAD INCLUDE REQUIRE INSERT ASSIGN ISSET SECTION LDELIM RDELIM VERSION CYCLE COUNTER CONFIG FUNC
%token<sval> VAR_ATTRIB VALUE_ATTRIB FILE_ATTRIB FILE_NAME
%token END_OF_FILE
%type<sval> symbol sub_proc built_in array qualafied_id
%start file blocks

%%

file:                                                           {
                                                                    printf("************************* RUN *************************\n");
                                                                    printf("* Terminate listing with ; to see parsed AST          *\n");
                                                                    printf("* Terminate parser with Ctrl-D ...                    *\n");
                                                                    printf("************************* Done ************************\n");
                                                                }
        blocks END_OF_FILE                                      {
                                                                    printf("PARSER file: | blocks END_OF_FILE\n");
                                                                    printf("*********************** STOPPING **********************\n");
                                                                    printf("* End of file, terminating.                           *\n");
                                                                    printf("************************* Done ************************\n");
                                                                    exit(0);
                                                                }
        ;

blocks:
    block                                                       {
                                                                    printf("PARSER blocks: | block");
                                                                }
    | blocks block                                              {
                                                                    printf("PARSER blocks: | blocks block");
                                                                }
                                                                ;

block:
    LBRACE sub_proc RBRACE                                      {
                                                                    printf("PARSER block: | LBRACE sub_porc RBRACE\n");
                                                                }
    | LBRACE array RBRACE                                       {
                                                                    printf("PARSER block: | LBRACE array RBRACE\n");
                                                                }
    | LBRACE symbol RBRACE                                      {
                                                                    printf("PARSER block: | LBRACE symbol RBRACE\n");
                                                                }
    | LBRACE built_in RBRACE                                    {
                                                                    printf("PARSER block: | LBRACE built_in RBRACE\n");
                                                                }
    | LBRACE ASSIGN attributes RBRACE                           {
                                                                    printf("PARSER block: | LBRACE ASSIGN attributes RBRACE { ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\" }\n", $3->name, $3->value);
                                                                    if(!find_symbol(0, $3->name))
                                                                    {
                                                                        add_symbol(0, $3->name, $3->value);
                                                                    }
                                                                    pnv_head = 0;
                                                                }
    | LBRACE qualafied_id RBRACE                                {
                                                                    printf("PARSER block: | LBRACE qualafied_id RBRACE\n");
                                                                }
                                                                ;
qualafied_id:
    symbol DOT ID                                               { printf("PARSER qualafied_id: | symbol DOT ID\n"); }
    | symbol INDIRECT_MEMBER ID                                 { printf("PARSER qualafied_id: | symbol INDIRECT_MEMBER ID\n"); }
    | qualafied_id DOT ID                                       { printf("PARSER qualafied_id: | qualafied_id DOT ID\n"); }
    | qualafied_id INDIRECT_MEMBER ID                           { printf("PARSER qualafied_id: | qualafied_id INDIRECT_MEMBER ID\n"); }
                                                                ;

sub_proc:
    symbol LPAREN params RPAREN                                 {
                                                                    printf("PARSER sub_proc: | symbol LPAREN params RPAREN\n");
                                                                    $$=$1;
                                                                }
                                                                ;

array:
    symbol LBRACKET NUMERIC_LITERAL RBRACKET                    {
                                                                    printf("PARSER array: | symbol=\"%s\" LBRACKET NUMERIC_LITERAL=\"%s\" RBRACKET\n", $1, $3);
                                                                    $$=$1;
                                                                }
                                                                ;

params:
    /*empty*/
    | symbol                                                    { printf("PARSER params: | symbol\n"); }
    | params COMMA symbol                                       { printf("PARSER qualafied_id: | params COMMA symbol\n"); }


symbol:
    DOLLAR_SIGN ID                                              {
                                                                    printf("PARSER symbol: | ID=\"%s\"\n", $1);
                                                                    $$=$1;
                                                                }
    | CONST_ID                                                  {
                                                                    printf("PARSER symbol: | CONST_ID=\"%s\"\n", $1);
                                                                    $$=$1;
                                                                }
                                                                ;

built_in:
    CONFIG_LOAD FILE_ATTRIB EQUAL STRING_LITERAL                {
                                                                    printf("PARSER built_in: | CONFIG_LOAD FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"\n", $1, buf);
                                                                    $$=buf;
                                                                }
    | INCLUDE FILE_ATTRIB EQUAL STRING_LITERAL                  {
                                                                    printf("PARSER built_in: | INCLUDE FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"\n", $1, buf);
                                                                    /* todo */
                                                                    $$=buf;
                                                                }
    | REQUIRE FILE_ATTRIB EQUAL STRING_LITERAL                  {
                                                                    printf("PARSER built_in: | REQUIRE FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"\n", $1, buf);
                                                                    $$=buf;
                                                                }
    | INSERT FILE_ATTRIB EQUAL STRING_LITERAL                   {
                                                                    printf("PARSER built_in: | INSERT FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"\n", $1, buf);
                                                                    $$=buf;
                                                                }
                                                                ;

attributes:
    attribute                                                  {
                                                                    printf("PARSER attributes: | attribute={name=\"%s\"; value=\"%s\"}\n", $1->name, $1->value);
                                                                    $$ = $1;
                                                                    // put attribute @ head position
                                                                    $1->next = pnv_head;
                                                                    pnv_head = $1;
                                                               }
    | attributes attribute                                     {
                                                                    printf("PARSER attributes: | attributes attribute={name=\"%s\"; value=\"%s\"}\n", $2->name, $2->value);
                                                                    // put attribute @ head position
                                                                    $2->next = pnv_head;
                                                                    pnv_head = $2;
                                                                    // print attributes ...
                                                                    nvalue* cur = $2;
                                                                    while(cur != 0)
                                                                    {
                                                                        printf("attribute={name=\"%s\"; value=\"%s\"}\n", cur->name, cur->value);
                                                                        cur = cur->next;
                                                                    }
                                                               }
                                                               ;

attribute:
    VALUE_ATTRIB EQUAL STRING_LITERAL                          {
                                                                    printf("PARSER name_value: | VALUE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"\n", $1, buf);
	                                                                yyval.nval = alloc_nvalue($1, buf);
                                                                    $$ = yyval.nval;
                                                               }
    | VAR_ATTRIB EQUAL STRING_LITERAL                          {
                                                                    printf("PARSER name_value: | VAR_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"\n", $1, buf);
                                                                    yyval.nval = alloc_nvalue($1, buf);
                                                                    $$ = yyval.nval;
                                                               }
                                                               ;

%%

char* STRDUP(char* s)
{
    char* dup = (char*)malloc((strlen(s) * sizeof(char)) + 1);
    strcpy(dup, s);
    return dup;
}

nvalue* alloc_nvalue(char* name, char* value)
{
    nvalue* nval = (nvalue*)malloc( sizeof( nvalue ) );
    nval->name = STRDUP(name);
    nval->value = STRDUP(value);
    nval->next = 0;
    return nval;
}

int yyerror(char * s)
{
    fprintf(stderr, "%s\n", s);
    return 0;
};

int main(int argc, char** argv)
{
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
    return 0;
};
