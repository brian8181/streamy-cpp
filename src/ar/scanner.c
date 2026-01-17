#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "scanner.h"
#include "parser.tab.h"


int include_stack_ptr = 0;
int yylex(void);
int yyerror(char* s);
//int fileno(FILE* f);

extern char buf[100];
extern char *s;
char* STRDUP(char* str);


int yylex()
{
    return SYMBOL;
}

int yywrap(void)
{
    return 1;
}

// int yyerror(char *s)
// {
//     fprintf(stderr, "%s\n", s);
//     return 0;
// };

// char* STRDUP(char* s)
// {
//     char* dup = (char*)malloc((strlen(s) * sizeof(char)) + 1);
//     strcpy(dup, s);
//     return dup;
// }

// int main(int argc, char** argv)
// {
//     if(argc < 2)
//     {
//         /* just read stdin */
//         yylex();
//         return 0;
//     }
//     for(int i = 1; i < argc; i++)
//     {
//         FILE *f = fopen(argv[i], "r");
//         if(!f)
//         {
//             perror(argv[i]);
//             return (1);
//         }
//         //yyrestart(f);
//         yylex();
//         fclose(f);
//     }
//     return 0;
// }
