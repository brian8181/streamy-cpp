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
FOREACH         foreach
FOREACHELSE     foreachelse
ELSE            else
ELSEIF          elseif
STREAM          .|\n
VBAR            "|"
COLON           ":"
LBRACKET        "["
RBRACKET        "]"
LBRACE          "{"
RBRACE          "}"
LPAREN          "("
RPAREN          ")"
SEMI_COLON      ";"
QUOTE           "\""
SINGLE_QUOTE    "'"
SLASH           "/"
BACK_SLASH      "\\"
TICK            "`"
UNDERSCORE      "_"
AT              "@"
PLUS            "+"
MINUS           "-"
ASTERIK         "*"
EQUAL          "="
DOT             "."
PERCENT         "%"
AMPERSAND       "&"
LOGICAL_AND      "&&"
LOGICAL_OR      "||"
NUMBER          [0-9]+

HTTP            "get|post|cookies|env|request|session"
CONFIG          "config_load|config|section|template|ldelim|rdelim|version|file|include|cycle|counter"
FUNCTIONS       "assign|const|debug|eval|fetch|textformat|math"
ACCSESSORS      "index|index_prev|index_next|iteration|first|last|show|total"
HTML            "html_checkboxes|html_image|html_table|html_options|html_radios|html_select_date|html_select_time"
MODIFIER        "tuncate|cat|spacify|lower|upper|date_format|default|replace|strip|indent|wordwrap|nl2br""
MORE            "captialize|regex_replace|count_characters|count_sentences|count_paragraphs|count_words|strip_tags|escape"

%x ESCAPED
%x IF_BLOCK
%%

{COMMENT}                               { /* eat up comment */ }
[{]                                     { printf("'{ "); BEGIN ESCAPED; }
<ESCAPED,IF_BLOCK>{LOGICAL_AND}           { printf(" LOGICAL_AND "); }
<ESCAPED,IF_BLOCK>{LOGICAL_OR}           { printf(" LOGICAL_OR "); }
<ESCAPED,IF_BLOCK>{SLASH}               { printf(" SLASH "); }
<ESCAPED,IF_BLOCK>{BACK_SLASH}               { printf(" BACK_SLASH "); }
<ESCAPED,IF_BLOCK>{VBAR}                { printf(" VBAR "); }
<ESCAPED,IF_BLOCK>{AT}                  { printf(" AT "); }
<ESCAPED,IF_BLOCK>{PLUS}               { printf(" PLUS "); }
<ESCAPED,IF_BLOCK>{MINUS}               { printf(" MINUS "); }
<ESCAPED,IF_BLOCK>{ASTERIK}               { printf(" ASTERIK "); }
<ESCAPED,IF_BLOCK>{EQUAL}               { printf(" EQUAL "); }
<ESCAPED,IF_BLOCK>{DOT}               { printf(" DOT "); }
<ESCAPED,IF_BLOCK>{PERCENT}               { printf(" PERCENT "); }
<ESCAPED,IF_BLOCK>{COLON}               { printf(" COLON "); }
<ESCAPED,IF_BLOCK>{LBRACKET}            { printf(" LBRACKET "); }
<ESCAPED,IF_BLOCK>{RBRACKET}            { printf(" RBRACKET "); }
<ESCAPED,IF_BLOCK>{LPAREN}              { printf(" LPAREN "); }
<ESCAPED,IF_BLOCK>{RPAREN}              { printf(" RPAREN "); }
<ESCAPED>{IF}                           { printf(" IF_BLOCK "); BEGIN IF_BLOCK; }
<ESCAPED>{ELSE}                         { printf(" ELSE_BLOCK "); BEGIN IF_BLOCK; }
<ESCAPED>{FOREACHELSE}                  { printf(" FOREACHELSE "); BEGIN IF_BLOCK; }
<ESCAPED>{FOREACH}                      { printf(" FOREACH "); BEGIN IF_BLOCK; }
<ESCAPED,IF_BLOCK>{SEMI_COLON}          { printf(" SEMI_COLON "); }
<ESCAPED,IF_BLOCK>{QUOTE}               { printf(" QUOTE "); }
<ESCAPED,IF_BLOCK>{SINGLE_QUOTE}        { printf(" SINGLE_QUOTE "); }
<ESCAPED,IF_BLOCK>{NUMBER}              { printf(" NUMBER "); }
<ESCAPED,IF_BLOCK>[}]                   { printf(" }'"); BEGIN INITIAL; }
<ESCAPED>{CONST_ID}                     { printf(" [CONST_ID:%s] ", yytext); }
<ESCAPED,IF_BLOCK>{ID}                  { printf(" [ID:%s] ", yytext); }
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
