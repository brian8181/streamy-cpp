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
    #define VERBOSE

    typedef struct streamy
    {
        // _GET;
        // _POST;
        // _COOKIE;
        // _SERVER;
        // _ENV;
        // _SESSION;

        char* now;
        char* _const;
        char* capture;
        char* config;
        char* section;
        char* version;
        char* ldelim;
        char* rdelim;
    } streamy;
%}

%union
{
    int ival;
    char* sval;
    struct nvalue* nval;
};

%token END 0 _("end of input")
%type files file tag blocks
%type<nval> attribute built_in
%type<nval> attributes
%token<sval> NUMBER
%token<sval> DOLLAR_SIGN POUND_SIGN DOT INDIRECT_MEMBER
%token<sval> STRING_LITERAL NUMERIC_LITERAL
%token<sval> ID CONST_SYMBOL SYMBOL
%token<sval> FOREACH FOREACHELSE
%token<sval> LBRACE RBRACE LBRACKET RBRACKET LPAREN RPAREN
%token<sval> COLON SEMI_COLON QUOTE SINGLE_QUOTE SLASH BACK_SLASH AT VBAR AMPERSAND AND OR NOT
%token<sval> LESS_THAN LESS_THAN_EQUAL GREATER_THAN GREATER_THAN_EQUAL PLUS MINUS ASTERIK COMMA EQUAL PERCENT NOT_EQUAL
%token<sval> CAPTURE CONFIG_LOAD INCLUDE REQUIRE REQUIRE_ONCE INSERT ASSIGN ISSET SECTION LDELIM RDELIM VERSION CYCLE COUNTER CONFIG FUNC
%token<sval> CAPITALIZE CAT COUNT_CHARACTERS COUNT_SENTENCES COUNT_PARAGRAPHS COUNT_WORDS DATE_FORMAT DEFAULT ESCAPE
%token<sval> INDENT LOWER UPPER STRIP NL2BR REGEX_REPLACE REPLACE SPACIFY STRING_FORMAT STRIP_TAGS TRUNCATE WORDWARP
%token<sval> VAR_ATTRIB VALUE_ATTRIB FILE_ATTRIB FILE_NAME
%token<sval> FROM_ATTRIB ITEM_ATTRIB KEY_ATTRIB NAME_ATTRIB
%token END_OF_FILES
%type<sval> symbol sub_proc array qualafied_id modifier
%type end_if end_foreach

%token <iValue> INTEGER
%token <sIndex> VARIABLE
%token WHILE IF PRINT
%nonassoc IFX
%nonassoc ELSE ELSEIF
%left GE LE EQ NE '>' '<'
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS
%type <nPtr> expr stmt_list
%type<sval> stmt

%start complier

%%
complier:
    files                                                       {
                                                                    #ifdef VERBOSE
                                                                    WHITE("PARSER complier: | files\n");
                                                                    WHITE("*********************** STOPPING **********************\n");
                                                                    WHITE("*                     Terminating.                    *\n");
                                                                    WHITE("************************* Done ************************\n");
                                                                    #endif
                                                                    //exit(0);
                                                                }

files:
    file                                                        { GREEN("PARSER files: | file\n"); }
    | files file                                                { GREEN("PARSER files: | files file\n"); }

file:
    blocks END                                                  {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER file: | blocks END_OF_FILE\n");
                                                                    RED("*******************************************************\n");
                                                                    RED("*                      End Of File                    *\n");
                                                                    RED("*******************************************************\n");
                                                                    #endif
                                                                    //exit(0);

                                                                }
        ;

blocks:
    tag                                                         {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER blocks: | tag\n");
                                                                    #endif
                                                                }
    | blocks tag                                                {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER blocks: | blocks tag\n");
                                                                    #endif
                                                                }
                                                                ;

tag:
    LBRACE sub_proc RBRACE                                      {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER tag: | LBRACE sub_porc RBRACE\n");
                                                                    #endif
                                                                }
    | LBRACE array RBRACE                                       {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER tag: | LBRACE array RBRACE\n");
                                                                    #endif
                                                                }
    | LBRACE symbol VBAR modifier RBRACE                        {
                                                                    #ifdef VERBOSE
                                                                    printf("%sPARSER tag: | LBRACE symbol=%s VBAR modifier=%s RBRACE%s\n", FMT_FG_BLUE,  $2, $4, FMT_RESET);
                                                                    #endif
                                                                }
    | LBRACE symbol VBAR modifier colon_sep_params RBRACE       {
                                                                    #ifdef VERBOSE
                                                                    printf("%sPARSER tag: | LBRACE symbol=%s VBAR modifier=%s colon_sep_param RBRACE%s\n", FMT_FG_BLUE, $2, $4, FMT_RESET);
                                                                    #endif
                                                                }
    | LBRACE symbol RBRACE                                      {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER tag: | LBRACE symbol RBRACE\n");
                                                                    #endif
                                                                }
    | LBRACE qualafied_id RBRACE                                {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER tag: | LBRACE qualafied_id RBRACE\n");
                                                                    #endif
                                                                }
     | LBRACE built_in RBRACE                                   {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER tag: | LBRACE built_in RBRACE\n");
                                                                    #endif
                                                                    //free_all_nvalues();

                                                                    // do include !!
                                                                }
                                                                ;

