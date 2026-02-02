%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "bash_color.h"
    #include "parser.tab.h"
    #include "symtab.h"

    extern int yylex();
    extern void yywrap();
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

%{

#ifdef DEBUG
int dbgToken(int tok, char *s)
{
    printf("token %s\n", s);
    return tok;
}
int dbgTokenIvalue(int tok, char *s)
{
    printf("token %s (%d)\n", s, yylval.ival);
    return tok;
}

#define RETURN(x) return dbgToken(x, #x)
#define RETURN_ivalue(x) return dbgTokenIvalue(x, #x)
#else
#define RETURN(x) return(x)
#define RETURN_ivalue(x) return(x)
#endif

%}

%union
{
    int ival;
    char* sval;
    struct nvalue* nval;
};


%token<sval> RBRACE LBRACKET RBRACKET LPAREN RPAREN
%token<sval> COLON SEMI_COLON QUOTE SINGLE_QUOTE BACK_SLASH
%token<sval> AT VBAR AMPERSAND AND OR NOT DOLLAR_SIGN POUND_SIGN DOT

%token<sval> CAPTURE CONFIG_LOAD INCLUDE REQUIRE REQUIRE_ONCE INSERT ASSIGN ISSET SECTION LDELIM RDELIM VERSION CYCLE COUNTER
%token<sval> CAPITALIZE CAT COUNT_CHARACTERS COUNT_SENTENCES COUNT_PARAGRAPHS COUNT_WORDS DATE_FORMAT DEFAULT ESCAPE
%token<sval> INDENT LOWER UPPER STRIP NL2BR REGEX_REPLACE REPLACE SPACIFY STRING_FORMAT STRIP_TAGS TRUNCATE WORDWARP

%token<sval> VAR_ATTRIB VALUE_ATTRIB FILE_ATTRIB FILE_NAME
%token<sval> FROM_ATTRIB ITEM_ATTRIB KEY_ATTRIB NAME_ATTRIB
%token<sval> INDIRECT_MEMBER
%token<sval> ID CONST_SYMBOL SYMBOL
%token<sval> STRING_LITERAL NUMERIC_LITERAL
%token<sval> UNESCAPED_TEXT

%type<sval> symbol sub_proc array qualafied_id modifier
%type<sval> expr stmt
%type<sval> file files block blocks
%type<nval> attributes attribute built_in

%token WHILE IF PRINT FOREACH FOREACHELSE
%nonassoc IFX
%nonassoc ELSE ELSEIF
%left GREATER_THAN_EQUAL LESS_THAN_EQUAL EQUAL NOT_EQUAL LESS_THAN GREATER_THAN COMMA
%left PLUS MINUS
%left ASTERIK SLASH PERCENT
%nonassoc UMINUS

%token END 0 _("end of input")
%token END_OF_FILES
%start interpreter

%%

/*
*   interpreter ( the one and only start object )
*/
interpreter:
    files RBRACE
    | END_OF_FILES                                          {
                                                                    //#ifdef VERBOSE
                                                                    WHITE("PARSER complier: | files\n");
                                                                    WHITE("*********************** STOPPING **********************\n");
                                                                    WHITE("*                     Terminating.                    *\n");
                                                                    WHITE("************************* Done ************************\n");
                                                                    //#endif
                                                                    //exit(0);
                                                                }
                                                                ;

/*
*   files ( all files )
*/
files:
    SYMBOL                                                        { GREEN("PARSER files: | SYMBOL\n"); }
    | file                                                        { GREEN("PARSER files: | file\n"); }
    | files files                                                { GREEN("PARSER files: | files files\n"); }
                                                                ;

/*
*   file ( a single file )
*/
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

/*
*   blocks
*/
blocks:
    blocks block                                                {}
                                                                ;

/*
*   block ( between tags i.e. {if} block ... {/if}
*/
block:
     stmt                                                      {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER blocks: | stmts\n");
                                                                    #endif
                                                                }
    | UNESCAPED_TEXT                                            {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER block: | UNESCAPED_TEXT\n");
                                                                    #endif
                                                                }
                                                                ;

