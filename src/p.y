%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "bash_color.h"
    #include "p.tab.h"
    #include "symtab.h"

    extern int yylex();
    extern int yywrap();

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


%token<sval> LBRACE RBRACE LBRACKET RBRACKET LPAREN RPAREN
%token<sval> COLON SEMI_COLON QUOTE SINGLE_QUOTE BACK_SLASH

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
%type<sval> token
%start interpreter

%%


interpreter:
            '\n'                               {}
                                                                    ;


token:
    SYMBOL                                                  { printf("FOOO"); }
    | RBRACE                                                { GREEN("PARSER token: | RBRACE\n"); }
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
    //printf("%s\n", s);
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
        while(yylex());
        yyparse();

        printf("%s%s\nclosing file=\"%s\"%s\n\n", FMT_ITALIC, FMT_FG_BLUE, argv[i], FMT_RESET);
        fclose(yyin);
        free(yyin);
        yyin = 0;

    }
    exit(0);
};
