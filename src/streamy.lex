/*
   File Name:  streamy.l
   Build Date: Wed Feb 14 12:02:37 AM CST 2024
   Version:    0.0.1
*/
%{
    #include <string.h>
    #include <stdlib.h>
    #include <stdio.h>
    #include "streamy.tab.h"

    // #include <stdio.h>
    // #include "y.tab.h"

    void count();

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
    // int newfile(char *fn);
    // int popfile(void);


    // #define YYERROR(str) yyerror("%s\n", str);
    // extern char *yytext;
    // extern int yyleng;
    // extern int yylineno;
    // int yylex(void);
    // void yyerror(char *);
    // extern YYSTYPE yylval;
    int fileno(FILE *);

    //YYSTYPE yylval;
    // void* pyyval;
    // char* lex_text[256];
%}

OPEN_BRACE                  "{"
CLOSE_BRACE                 "}"
SYMBOL                       "$"[A-Z]
TEXT                         [^{]

%%

{OPEN_BRACE}                {
                                //rintf("OPEN_BRACE: %s\n", yytext );
                                // yyless(yyleng-1); /* return last quote */
                                // yymore();
                                return OPEN_BRACE;
                            }
{CLOSE_BRACE}               {
                                //printf("CLOSE_BRACE: %s\n", yytext );
                                yyless(yyleng-1); /* return last quote */
                                yymore();
                                return CLOSE_BRACE;
                            }
{TEXT}                      {
                                //printf("TEXT: %s\n", yytext );
                                return TEXT;
                            }
{SYMBOL}                      {
                                //printf("SYMBOL: %s\n", yytext );
                                return SYMBOL;
                            }
\n                          { printf("NEWLINE: %s\n", yytext ); return NEWLINE; }
.                           { printf("error: %s\n", yytext ); }


%%


int yywrap()
{
    return 1;
}

/* int main(int argc, char** argv)
{
    if(argc < 2)
    {
        fprintf(stderr, "need filename\n");
        return 1;
    }

    if(newfile(argv[1]))
        yylex();
} */