/*
*  { <if ($x > 0)> ~todo: if block~ <else> ~todo: else block~ </if> }
*   stmt ( 'if(%x < 1}' }
*   stmt expr }
*/
stmt:
     expr RBRACE                                          {
                                                                    /*$$ = opr(PRINT, 1, $2);          */
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER tag: | expr RBRACE\n");
                                                                    #endif
                                                        }
    | EQUAL expr RBRACE                                  {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER tag: | EQUAL expr RBRACE\n");
                                                                    #endif
                                                                }
    | WHILE LPAREN expr RPAREN stmt                             {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER tag: | WHILE LPAREN expr RPAREN stmt\n");
                                                                    #endif
                                                                }
     | IF LPAREN expr %prec IFX RPAREN                   {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER tag TEST: | IF LPAREN expr prec IFX RPAREN\n");
                                                                    #endif
                                                                }
    | IF LPAREN expr RPAREN stmt %prec IFX SLASH IF RBRACE        {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER tag: | IF LPAREN expr RPAREN stmt prec IFX RBRACE\n");
                                                                    #endif
                                                                }
    | SLASH IF RBRACE                                           {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER tag: | IF LPAREN expr RPAREN stmt ELSE stmt RBRACE\n");
                                                                    #endif
                                                                }

    | IF LPAREN expr RPAREN stmt ELSE stmt RBRACE        {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER tag: | IF LPAREN expr RPAREN stmt ELSE stmt RBRACE\n");
                                                                    #endif
                                                                }
    | sub_proc RBRACE                                    {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER tag: | sub_porc RBRACE\n");
                                                                    #endif
                                                                }
    | array RBRACE                                       {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER tag: | array RBRACE\n");
                                                                    #endif
                                                                }
    | expr VBAR modifier RBRACE                        {
                                                                    #ifdef VERBOSE
                                                                    printf("%sPARSER tag: | symbol=%s VBAR modifier=%s RBRACE%s\n", FMT_FG_BLUE,  $1, $3, FMT_RESET);
                                                                    #endif
                                                                }
    | symbol VBAR modifier colon_sep_params RBRACE       {
                                                                    #ifdef VERBOSE
                                                                    printf("%sPARSER tag: | symbol=%s VBAR modifier=%s colon_sep_param RBRACE%s\n", FMT_FG_BLUE, $1, $3, FMT_RESET);
                                                                    #endif
                                                                }
    | symbol RBRACE                                             {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER tag: | symbol RBRACE\n");
                                                                    #endif
                                                                }
    | qualafied_id RBRACE                                       {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER tag: | qualafied_id RBRACE\n");
                                                                    #endif
                                                                }
     | built_in RBRACE                                          {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER tag: | built_in RBRACE\n");
                                                                    #endif
                                                                    // bkp todo include !!
                                                                }
                                                                ;


/*
*   Numerical / logical exprssions
*/
expr:
        NUMERIC_LITERAL                                         {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER expr: | NUMERIC_LITERAL\n");
                                                                    #endif
                                                                }
        | STRING_LITERAL                                        {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER expr: | STRING_LITERAL\n");
                                                                    #endif
                                                                }
        | symbol                                                {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER expr: | symbol\n");
                                                                    #endif
                                                                }
        | symbol LESS_THAN NUMERIC_LITERAL                                        {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER expr: | symbol LESS_THAN NUMERIC_LITERAL\n");
                                                                    #endif
                                                                }
        | MINUS expr %prec UMINUS                               {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER expr: | expr\n");
                                                                    #endif
                                                                }
        | expr PLUS expr                                        {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER expr: | expr\n");
                                                                    #endif
                                                                }
        | expr MINUS expr                                       {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER expr: | expr\n");
                                                                    #endif
                                                                }
        | expr ASTERIK expr                                     {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER expr: | expr\n");
                                                                    #endif
                                                                }
        | expr SLASH expr                                       {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER expr: | expr\n");
                                                                    #endif
                                                                }
        | expr LESS_THAN expr                                   {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER expr: | expr\n");
                                                                    #endif
                                                                }
        | expr GREATER_THAN expr                                {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER expr: | expr\n");
                                                                    #endif
                                                                }
        | expr GREATER_THAN_EQUAL expr                          {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER expr: | expr\n");
                                                                    #endif
                                                                }
        | expr LESS_THAN_EQUAL expr                             {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER expr: | expr\n");
                                                                    #endif
                                                                }
        | expr NOT_EQUAL expr                                   {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER expr: | expr\n");
                                                                    #endif
                                                                }
        | expr EQUAL expr                                       {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER expr: | expr\n");
                                                                    #endif
                                                                }
        | LPAREN expr RPAREN                                    {
                                                                    #ifdef VERBOSE
                                                                    RED("PARSER expr: | expr\n");
                                                                    #endif
                                                                }
                                                                ;

/*
*   ( $x:$y:$x ) | 1:2:"three"
*/
colon_sep_params:
        colon_sep_param                                         {
                                                                    #ifdef VERBOSE
                                                                    GREEN("colon_sep_params: | colon_sep_param\n");
                                                                    #endif
                                                                }
        | colon_sep_params colon_sep_param                      {
                                                                    #ifdef VERBOSE
                                                                    GREEN("colon_sep_params: | colon_sep_params colon_sep_param\n");
                                                                    #endif
                                                                }
                                                                ;


/*
*   colon seperated param {$x|trim:3:' '}
*/
colon_sep_param:
        COLON NUMERIC_LITERAL                                         {
                                                                    #ifdef VERBOSE
                                                                    GREEN("colon_sep_param: | COLON NUMERIC_LITERAL\n");
                                                                    #endif
                                                                }

/*
*   qualafied id ( $obj.x | $obj.point->x )
*/
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

