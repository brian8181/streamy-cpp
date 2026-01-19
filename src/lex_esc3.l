%{
    int yylex(void);
    int yyerror(char* s);

#define LBRACKET 1
#define RBRACKET 2
#define NUMBER 3

%}

IDENTIFIER      _*[A-Za-z][A-Za-z0-9_]*
ID              \${IDENTIFIER}
CONST_ID        #{IDENTIFIER}#
QUALAFIED_ID    {ID}(("."|"->"){IDENTIFIER})+
LBRACKET        "["
RBRACKET        "]"
LPAREN          "("
RPAREN          ")"
SEMI_COLON     ";"
VBAR            "|"
COLON           ":"
QUOTE          "\""
SINGLE_QUOTE   "'"
NUMBER          [0-9]*
COMMENT         \{[ \t]*\*[^*}]*\*[ \t]*\}

%x ESCAPED
%%

{COMMENT}                { /* eat up comment */ }
[{]                      { printf("'{ "); BEGIN ESCAPED; }
<ESCAPED>[}]             { printf(" }'"); BEGIN INITIAL; }
<ESCAPED>{QUALAFIED_ID}  { printf(" [QUALAFIED_ID:%s] ", yytext); }
<ESCAPED>{CONST_ID}      { printf(" [CONST_ID:%s] ", yytext); }
<ESCAPED>{ID}            { printf(" [ID:%s] ", yytext); }
<ESCAPED>{LBRACKET}      { printf(" [ID:%s] ", yytext); return LBRACKET; }
<ESCAPED>{RBRACKET}      { printf(" [ID:%s] ", yytext); return RBRACKET; }
<ESCAPED>{NUMBER}      { printf(" [ID:%s] ", yytext); return NUMBER; }
<*>.                      {  }
<*>\n                       { ECHO; }

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
