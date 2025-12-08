%{
    int yylex(void);
    int yyerror(char* s);
%}

IDENTIFIER      _*[A-Za-z][A-Za-z0-9_]*
ID              \${IDENTIFIER}
CONST_ID        #{IDENTIFIER}#
QUALAFIED_ID    {ID}\("."|"->"\){IDENTIFIER}
COLON           ":"
FUNCTION        {IDENTIFIER}[ /t]?(.*)
BAR                         "|"
PLUS                        "+"
MINUS                       "-"
MULTIPLY                    "*"
COMMENT                     <*>"\/\/"[^\n]*

%x ESCAPED
%%

[{]             { printf("\n'**{ "); BEGIN ESCAPED; }
<ESCAPED>{COLON}      { ECHO; }
<ESCAPED>{FUNCTION}   { ECHO; }
<ESCAPED>{BAR}        { ECHO; }
<ESCAPED>{PLUS}       { ECHO; }
<ESCAPED>{MINUS}      { ECHO; }
<ESCAPED>{MULTIPLY}   { ECHO; }
<ESCAPED>[}]            { printf(" }**'\n"); BEGIN INITIAL; }
<ESCAPED>{CONST_ID}     { printf(" [CONST_ID:%s] ", yytext); }
<ESCAPED>{ID}           { printf(" [ID:%s] ", yytext); }
<ESCAPED>{QUALAFIED_ID} { printf(" [QUALAFIED_ID:%s] ", yytext); }

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
