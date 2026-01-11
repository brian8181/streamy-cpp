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
    const char* next_file();
%}

%union
{
    int ival;
    char* sval;
    struct nvalue* nval;
};

%type files file block blocks
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
%token END_OF_FILE END_OF_FILES
%type<sval> symbol sub_proc built_in array qualafied_id
%start complier

%%

complier:                                                        {
                                                                    printf("************************* RUN *************************\n");
                                                                    printf("* Terminate listing with ; to see parsed AST          *\n");
                                                                    printf("* Terminate parser with Ctrl-D ...                    *\n");
                                                                    printf("************************* Done ************************\n");
                                                                }
    files END_OF_FILES                                                      {
                                                                    printf("%sPARSER complier: | files END_OF_FILES%s\n", FMT_FG_GREEN, FMT_RESET);
                                                                    printf("*********************** STOPPING **********************\n");
                                                                    printf("*              End Of Files, Terminating.             *\n");
                                                                    printf("************************* Done ************************\n");
                                                                    //exit(0);
                                                                }

files:
    file
    | files file

file:
    blocks END_OF_FILE                                          {
                                                                    printf("%sPARSER file: | blocks END_OF_FILE%s\n", FMT_FG_GREEN, FMT_RESET);
                                                                    printf("*******************************************************\n");
                                                                    printf("*                      End Of File                    *\n");
                                                                    printf("*******************************************************\n");
                                                                    //exit(0);
                                                                }
        ;

blocks:
    block                                                       {
                                                                    printf("%sPARSER blocks: | block%s\n", FMT_FG_GREEN, FMT_RESET);
                                                                }
    | blocks block                                              {
                                                                    printf("%sPARSER blocks: | blocks block%s\n", FMT_FG_GREEN, FMT_RESET);
                                                                }
                                                                ;

block:
    LBRACE sub_proc RBRACE                                      {
                                                                    printf("%sPARSER block: | LBRACE sub_porc RBRACE%s\n", FMT_FG_GREEN, FMT_RESET);
                                                                }
    | LBRACE array RBRACE                                       {
                                                                    printf("%sPARSER block: | LBRACE array RBRACE%s\n", FMT_FG_GREEN, FMT_RESET);
                                                                }
    | LBRACE symbol RBRACE                                      {
                                                                    printf("%sPARSER block: | LBRACE symbol RBRACE%s\n", FMT_FG_GREEN, FMT_RESET);
                                                                }
    | LBRACE built_in RBRACE                                    {
                                                                    printf("%sPARSER block: | LBRACE built_in RBRACE%s\n", FMT_FG_GREEN, FMT_RESET);
                                                                }
    | LBRACE ASSIGN attributes RBRACE                           {
                                                                    printf("%sPARSER block: | LBRACE ASSIGN attributes RBRACE { ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\" }%s\n", FMT_FG_GREEN, $3->name, $3->value, FMT_RESET);
                                                                    if(!find_symbol(0, $3->name))
                                                                    {
                                                                        add_symbol(0, $3->name, $3->value);
                                                                    }
                                                                    pnv_head = 0;
                                                                }
    | LBRACE qualafied_id RBRACE                                {
                                                                    printf("%sPARSER block: | LBRACE qualafied_id RBRACE%s\n", FMT_FG_GREEN, FMT_RESET);
                                                                }
                                                                ;
qualafied_id:
    symbol DOT ID                                               { printf("%sPARSER qualafied_id: | symbol DOT ID%s\n", FMT_FG_GREEN, FMT_RESET); }
    | symbol INDIRECT_MEMBER ID                                 { printf("%sPARSER qualafied_id: | symbol INDIRECT_MEMBER ID%s\n", FMT_FG_GREEN, FMT_RESET); }
    | qualafied_id DOT ID                                       { printf("%sPARSER qualafied_id: | qualafied_id DOT ID%s\n", FMT_FG_GREEN, FMT_RESET); }
    | qualafied_id INDIRECT_MEMBER ID                           { printf("%sPARSER qualafied_id: | qualafied_id INDIRECT_MEMBER ID%s\n", FMT_FG_GREEN, FMT_RESET); }
                                                                ;

sub_proc:
    symbol LPAREN params RPAREN                                 {
                                                                    printf("%sPARSER sub_proc: | symbol LPAREN params RPAREN%s\n", FMT_FG_GREEN, FMT_RESET);
                                                                    $$=$1;
                                                                }
                                                                ;