program:
    function                                                    {  exit(0); }
    ;

function:
        function stmt                                           {  ex($2); freeNode($2); }
        | /* NULL */
        ;

stmt:                                                           {
                                                                        /*bkp todo*/
                                                                        /*{ <if ($x > 0)> ~todo: if block~ <else> ~todo: else block~ </if> }*/
                                                                }
        ';'                                                     { $$ = opr(';', 2, NULL, NULL); /*}*/ }
        | LBRACE expr RBRACE                                    { $$ = $1; }
        | LBRACE expr RBRACE                                    { $$ = opr(PRINT, 1, $2); }
        | LBRACE EQUAL expr RBRACE                              { $$ = opr('=', 2, id($1), $3); }
        | WHILE LPAREN expr RPAREN stmt                         { $$ = opr(WHILE, 2, $3, $5); }
        | LBRACE IF LPAREN expr RPAREN stmt %prec IFX RBRACE    { /*$$ = opr(IF, 2, $3, $5);*/ }
        | LBRACE IF LPAREN expr RPAREN stmt ELSE stmt RBRACE    { /*$$ = opr(IF, 3, $3, $5, $7);*/ }
        | LBRACE stmt_list RBRACE                               { $$ = $2; }
        ;

stmt_list:
        stmt                                                    { $$ = $1; }
        | stmt_list stmt                                        { $$ = opr(';', 2, $1, $2); }
        ;

expr:
        INTEGER                                                 { $$ = con($1); }
        | VARIABLE                                              { $$ = id($1); }
        | MINUS expr %prec UMINUS                               { $$ = opr(UMINUS, 1, $2); }
        | expr PLUS expr                                        { $$ = opr('+', 2, $1, $3); }
        | expr MINUS expr                                       { $$ = opr('-', 2, $1, $3); }
        | expr ASTERIK expr                                     { $$ = opr('*', 2, $1, $3); }
        | expr SLASH expr                                       { $$ = opr('/', 2, $1, $3); }
        | expr LESS_THAN expr                                   { $$ = opr('<', 2, $1, $3); }
        | expr GREATER_THAN expr                                { $$ = opr('>', 2, $1, $3); }
        | expr GREATER_THAN_EQUAL expr                          { $$ = opr(GE, 2, $1, $3); }
        | expr LESS_THAN_EQUAL expr                             { $$ = opr(LE, 2, $1, $3); }
        | expr NOT_EQUAL expr                                   { $$ = opr(NE, 2, $1, $3); }
        | expr EQUAL expr                                       { $$ = opr(EQ, 2, $1, $3); }
        | LPAREN expr RPAREN                                    { $$ = $2; }
        ;

colon_sep_params:
    colon_sep_param                                             {
                                                                    #ifdef VERBOSE
                                                                    GREEN("colon_sep_params: | colon_sep_param\n");
                                                                    #endif
                                                                }
    | colon_sep_params colon_sep_param
colon_sep_param:
    COLON NUMERIC_LITERAL                                       {
                                                                    #ifdef VERBOSE
                                                                    GREEN("colon_sep_param: | COLON NUMERIC_LITERAL\n");
                                                                    #endif
                                                                }

qualafied_id:
    symbol DOT ID                                               {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER qualafied_id: | symbol DOT ID\n");
                                                                    #endif
                                                                }
    | symbol DOT symbol                                         { RED("PARSER qualafied_id: | symbol DOT symbol\n"); }
    | symbol INDIRECT_MEMBER ID                                 {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER qualafied_id: | symbol INDIRECT_MEMBER ID\n");
                                                                    #endif
                                                                }
    | qualafied_id DOT ID                                       {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER qualafied_id: | qualafied_id DOT ID\n");
                                                                    #endif
                                                                }
    | qualafied_id INDIRECT_MEMBER ID                           {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER qualafied_id: | qualafied_id INDIRECT_MEMBER ID\n");
                                                                    #endif
                                                                }
                                                                ;

