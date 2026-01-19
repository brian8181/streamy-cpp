%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "bash_color.h"
    #include "parser.tab.h"
    #include "symtab.h"

    int yylex(void);
    int yyerror(char * s);


    char* STRDUP(char* s);

    /* string literal buffer */
    char buf[100];
    char *s;

    typedef struct nvalue
    {
        char* name;
        char* value;
        struct nvalue* next;
    } nvalue;

    static nvalue* pnv_head = 0;
    nvalue* alloc_nvalue(char* name, char* value);
    void free_nvalue(nvalue* nv);
    void free_all_nvalues();
%}

%union
{
    int ival;
    char* sval;
    struct nvalue* nval;
};

%token END 0 _("end of input")
%type files file block blocks
%type<nval> attribute built_in
%type<nval> attributes
%token<sval> NUMBER
%token<sval> DOLLAR_SIGN POUND_SIGN DOT INDIRECT_MEMBER
%token<sval> STRING_LITERAL NUMERIC_LITERAL
%token<sval> ID CONST_SYMBOL SYMBOL
%token<sval> IF END_IF ELSE END_ELSE ELSEIF END_ELSEIF
%token<sval> FOREACH END_FOREACH FOREACHELSE END_FOREACHELSE
%token<sval> LBRACE RBRACE LBRACKET RBRACKET LPAREN RPAREN
%token<sval> COLON SEMI_COLON QUOTE SINGLE_QUOTE SLASH BACK_SLASH AT VBAR AMPERSAND AND OR NOT
%token<sval> LESS_THAN LESS_THAN_EQUAL GREATER_THAN GREATER_THAN_EQUAL PLUS MINUS ASTERIK COMMA EQUAL PERCENT NOT_EQUAL
%token<sval> CONFIG_LOAD INCLUDE REQUIRE INSERT ASSIGN ISSET SECTION LDELIM RDELIM VERSION CYCLE COUNTER CONFIG FUNC
%token<std::string> CAPITALIZE CAT COUNT_CHARACTERS COUNT_SENTENCES COUNT_PARAGRAPHS DATE_FORMAT ESCAPE
%token<std::string> INDENT LOWER UPPER STRIP REPLACE SPACIFY STRING_FORMAT STRIP_TAGS TRUNCATE WORDWARP
%token<sval> VAR_ATTRIB VALUE_ATTRIB FILE_ATTRIB FILE_NAME
%token END_OF_FILES
%type<sval> symbol sub_proc array qualafied_id
%start complier

%%

complier:
    files                                                       {
                                                                    GREEN("PARSER complier: | files\n");
                                                                    GREEN("*********************** STOPPING **********************\n");
                                                                    GREEN("*                     Terminating.                    *\n");
                                                                    GREEN("************************* Done ************************\n");
                                                                    //exit(0);
                                                                }

files:
    file                                                        { GREEN("PARSER files: | file\n"); }
    | files file                                                { GREEN("PARSER files: | files file\n"); }

file:
    blocks END                                                  {
                                                                    GREEN("PARSER file: | blocks END_OF_FILE\n");
                                                                    GREEN("*******************************************************\n");
                                                                    GREEN("*                      End Of File                    *\n");
                                                                    GREEN("*******************************************************\n");
                                                                    //exit(0);
                                                                }
        ;

blocks:
    block                                                       {
                                                                    YELLOW("PARSER blocks: | block\n");
                                                                }
    | blocks block                                              {
                                                                    YELLOW("PARSER blocks: | blocks block\n");
                                                                }
                                                                ;

block:
    LBRACE sub_proc RBRACE                                      {
                                                                    YELLOW("PARSER block: | LBRACE sub_porc RBRACE\n");
                                                                }
    | LBRACE array RBRACE                                       {
                                                                    YELLOW("PARSER block: | LBRACE array RBRACE\n");
                                                                }
    | LBRACE symbol RBRACE                                      {
                                                                    YELLOW("PARSER block: | LBRACE symbol RBRACE\n");
                                                                }
    | LBRACE qualafied_id RBRACE                                {
                                                                    YELLOW("PARSER block: | LBRACE qualafied_id RBRACE\n");
                                                                }
     | LBRACE built_in RBRACE                                   {
                                                                    YELLOW("PARSER block: | LBRACE built_in RBRACE\n");

                                                                    //free_all_nvalues();
                                                                }
                                                                ;
qualafied_id:
    symbol DOT ID                                               { YELLOW("PARSER qualafied_id: | symbol DOT ID\n"); }
    | symbol DOT symbol                                         { RED("PARSER qualafied_id: | symbol DOT symbol\n"); }
    | symbol INDIRECT_MEMBER ID                                 { YELLOW("PARSER qualafied_id: | symbol INDIRECT_MEMBER ID\n"); }
    | qualafied_id DOT ID                                       { YELLOW("PARSER qualafied_id: | qualafied_id DOT ID\n"); }
    | qualafied_id INDIRECT_MEMBER ID                           { YELLOW("PARSER qualafied_id: | qualafied_id INDIRECT_MEMBER ID\n"); }
                                                                ;