array:
    symbol LBRACKET NUMERIC_LITERAL RBRACKET                    {
                                                                    printf("%sPARSER array: | symbol=\"%s\" LBRACKET NUMERIC_LITERAL=\"%s\" RBRACKET%s\n", FMT_FG_GREEN, $1, $3, FMT_RESET);
                                                                    $$=$1;
                                                                }
                                                                ;

params:
    /*empty*/
    | symbol                                                    { printf("%sPARSER params: | symbol%s\n", FMT_FG_GREEN, FMT_RESET); }
    | params COMMA symbol                                       { printf("%sPARSER qualafied_id: | params COMMA symbol%s\n", FMT_FG_GREEN, FMT_RESET); }


symbol:
    DOLLAR_SIGN ID                                              {
                                                                    printf("%sPARSER symbol: | ID=\"%s\"%s\n", FMT_FG_GREEN, $2, FMT_RESET);
                                                                    $$=$1;
                                                                }
    | CONST_ID                                                  {
                                                                    printf("%sPARSER symbol: | CONST_ID=\"%s\"%s\n", FMT_FG_GREEN, $1, FMT_RESET);
                                                                    $$=$1;
                                                                }
                                                                ;

built_in:
    CONFIG_LOAD FILE_ATTRIB EQUAL STRING_LITERAL                {
                                                                    printf("%sPARSER built_in: | CONFIG_LOAD FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, buf, FMT_RESET);
                                                                    $$=buf;
                                                                }
    | INCLUDE FILE_ATTRIB EQUAL STRING_LITERAL                  {
                                                                    printf("%sPARSER built_in: | INCLUDE FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, buf, FMT_RESET);
                                                                    /* todo */
                                                                    $$=buf;
                                                                }
    | REQUIRE FILE_ATTRIB EQUAL STRING_LITERAL                  {
                                                                    printf("%sPARSER built_in: | REQUIRE FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, buf, FMT_RESET);
                                                                    $$=buf;
                                                                }
    | INSERT FILE_ATTRIB EQUAL STRING_LITERAL                   {
                                                                    printf("%sPARSER built_in: | INSERT FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, buf, FMT_RESET);
                                                                    $$=buf;
                                                                }
                                                                ;

attributes:
    attribute                                                  {
                                                                    printf("%sPARSER attributes: | attribute={name=\"%s\"; value=\"%s\"}%s\n", FMT_FG_GREEN, $1->name, $1->value, FMT_RESET);
                                                                    $$ = $1;
                                                                    // put attribute @ head position
                                                                    $1->next = pnv_head;
                                                                    pnv_head = $1;
                                                               }
    | attributes attribute                                     {
                                                                    printf("%sPARSER attributes: | attributes attribute={name=\"%s\"; value=\"%s\"}%s\n", FMT_FG_GREEN, $2->name, $2->value, FMT_RESET);
                                                                    // put attribute @ head position
                                                                    $2->next = pnv_head;
                                                                    pnv_head = $2;
                                                                    // print attributes ...
                                                                    nvalue* cur = $2;
                                                                    while(cur != 0)
                                                                    {
                                                                        printf("attribute={name=\"%s\"; value=\"%s\"}%s\n", FMT_FG_GREEN, cur->name, cur->value, FMT_RESET);
                                                                        cur = cur->next;
                                                                    }
                                                               }
                                                               ;

attribute:
    VALUE_ATTRIB EQUAL STRING_LITERAL                          {
                                                                    printf("%sPARSER name_value: | VALUE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, buf, FMT_RESET);
	                                                                yyval.nval = alloc_nvalue($1, buf);
                                                                    $$ = yyval.nval;
                                                               }
    | VAR_ATTRIB EQUAL STRING_LITERAL                          {
                                                                    printf("%sPARSER name_value: | VAR_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, buf, FMT_RESET);
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

extern FILE *yyin;
static int g_argc;
static char** g_argv;
static int i = 0;

const char* next_file()
{
    ++i;
    if(i < g_argc)
        return g_argv[i];
    return 0;
}

int main(int argc, char** argv)
{
    g_argc = argc;
    g_argv = argv;

    extern FILE *yyin;
    if (argc > 0)
    {
        const char* f = next_file();
        if(f)
            yyin = fopen(f, "r");
    }
    else
    {
        yyin = stdin;
    };
    yyparse();
    return 0;
};