sub_proc:
    symbol LPAREN RPAREN                                        {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER sub_proc: | symbol LPAREN RPAREN\n");
                                                                    #endif
                                                                    $$=$1;
                                                                }
    | symbol LPAREN params RPAREN                               {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER sub_proc: | symbol LPAREN params RPAREN\n");
                                                                    #endif
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
    param                                                       {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER params: | param\n");
                                                                    #endif
                                                                }
    | params symbol                                             {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER qualafied_id: | params COMMA symbol\n");
                                                                    #endif
                                                                }
                                                                ;
param:
    symbol COMMA                                                {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER param: | symbol COMMA\n");
                                                                    #endif
                                                                }
                                                                ;

symbol:
    SYMBOL                                                      {
                                                                    #ifdef VERBOSE
                                                                    printf("%sPARSER symbol: | ID=\"%s\"\n", FMT_FG_GREEN, $1, FMT_RESET);
                                                                    #endif
                                                                    $$=$1;
                                                                }
    | CONST_SYMBOL                                              {
                                                                    #ifdef VERBOSE
                                                                    printf("%sPARSER symbol: | CONST_ID=\"%s\"\n", FMT_FG_GREEN, $1, FMT_RESET);
                                                                    #endif
                                                                    $$=$1;
                                                                }
                                                                ;

modifier:
    CAPITALIZE                                                 {
                                                                    #ifdef VERBOSE
                                                                    printf("PARSER modifier: | CAPITALIZE\n");
                                                                    #endif
                                                               }
    | CAT                                                      {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER modifier: | CAT\n");
                                                                    #endif
                                                               }
    | COUNT_CHARACTERS                                         {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER modifier: | COUNT_CHARACTERS\n");
                                                                    #endif
                                                               }
    | COUNT_SENTENCES                                          {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER modifier: | COUNT_SENTENCES\n");
                                                                    #endif
                                                               }
    | COUNT_PARAGRAPHS                                         {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER modifier: | COUNT_PARAGRAPHS\n");
                                                                    #endif
                                                                }
    | COUNT_WORDS                                              {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER modifier: | COUNT_WORDS\n");
                                                                    #endif
                                                                }
    | DATE_FORMAT                                              {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER modifier: | DATE_FORMAT\n");
                                                                    #endif
                                                                }
    | DEFAULT                                                  {
                                                                #ifdef VERBOSE
                                                                GREEN("PARSER modifier: | DEFAULT\n");
                                                                #endif
                                                            }
    | ESCAPE                                                {
                                                                #ifdef VERBOSE
                                                                GREEN("PARSER modifier: | ESCAPE\n");
                                                                #endif
                                                            }
    | INDENT                                                {
                                                                #ifdef VERBOSE
                                                                GREEN("PARSER modifier: | INDENT\n");
                                                                #endif
                                                            }
    | STRIP                                                 {
                                                                #ifdef VERBOSE
                                                                GREEN("PARSER modifier: | STRIPS\n");
                                                                #endif
                                                            }
    | NL2BR                                                 {
                                                                #ifdef VERBOSE
                                                                GREEN("PARSER modifier: | NL2BR\n");
                                                                #endif
                                                            }
    | REPLACE                                               {
                                                                #ifdef VERBOSE
                                                                GREEN("PARSER modifier: | REPLACE\n");
                                                                #endif
                                                            }
    | REGEX_REPLACE                                         {
                                                                #ifdef VERBOSE
                                                                GREEN("PARSER modifier: | REGEX_REPLACE\n");
                                                                #endif
                                                            }
    | SPACIFY                                               {
                                                                #ifdef VERBOSE
                                                                GREEN("PARSER modifier: | SPACIFY\n");
                                                                #endif
                                                            }
    | STRING_FORMAT                                         {
                                                                #ifdef VERBOSE
                                                                GREEN("PARSER modifier: | STRING_FORMAT\n");
                                                                #endif
                                                            }
    | STRIP_TAGS                                            {
                                                                #ifdef VERBOSE
                                                                GREEN("PARSER modifier: | STIP_TAGS\n");
                                                                #endif
                                                            }
    | TRUNCATE                                              {
                                                                #ifdef VERBOSE
                                                                GREEN("PARSER modifier: | TRUNCATE\n");
                                                                #endif
                                                            }
    | UPPER                                                 {
                                                                #ifdef VERBOSE
                                                                GREEN("PARSER modifier: | UPPER\n");
                                                                #endif
                                                            }
    | LOWER                                                 {
                                                                #ifdef VERBOSE
                                                                GREEN("PARSER modifier: | LOWER\n");
                                                                #endif
                                                            }
    | WORDWARP                                              {
                                                                #ifdef VERBOSE
                                                                GREEN("PARSER modifier: | WORDWRAP\n");
                                                                #endif
                                                            }
    ;

built_in:
    CONFIG_LOAD attributes                                      {
                                                                    printf("%sPARSER built_in: | CONFIG_LOAD FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, buf, FMT_RESET);
                                                                    nvalue* nv = (nvalue*)malloc(sizeof(nvalue));
                                                                    nv->name = STRDUP($1);
                                                                    nv->value = STRDUP(s);
                                                                    $$=nv;
                                                                    s = 0;
                                                                }
    | INCLUDE attributes                                       {
                                                                    printf("%sPARSER built_in: | INCLUDE FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, s, FMT_RESET);
                                                                    nvalue* nv = (nvalue*)malloc(sizeof(nvalue));
                                                                    nv->name = STRDUP($1);
                                                                    nv->value = STRDUP(s);
                                                                    $$=nv;
                                                                    s = 0;


                                                                }
    | REQUIRE attributes                                        {
                                                                    printf("%sPARSER built_in: | REQUIRE FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, s, FMT_RESET);
                                                                    nvalue* nv = (nvalue*)malloc(sizeof(nvalue));
                                                                    nv->name = STRDUP($1);
                                                                    nv->value = STRDUP(s);
                                                                    $$=nv;
                                                                    s = 0;
                                                                }
    | REQUIRE_ONCE attributes                                   {
                                                                    printf("%sPARSER built_in: | INSERT FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, s, FMT_RESET);
                                                                    // nvalue* nv = (nvalue*)malloc(sizeof(nvalue));
                                                                    // nv->name = STRDUP($1);
                                                                    // nv->value = STRDUP(s);
                                                                    // $$=nv;
                                                                    // s = 0;
                                                                }
    | INSERT attributes                                         {
                                                                    printf("%sPARSER built_in: | INSERT FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, s, FMT_RESET);
                                                                    // nvalue* nv = (nvalue*)malloc(sizeof(nvalue));
                                                                    // nv->name = STRDUP($1);
                                                                    // nv->value = STRDUP(s);
                                                                    // $$=nv;
                                                                    // s = 0;
                                                                }
    | ASSIGN attributes                                         {
                                                                    printf("%sPARSER built_in: | INSERT FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, s, FMT_RESET);
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
                                                                    printf("%sPARSER name_value: | VALUE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, s, FMT_RESET);
	                                                                yyval.nval = alloc_nvalue($1, s);
                                                                    $$ = yyval.nval;
                                                               }
    | VAR_ATTRIB EQUAL STRING_LITERAL                          {
                                                                    printf("%sPARSER name_value: | VAR_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, s, FMT_RESET);
                                                                    yyval.nval = alloc_nvalue($1, s);
                                                                    $$ = yyval.nval;
                                                               }
    | FILE_ATTRIB EQUAL STRING_LITERAL                          {
                                                                    printf("%sPARSER name_value: | FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, s, FMT_RESET);
                                                                    yyval.nval = alloc_nvalue($1, s);
                                                                    $$ = yyval.nval;
                                                               }
    | ITEM_ATTRIB EQUAL STRING_LITERAL                          {
                                                                    printf("%sPARSER name_value: | ITEM_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, s, FMT_RESET);
                                                                    yyval.nval = alloc_nvalue($1, s);
                                                                    $$ = yyval.nval;
                                                               }
    | FROM_ATTRIB EQUAL STRING_LITERAL                          {
                                                                    printf("%sPARSER name_value: | FROM_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, s, FMT_RESET);
                                                                    yyval.nval = alloc_nvalue($1, s);
                                                                    $$ = yyval.nval;
                                                               }
    | KEY_ATTRIB EQUAL STRING_LITERAL                          {
                                                                    printf("%sPARSER name_value: | KEY_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, s, FMT_RESET);
                                                                    yyval.nval = alloc_nvalue($1, s);
                                                                    $$ = yyval.nval;
                                                               }
    | NAME_ATTRIB EQUAL STRING_LITERAL                          {
                                                                    printf("%sPARSER name_value: | NAME_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, s, FMT_RESET);
                                                                    yyval.nval = alloc_nvalue($1, s);
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
    //todo
    //fprintf(stderr, "line %d: %s\n", yylineno, s);
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
        printf("************************* Done ************************\n");

        printf("%s%s\nparsing file=\"%s\"*%s\n\n", FMT_ITALIC, FMT_FG_BLUE, argv[i], FMT_RESET);

        yyparse();

        printf("%s%s\nclosing file=\"%s\"%s\n\n", FMT_ITALIC, FMT_FG_BLUE, argv[i], FMT_RESET);
        fclose(yyin);
        free(yyin);
        yyin = 0;

    }
    exit(0);
};
