%{
    int yylex(void);
    int yyerror(char* s);
%}

ID \$_*[A-Za-z][A-Za-z0-9_]*
IF  if
END_IF "{/if}"

%x ESCAPED
%x IF_BLOCK
%x IF_CONDITION
%%

[{]                     { printf("\n'**{ "); BEGIN ESCAPED; }
<ESCAPED>{IF}           { printf(" [ID:%s] ", yytext); BEGIN IF_CONDITION; }
<IF_CONDITION>[^}]      {  ECHO; }
<IF_CONDITION>[}]       { printf("IF_BLOCK"); ECHO; BEGIN IF_BLOCK; }
<IF_BLOCK>[^{]          { ECHO; }
<IF_BLOCK>{END_IF}      { printf("END_IF"); printf(" }**'\n"); BEGIN INITIAL; }
<ESCAPED>[}]            { printf(" }**'\n"); BEGIN INITIAL; }
<*>"//"[^\n]*   /* eat up one-line comments */

%%

int yywrap(void)
{
    return 1;
}

int yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
    return 0;
};

int main(int argc, char** argv)
{
    if(argc < 2)
    {
        /* just read stdin */
        yylex();
        return 0;
    }
    for(int i = 1; i < argc; i++)
    {
        FILE *f = fopen(argv[i], "r");
        if(!f)
        {
            perror(argv[i]);
            return (1);
        }
        yyrestart(f);
        yylex();
        fclose(f);
    }
    return 0;
}