sub_proc:
    symbol LPAREN RPAREN                                        {
                                                                    GREEN("PARSER sub_proc: | symbol LPAREN RPAREN\n");
                                                                    $$=$1;
                                                                }
    | symbol LPAREN params RPAREN                                 {
                                                                    GREEN("PARSER sub_proc: | symbol LPAREN params RPAREN\n");
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
    param                                                       { GREEN("PARSER params: | param\n"); }
    | params symbol                                             { GREEN("PARSER qualafied_id: | params COMMA symbol\n"); }

param:
    symbol COMMA                                                { GREEN("PARSER param: | symbol COMMA\n"); }

symbol:
    SYMBOL                                              {
                                                                    printf("%sPARSER symbol: | ID=\"%s\"\n", FMT_FG_GREEN, $1, FMT_RESET);
                                                                    $$=$1;
                                                                }
    | CONST_SYMBOL                                {
                                                                    printf("%sPARSER symbol: | CONST_ID=\"%s\"\n", FMT_FG_GREEN, $1, FMT_RESET);
                                                                    $$=$1;
                                                                }
    | symbol VBAR CAPITALIZE                                     {
                                                                    printf("PARSER symbol: | symbol VBAR CAPITALIZE\n");
                                                                    $$=$1;
                                                                }
                                                                ;

built_in:
    CONFIG_LOAD attributes                                        {
                                                                    printf("%sPARSER built_in: | CONFIG_LOAD FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, buf, FMT_RESET);
                                                                    nvalue* nv = (nvalue*)malloc(sizeof(nvalue));
                                                                    nv->name = STRDUP($1);
                                                                    nv->value = STRDUP(s);
                                                                    $$=nv;
                                                                    s = 0;
                                                                }
    | INCLUDE attributes                  {
                                                                    printf("%sPARSER built_in: | INCLUDE FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, buf, FMT_RESET);
                                                                    nvalue* nv = (nvalue*)malloc(sizeof(nvalue));
                                                                    nv->name = STRDUP($1);
                                                                    nv->value = STRDUP(s);
                                                                    $$=nv;
                                                                    s = 0;
                                                                }
    | REQUIRE attributes                  {
                                                                    printf("%sPARSER built_in: | REQUIRE FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, buf, FMT_RESET);
                                                                    nvalue* nv = (nvalue*)malloc(sizeof(nvalue));
                                                                    nv->name = STRDUP($1);
                                                                    nv->value = STRDUP(s);
                                                                    $$=nv;
                                                                    s = 0;
                                                                }
    | INSERT attributes                   {
                                                                    printf("%sPARSER built_in: | INSERT FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, buf, FMT_RESET);
                                                                    // nvalue* nv = (nvalue*)malloc(sizeof(nvalue));
                                                                    // nv->name = STRDUP($1);
                                                                    // nv->value = STRDUP(s);
                                                                    // $$=nv;
                                                                    // s = 0;
                                                                }
    | ASSIGN attributes                                         {
                                                                    printf("%sPARSER built_in: | INSERT FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, buf, FMT_RESET);
                                                                    // nvalue* nv = (nvalue*)malloc(sizeof(nvalue));
                                                                    // nv->name = STRDUP($1);
                                                                    // nv->value = STRDUP(s);
                                                                    // $$=nv;
                                                                    // s = 0;
                                                                }
                                                                ;

attributes:
    attribute                                                  {
                                                                    printf("%sPARSER attributes: | attribute={name=\"%s\"; value=\"%s\"}%s\n", FMT_FG_GREEN, $1->name, $1->value, FMT_RESET);
                                                                    // put attribute @ head position
                                                                    pnv_head = $1;
                                                                    $$ = pnv_head;
                                                               }
    | attributes attribute                                     {
                                                                    printf("%sPARSER attributes: | attributes attribute={name=\"%s\"; value=\"%s\"}%s\n", FMT_FG_GREEN, $2->name, $2->value, FMT_RESET);
                                                                    // put attribute @ head position
                                                                    // $2->next = pnv_head;
                                                                    // pnv_head = $2;
                                                                    // print attributes ...
                                                                    nvalue* cur = pnv_head;
                                                                    while(cur->next != 0)
                                                                    {
                                                                        printf("%sattribute={name=\"%s\"; value=\"%s\"}%s\n", FMT_FG_GREEN, cur->name, cur->value, FMT_RESET);
                                                                        cur = cur->next;
                                                                    }
                                                                    cur->next = $2;
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
    | FILE_ATTRIB EQUAL STRING_LITERAL                          {
                                                                    printf("%sPARSER name_value: | FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, buf, FMT_RESET);
                                                                    yyval.nval = alloc_nvalue($1, buf);
                                                                    $$ = yyval.nval;
                                                               }
                                                               ;

%%

#include "bash_color.h"

char* STRDUP(char* s)
{
    char* dup = (char*)malloc(strlen(s) + 1);
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

void free_nvalue(nvalue* nv)
{
    free(nv->name);
    free(nv->value);
    free(nv);
}

void free_all_nvalues()
{
    if(!pnv_head)
        return;

    nvalue* cur = pnv_head;
    nvalue* next = pnv_head->next;
    while(cur != 0)
    {
        free_nvalue(cur);
        cur = next;
        next = cur->next;
    }
}

int yyerror(char * s)
{
    fprintf(stderr, "%s\n", s);
    return 0;
};

int main(int argc, char** argv)
{
    extern FILE *yyin;
    for(int i = 1; i < argc; ++i)
    {
        yyin = fopen(argv[i], "r");
        if(!yyin)
            printf("error opening file: %s ...", argv[i]);


        printf("************************* RUN *************************\n");
        printf("* Terminate listing with ; to see parsed AST          *\n");
        printf("* Terminate parser with Ctrl-D ...                    *\n");
        printf("%s%s* parsing file=\"%s\"                       *%s\n", FMT_REVERSE, FMT_ITALIC, argv[i], FMT_RESET);
        printf("************************* Done ************************\n");

        yyparse();

        printf("%s%sclosing file=\"%s\"%s\n", FMT_ITALIC, FMT_FG_CYAN, argv[i], FMT_RESET);
        fclose(yyin);
        free(yyin);
        yyin = 0;

    }
    exit(0);
};
