/*
   File Name:  streamy.l
   Build Date: Wed Feb 14 12:02:37 AM CST 2024
   Version:    0.0.1
*/
%option noyywrap
%x IFILE

%{
    #include <stdio.h>
    #include "streamy.tab.h"


    #define YYERROR(str) yyerror("%s\n", str);

    extern char *yytext;
    extern int yyleng;
    extern int yylineno;

    int yylex(void);
    void yyerror(char *);
    int fileno(FILE *);
    
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

INCLUDE                     ^"#"[ \t]*include[ \t]*[\"<]
DOT                         "."
NUMBER                      [0-9]+
DIGIT                       [0-9]
OPEN_BRACE                  "{"
CLOSE_BRACE                 "}"
OPEN_BRACKET                "["
CLOSE_BRACKET               "]"
OPEN_PAREN                  "("
CLOSE_PAREN                 ")"
DOUBLE_QUOTE                "\""
SINGLE_QUOTE                "'"
EQUALS                      "=="
LESS_THAN_EQUALS            "<="
GREATER_THAN_EQUALS         ">="
ASSIGNMENT                  "="
LESS_THAN                   "<"
GREATER_THAN                ">"
PLUS                        "+"
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

{INCLUDE}                   printf( "INCLUDE: %s\n", yytext );
{DOT}                       printf( "DOT: %s\n", yytext );
{NUMBER}                    printf( "NUMBER: %s\n", yytext );
{OPEN_BRACE}                printf( "OPEN_BRACE: %s\n", yytext );
{CLOSE_BRACE}               printf( "CLOSE_BRACE: %s\n", yytext );
{OPEN_BRACKET}              printf( "OPEN_BRACKET: %s\n", yytext );
{CLOSE_BRACKET}             printf( "CLOSE_BRACKET: %s\n", yytext );
{OPEN_PAREN}                printf( "OPEN_PAREN: %s\n", yytext );
{CLOSE_PAREN}               printf( "CLOSE_PAREN: %s\n", yytext );
{DOUBLE_QUOTE}              printf( "DOUBLE_QUOTE: %s\n", yytext );
{SINGLE_QUOTE}              printf( "SINGLE_QUOTE: %s\n", yytext );
{EQUALS}                    printf( "EQUALS: %s\n", yytext );
{LESS_THAN_EQUALS}          printf( "LESS_THAN_EQUALS: %s\n", yytext );
{GREATER_THAN_EQUALS}       printf( "GREATER_THAN_EQUALS: %s\n", yytext );
{ASSIGNMENT}                printf( "ASSIGNMENT: %s\n", yytext );
{LESS_THAN}                 printf( "LESS_THAN: %s\n", yytext );
{GREATER_THAN}              printf( "GREATER_THAN: %s\n", yytext );
{PLUS}                      printf( "PLUS: %s\n", yytext );
{MINUS}                     printf( "MINUS: %s\n", yytext );
{MULTIPLY}                  printf( "MULTIPLY: %s\n", yytext );
{EXPONET}                   printf( "EXPONET: %s\n", yytext );
{FOREWARD_SLASH}            printf( "FOREWARD_SLASH: %s\n", yytext );
{BACKWARD_SLASH}            printf( "BACKWARD_SLASH: %s\n", yytext );
{BAR}                       printf( "BAR: %s\n", yytext );
{HASH}                      printf( "HASH: %s\n", yytext );
{UNDERSCORE}                printf( "UNDERSCORE: %s\n", yytext );
{SEMI_COLON}                printf( "SEMI_COLON: %s\n", yytext );
{COLON}                     printf( "COLON: %s\n", yytext );
{AMPERSAND}                 printf( "AMPERSAND: %s\n", yytext );
{TILDE}                     printf( "TILDE: %s\n", yytext );
{TICK_MARK}                 printf( "TICK_MARK: %s\n", yytext );
{AT_SYMBOL}                 printf( "AT_SYMBOL: %s\n", yytext );
{EXCLAMATION}               printf( "EXCLAMATION: %s\n", yytext );
{PERCENT}                   printf( "PERCENT: %s\n", yytext );
{COMMA}                     printf( "COMMA: %s\n", yytext );
{QUESTION}                  printf( "QUESTION: %s\n", yytext );
{DOLLAR_SIGN}               printf( "DOLLAR_SIGN: %s\n", yytext );
{IF}                        printf( "IF: %s\n", yytext );
{ELSE}                      printf( "ELSE: %s\n", yytext );
{ELSE_IF}                   printf( "ELSE_IF: %s\n", yytext );
{FILE}                      printf( "FILE: %s\n", yytext );
{VARIABLE}                  printf( "VARIABLE: %s\n", yytext );
{TEXT}                      printf( "TEXT: %s\n",  yytext );
[ \t\n]                     printf( "END_LINE\n"  );
.                           printf( "Unrecognized character: %s\n", yytext );

%%

int main(int argc, char** argv)
{
    if(argc < 2)
    {
        fprintf(stderr, "Error: missing paramter\n");
        fprintf(stderr, "lex [OPTION]... [FilE]...\n");
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
        perror(0);
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