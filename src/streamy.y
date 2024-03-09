/*
   File Name:  streamy.y
   Build Date: Wed Feb 14 12:02:37 AM CST 2024
   Version:    0.0.1
*/
%{
// %{ /* -*- C++ -*- */
// # include <cerrno>
// # include <climits>
// # include <cstdlib>
// # include <cstring> // strerror
// # include <string>
// # include "driver.hh"
// # include "parser.hh"
// %}%{ /* -*- C++ -*- */
# include <cerrno>
# include <climits>
# include <cstdlib>
# include <cstring> // strerror
# include <string>
// # include "driver.hh"
// # include "parser.hh"

%}

//#include <stdio.h>
#include "streamy.yy.h"

int fileno(char *);
void yyerror(char *);
int yylex(void);
extern void* pyyval;
char* argv[255];
char* str;

%}

//%type  escape
%token TEXT
%token NEWLINE
%token OPEN_BRACE
%token CLOSE_BRACE
//%token api.vakue.type SYMBOL
%define api.value.type {double}
%parse-param
%token SYMBOL

%%

program:
        program NEWLINE
        {
            printf("program %s\n", yytext );
            exit(0);
        }
        |
        escape
        {
            char* a[1];
            a[0]= YSYMBOL_YYEMPTY;
            printf("esc %s\n", yytext );
        }
        |
        html escape
        {
            $$ = $1;
            printf("html esc %s\n", yytext );
            //exit(0);
        }
        |
        escape html
        {
            printf("esc html %s\n", yytext );
        }
        ;%parse-param
escape:
        OPEN_BRACE SYMBOL CLOSE_BRACE
        {
            $$ = $1;
            yytext--;
            yytext--;
            yytext--;
            argv[0] = yytext;
            argv[1] = yytext;
            argv[2] = yytext;
            printf("v=%s", yytext);
            printf("OUT %s, %s", argv[0], argv[1]);
        }
        ;
html:
        TEXT
        {
            str = yytext;

            printf("HTML= %s\n", yytext);
        }
        |
        html TEXT
        {
            printf("PHT %s\n", yytext);
        }
        ;


%%

#include <stdio.h>
extern char* yytext;
extern int column;

void yyerror(char *s)
{
    fprintf(stderr, "line %d: %s\n", yylineno, s);
}

/* int main(int argc , char* argv[])
{
    if(argc < 2)
    {
        fprintf(stderr, "Missing filename paramter\n interactive mode");
        fprintf(stderr, "lex [OPTION]... [FilE]...\n");
        fprintf(stderr, "Interactive mode...\n");
    }

    // commnad line
    yyparse();
    return 0;
} */

/* int main(int argc , char* argv[])
{
    extern FILE *yyin;
    if(argc > 1)
    {
        if((yyin = fopen(argv[1], "r")) == NULL)
        {
            perror(argv[1]);
            exit(1);
        }
    }
    else
    {
        fprintf(stderr, "Missing filename paramter\n interactive mode");
        fprintf(stderr, "lex [OPTION]... [FilE]...\n");
        fprintf(stderr, "Interactive mode...\n");
    }
    yyparse();
}

void
driver::scan_begin ()
{
  yy_flex_debug = trace_scanning;
  if (file.empty () || file == "-")
    yyin = stdin;
  else if (!(yyin = fopen (file.c_str (), "r")))
    {
      std::cerr << "cannot open " << file << ": " << strerror (errno) << '\n';
      exit (EXIT_FAILURE);
    }
}

void
driver::scan_end ()
{
  fclose (yyin);
} */
