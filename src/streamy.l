/* streamy.l */
%option noyywrap
%x IFILE

%{
    #include <stdio.h>
    #include "streamy.tab.h"
    int yylex(void);
    void yyerror(char *);
    int TEXT_LITERAL;

    struct bufstack
    {
        struct bufstack *prev;
        YY_BUFFER_STATE bs;
        int lineno;
        char *filename;
        FILE *f;
    } *curbs = 0;

    /* previous entry */
    /* saved buffer */
    /* saved line number */
    /* name of this file */
    /* current file */

    char *curfilename;
    /* name of current input file */
    int newfile(char *fn);
    int popfile(void);
%}

DIGIT                       [0-9]
NUMBER                      [0-9]+
OPEN_CURLY                  "{"
CLOSE_CURLY                 "}"
OPEN_BRACE                  "["
CLOSE_BRACE                 "]"
OPEN_PAREN                  "("
CLOSE_PAREN                 ")"
LESS_THAN                   "<"
GREATER_THAN                "+"
MINUS                       "-"
MULTIPLY                    "*"
EXPONET                     "^"
FOREWARD_SLASH              "/"
BACKWARD_SLASH              "\\"
BAR                         "|"
HASH                        "#"
UNDERSCORE                  "_"
SEMI_COLON                  ";"
COLON                       ":"
AMPERSAND                   "&"
TILDE                       "~"
TICK_MARK                   "`"
AT_SYMBOL                   "@"
EXCLAMATION                 "!"
PERCENT                     "%"
COMMA                       ","
QUESTION                    "?"
DOLLAR_SIGN                 "$"
IF                          "if"
ELSE                        "else"
ELSE_IF                     "elseif"
FOREACH                     "foreach"
FOREACHELSE                 "foreachelse"
FILE                        "file"
VARIABLE                    "$"[a-zA-Z]+[a-zA-Z0-9]*
TEXT                        [a-zA-Z0-9]+[a-zA-Z0-9]*

%%

{OPEN_CURLY}                printf( "OPEN_CURLY: %s\n", yytext );
{CLOSE_CURLY}               printf( "CLOSE_CURLY: %s\n", yytext );
{OPEN_BRACE}                printf( "OPEN_BRACE: %s\n", yytext );
{CLOSE_BRACE}               printf( "CLOSE_BRACE: %s\n", yytext );
{OPEN_PAREN}                printf( "OPEN_PAREN: %s\n", yytext );
{CLOSE_PAREN}               printf( "CLOSE_PAREN: %s\n", yytext );
{LESS_THAN}                 printf( "LESS_THAN: %s\n", yytext );
{GREATER_THAN}              printf( "GREATER_THAN: %s\n", yytext );
{MINUS}                     printf( "MINUS: %s\n", yytext );
{MULTIPLY}                  printf( "MULTIPLY: %s\n", yytext );
{FOREWARD_SLASH}            printf( "FOREWARD_SLASH: %s\n", yytext );
{BACKWARD_SLASH}            printf( "BACKWARD_SLASH: %s\n", yytext );
{BAR}                       printf( "BAR: %s\n", yytext );
{HASH}                      printf( "HASH: %s\n", yytext );
{UNDERSCORE}                printf( "UNDERSCORE: %s\n", yytext );
{SEMI_COLON}                printf( "SEMI_COLON:", yytext );
{QUESTION}                  printf( "QUESTION: %s\n", yytext );
{DOLLAR_SIGN}               printf( "DOLLAR_SIGN: %s\n", yytext );
{NUMBER}                    printf( "NUMBER: %s\n", yytext );
{FILE}                      printf( "FILE: %s\n", yytext );
{IF}                        printf( "IF: %s\n", yytext );
{ELSE}                      printf( "ELSE: %s\n", yytext );
{ELSE_IF}                   printf( "ELSE_IF: %s\n", yytext );
{TEXT}                      printf( "TEXT: %s\n",  yytext );
[ \t\n]                     printf( "end line");
.                           printf( "Unrecognized character: %s\n", yytext );

%%

int main(int argc, char** argv)
{
    if(argc < 2)
    {
        fprintf(stderr, "need filename\n");
        return 1;
    }

    if(newfile(argv[1]))
        yylex();
}

int newfile(char* fn)
{
    FILE* f = fopen(fn, "r");
    struct bufstack* bs = (struct bufstack*)malloc(sizeof(struct bufstack));

    if(!f)
    {
        perror(f);
        return 0;
    }

    if(!bs)
    {
        perror("malloc");
        exit(1);
    }

    /* remember state */
    if(curbs)
        curbs->lineno = yylineno;

    bs->prev = curbs;
    bs->bs = yy_create_buffer(f, YY_BUF_SIZE);
    bs->f = f;
    bs->filename = fn;
    yy_switch_to_buffer(bs->bs);
    curbs = bs;
    yylineno = 1;
    curfilename = fn;

    return 1;
}

int popfile(void)
{
    struct bufstack *bs = curbs;
    struct bufstack *prevbs;

    if(!bs)
        return 1;

    /* get rid of current entry */
    fclose(bs->f);
    yy_delete_buffer(bs->bs);
    /* switch back to previous */
    prevbs = bs->prev;
    free(bs);

    if(!prevbs)
        return 1;

    yy_switch_to_buffer(prevbs->bs);
    curbs = prevbs;
    yylineno = curbs->lineno;
    curfilename = curbs->filename;
    return 1;
}