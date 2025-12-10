%{
    int yylex(void);
    int yyerror(char* s);

#define LBRACKET 1
#define RBRACKET 2
#define NUMBER 3
#define IF    4
#define ELSE  5

%}

IDENTIFIER      _*[A-Za-z][A-Za-z0-9_]*
ID              \${IDENTIFIER}
CONST_ID        #{IDENTIFIER}#
QUALAFIED_ID    {ID}(("."|"->"){IDENTIFIER})+
FUNCTION        {IDENTIFIER}(("."|"->"){IDENTIFIER})*[ /t]?\([^)]*\)
ARRAY           {ID}\[[^\]]\]
COMMENT         \{[ \t]*\*[^*}]*\*[ \t]*\}
IF              if
ELSE            else
STREAM          .|\n
VBAR            "|"
COLON           ":"
LBRACKET        "["
RBRACKET        "]"
LPAREN          "("
RPAREN          ")"
SEMI_COLON     ";"
QUOTE          "\""
SINGLE_QUOTE   "'"
NUMBER          [0-9]*

%x ESCAPED
%x IF_BLOCK
%%

{COMMENT}                               { /* eat up comment */ }
[{]                                     { printf("'{ "); BEGIN ESCAPED; }
<ESCAPED,IF_BLOCK>{VBAR}                { printf(" VBAR "); }
<ESCAPED,IF_BLOCK>{COLON}               { printf(" COLON "); }
<ESCAPED,IF_BLOCK>{LBRACKET}            { printf(" LBRACKET "); }
<ESCAPED,IF_BLOCK>{RBRACKET}            { printf(" RBRACKET "); }
<ESCAPED,IF_BLOCK>{LPAREN}              { printf(" LPAREN "); }
<ESCAPED,IF_BLOCK>{RPAREN}              { printf(" RPAREN "); }
<ESCAPED>{IF}                           { printf("IF_BLOCK"); BEGIN IF_BLOCK; }
<ESCAPED>{ELSE}                         { printf("ELSE_BLOCK"); BEGIN IF_BLOCK; }
<ESCAPED,IF_BLOCK>{SEMI_COLON}          { printf(" SEMI_COLON "); }
<ESCAPED,IF_BLOCK>{QUOTE}               { printf(" QUOTE "); }
<ESCAPED,IF_BLOCK>{SINGLE_QUOTE}        { printf(" SINGLE_QUOTE "); }
<ESCAPED,IF_BLOCK>{NUMBER}              { printf(" NUMBER "); }
<ESCAPED,IF_BLOCK>[}]                   { printf(" }'"); BEGIN INITIAL; }
<ESCAPED>{CONST_ID}                     { printf(" [CONST_ID:%s] ", yytext); }
<ESCAPED,IF_BLOCK>{ID}                  { printf(" [ID:%s] ", yytext); }
%%
