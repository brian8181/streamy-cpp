%{
    // #define LBRACKET 1
    // #define RBRACKET 2
    // #define NUMBER 3
    // #define IF    4
    // #define ELSE  5

    #define MAX_INCLUDE_DEPTH 10

    #include "parser_esc.tab.h"

    YY_BUFFER_STATE include_stack[MAX_INCLUDE_DEPTH];
    int include_stack_ptr = 0;
    int yylex(void);
    int yyerror(char* s);

    char buf[100];
    char *s;

    //char *yylval;
    // #include <string.h>   //   \"[^"\n]*["\n]
    //
    // yylval = strdup(yytext+1);
    // if (yylval[yyleng-2] != '"')
    //     warning("improperly terminated string");
    // else yylval[yyleng-2] = 0;
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
AND      "&&"
OR      "||"
LESS_THAN       "<"
GREATER_THAN    ">"
NUMBER          [0-9]+
HTTP            get|post|cookies|env|request|session
CONFIG          config_load|config|section|template|ldelim|rdelim|version|cycle|counter
UTILITY         const|debug|eval|fetch|textformat|math
ACCSESSORS      assign|isset|index|index_prev|index_next|iteration|first|last|show|total|from|item
HTML            html_checkboxes|html_image|html_table|html_options|html_radios|html_select_date|html_select_time
MODIFIER        tuncate|cat|spacify|lower|upper|date_format|default|replace|strip|indent|wordwrap|nl2br
MORE            "captialize|regex_replace|count_characters|count_sentences|count_paragraphs|count_words|strip_tags|escape"
INCLUDE         include

%x STRING
%x ESCAPED
%x IF_BLOCK
%x incl
%x OFF
%%

{COMMENT}                               { /* eat up comment */ }
[{]                                     { printf("'{ "); BEGIN ESCAPED; }

<OFF>{INCLUDE}                          { printf(" INCLUDE "); BEGIN(incl); } // turned OFF for now, need to debug!
<OFF>\"          { BEGIN STRING; s = buf; }
<STRING>\\n     { *s++ = '\n'; }
<STRING>\\t     { *s++ = '\t'; }
<STRING>\\\"    { *s++ = '\"'; }
<STRING>\"      {*s = 0; BEGIN 0; printf("found '%s'\n", buf); }
<STRING>\n      { printf("invalid string"); exit(1); }
<STRING>.       { *s++ = *yytext; }
<ESCAPED,IF_BLOCK>{HTML}                { printf(" HTML "); }
<ESCAPED,IF_BLOCK>{UTILITY}             { printf(" UTILITY "); }
<ESCAPED,IF_BLOCK>{MODIFIER}            { printf(" MODIFIER "); }
<ESCAPED,IF_BLOCK>{ACCSESSORS}          { printf(" ACCSESSORS "); }
<ESCAPED,IF_BLOCK>{CONFIG}              { printf(" CONFIG "); }
<ESCAPED,IF_BLOCK>{HTTP}                { printf(" HTTP "); }
<ESCAPED,IF_BLOCK>{AND}                 { printf(" AND "); }
<ESCAPED,IF_BLOCK>{OR}                  { printf(" OR "); }
<ESCAPED,IF_BLOCK>{SLASH}               { printf(" SLASH "); }
<ESCAPED,IF_BLOCK>{BACK_SLASH}          { printf(" BACK_SLASH "); }
<ESCAPED,IF_BLOCK>{VBAR}                { printf(" VBAR "); }
<ESCAPED,IF_BLOCK>{AT}                  { printf(" AT "); }
<ESCAPED,IF_BLOCK>{PLUS}                { printf(" PLUS "); }
<ESCAPED,IF_BLOCK>{MINUS}               { printf(" MINUS "); }
<ESCAPED,IF_BLOCK>{ASTERIK}             { printf(" ASTERIK "); }
<ESCAPED,IF_BLOCK>{EQUAL}               { printf(" EQUAL "); }
<ESCAPED,IF_BLOCK>{DOT}                 { printf(" DOT "); }
<ESCAPED,IF_BLOCK>{PERCENT}             { printf(" PERCENT "); }
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
<ESCAPED,IF_BLOCK>{NUMBER}              { printf(" NUMBER "); return NUMBER; }
<ESCAPED,IF_BLOCK>[}]                   { printf(" }'"); BEGIN INITIAL; }
<ESCAPED>{CONST_ID}                     { printf(" [CONST_ID:%s] ", yytext); return ID; }
<ESCAPED,IF_BLOCK>{ID}                  { printf(" [ID:%s] ", yytext); return ID;  }
<incl>[ \t]*        { /* eat the whitespace */ }
<incl>[^ \t\n]+     {
                        /* got the include file name */
                        if ( include_stack_ptr >= MAX_INCLUDE_DEPTH )
                        {
                            fprintf( stderr, "Includes nested too deeply" );
                            exit( 1 );
                        }
                        include_stack[include_stack_ptr++] = YY_CURRENT_BUFFER;

                        yyin = fopen( yytext, "r" );
                        if ( ! yyin )
                        {
                            printf( "could not open file, %s", yytext );
                        }

                        yy_switch_to_buffer( yy_create_buffer( yyin, YY_BUF_SIZE ) );
                        BEGIN(INITIAL);
                    }
<<EOF>>             {
                        if ( --include_stack_ptr < 0 )
                        {
                            yyterminate();
                        }
                        else
                        {
                            yy_delete_buffer( YY_CURRENT_BUFFER );
                            yy_switch_to_buffer(
                            include_stack[include_stack_ptr] );
                        }
                    }
%%
