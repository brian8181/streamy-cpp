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
    int newfile(char *fn);
    int popfile(void);


    #define YYERROR(str) yyerror("%s\n", str);
    // extern char *yytext;
    // extern int yyleng;
    // extern int yylineno;
    // int yylex(void);
    // void yyerror(char *);
    //extern YYSTYPE yylval;
     int fileno(FILE *);

    //YYSTYPE yylval;
    void* pyyval;
    char* lex_text[256];
%}

OPEN_BRACE                  "{"
CLOSE_BRACE                 "}"

%%

[0-9]                       { printf("TEXT: %s\n", yytext ); return TEXT; }
\n                          { printf("NEWLINE: %s\n", yytext ); return NEWLINE; }
.                           { printf("error: %s\n", yytext ); }


%%

/* int yywrap()
{
    return 1;
}

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
} */

int column;

int buffer_size;

void count()
{
	int i;

	for (i = 0; yytext[i] != '\0'; i++)
		if (yytext[i] == '\n')
			column = 0;
		else if (yytext[i] == '\t')
			column += 8 - (column % 8);
		else
			column++;

	ECHO;
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