/*
*   sub procedure / function
*/
sub_proc:
        symbol LPAREN RPAREN                                    {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER sub_proc: | symbol LPAREN RPAREN\n");
                                                                    #endif
                                                                    //$$=$1;
                                                                }
        | symbol LPAREN params RPAREN                           {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER sub_proc: | symbol LPAREN params RPAREN\n");
                                                                    #endif
                                                                    //$$=$1;
                                                                }
                                                                ;
/*
*   array
*/
array:
       symbol LBRACKET NUMERIC_LITERAL RBRACKET                 {
                                                                    printf("%sPARSER array: | symbol=\"%s\" LBRACKET NUMERIC_LITERAL=\"%s\" RBRACKET%s\n", FMT_FG_GREEN, $1, $3, FMT_RESET);
                                                                    $$=$1;
                                                                }
                                                                ;

/*
*   params (i.e. $x, $y, $x)
*/
params:
        param                                                   {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER params: | param\n");
                                                                    #endif
                                                                }
        | params symbol                                         {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER qualafied_id: | params COMMA symbol\n");
                                                                    #endif
                                                                }
                                                                ;
/*
*   param (i.e. $x, )
*/
param:
        symbol COMMA                                            {
                                                                    #ifdef VERBOSE
                                                                    GREEN("PARSER param: | symbol COMMA\n");
                                                                    #endif
                                                                }
                                                                ;

/*
*   param $<name> ('$x')
*/
symbol:
       SYMBOL                                                   {
                                                                    #ifdef VERBOSE
                                                                    printf("%sPARSER symbol: | ID=\"%s\"\n", FMT_FG_GREEN, $1, FMT_RESET);
                                                                    #endif
                                                                    $$=$1;
                                                                }
        | CONST_SYMBOL                                          {
                                                                    #ifdef VERBOSE
                                                                    printf("%sPARSER symbol: | CONST_ID=\"%s\"\n", FMT_FG_GREEN, $1, FMT_RESET);
                                                                    #endif
                                                                    $$=$1;
                                                                }
                                                                ;

/*
*   param modifier
*/
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

/*
*   built_in functions
*/
built_in:
    CONFIG_LOAD attributes                                      {
                                                                    // printf("%sPARSER built_in: | CONFIG_LOAD FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, buf, FMT_RESET);
                                                                    // nvalue* nv = (nvalue*)malloc(sizeof(nvalue));
                                                                    // nv->name = STRDUP($1);
                                                                    // nv->value = STRDUP(s);
                                                                    // $$=nv;
                                                                    // s = 0;
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

/*
*   the attributes
*/
attributes:
      attribute                                                {
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

/*
*   an attribute
*/
attribute:
       VALUE_ATTRIB EQUAL STRING_LITERAL                       {
                                                                    printf("%sPARSER name_value: | VALUE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, s, FMT_RESET);
	                                                                yyval.nval = alloc_nvalue($1, s);
                                                                    $$ = yyval.nval;
                                                               }
        | VAR_ATTRIB EQUAL STRING_LITERAL                      {
                                                                    printf("%sPARSER name_value: | VAR_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, s, FMT_RESET);
                                                                    yyval.nval = alloc_nvalue($1, s);
                                                                    $$ = yyval.nval;
                                                               }
        | FILE_ATTRIB EQUAL STRING_LITERAL                     {
                                                                    printf("%sPARSER name_value: | FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, s, FMT_RESET);
                                                                    yyval.nval = alloc_nvalue($1, s);
                                                                    $$ = yyval.nval;
                                                               }
        | ITEM_ATTRIB EQUAL STRING_LITERAL                     {
                                                                    printf("%sPARSER name_value: | ITEM_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, s, FMT_RESET);
                                                                    yyval.nval = alloc_nvalue($1, s);
                                                                    $$ = yyval.nval;
                                                               }
        | FROM_ATTRIB EQUAL STRING_LITERAL                      {
                                                                    printf("%sPARSER name_value: | FROM_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, s, FMT_RESET);
                                                                    yyval.nval = alloc_nvalue($1, s);
                                                                    $$ = yyval.nval;
                                                               }
        | KEY_ATTRIB EQUAL STRING_LITERAL                       {
                                                                    printf("%sPARSER name_value: | KEY_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"%s\"%s\n", FMT_FG_GREEN, $1, s, FMT_RESET);
                                                                    yyval.nval = alloc_nvalue($1, s);
                                                                    $$ = yyval.nval;
                                                               }
        | NAME_ATTRIB EQUAL STRING_LITERAL                     {
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
    // bkp todo
    //fprintf(stderr, "line %d: %s\n", yylineno, s);
    printf("%s\n", s);
    return 0;
};

extern int yy_flex_debug;
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

        //yy_flex_debug = 1;
        yyparse();

        printf("%s%s\nclosing file=\"%s\"%s\n\n", FMT_ITALIC, FMT_FG_BLUE, argv[i], FMT_RESET);
        fclose(yyin);
        free(yyin);
        yyin = 0;

    }
    exit(0);
};
