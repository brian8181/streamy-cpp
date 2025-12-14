%{
    #define MAX_INCLUDE_DEPTH 10
    #include <stdio.h>
    #include <stdio.h>
    #include "parser.tab.h"
    int fileno();

    YY_BUFFER_STATE include_stack[MAX_INCLUDE_DEPTH];
    int include_stack_ptr = 0;
    int yylex(void);
    int yyerror(char* s);


    char buf[100];
    char *s;
    #define LBRACKET 1
    #define RBRACKET 2
    #define NUMBER 3
    #define IF    4
    #define ELSE  5

%}

END_OF_FILE         \0
IDENTIFIER          _*[A-Za-z][A-Za-z0-9_]*
ID                  \${IDENTIFIER}
CONST_ID            #{IDENTIFIER}#
QUALAFIED_ID        {ID}(("."|"->"){IDENTIFIER})+
FUNC                {IDENTIFIER}+[ /t]*\([^)]*\)
ARRAY               {ID}\[[^\]]\]
COMMENT             \{[ \t]*\*[^*}]*\*[ \t]*\}
IF                  if
END_IF              "{/if}"
FOREACH             foreach
END_FOREACH         "/foreach"
FOREACHELSE         foreachelse
END_FOREACHELSE     "/foreachelse"
ELSE                "else"
ELSEIF              "elseif"
STREAM              .|\n
VBAR                "|"
COLON               ":"
LBRACKET            "["
RBRACKET            "]"
LBRACE              "{"
RBRACE              "}"
LPAREN              "("
RPAREN              ")"
SEMI_COLON          ";"
QUOTE               "\""
SINGLE_QUOTE        "'"
SLASH               "/"
BACK_SLASH          "\\"
TICK                "`"
UNDERSCORE          "_"
AT                  "@"
PLUS                "+"
MINUS               "-"
ASTERIK             "*"
EQUAL               "="
NOT_EQUAL           "!="
DOT                 "."
PERCENT             "%"
AMPERSAND           "&"
NOT                 "!"
AND                 "&&"
OR                  "||"
LESS_THAN           "<"
LESS_THAN_EQUAL     "<="
GREATER_THAN        ">"
GREATER_THAN_EQUAL  ">="
NUMBER              [0-9]+
HTTP                get|post|cookies|env|request|session
CONFIG              config|section|template|ldelim|rdelim|version|cycle|counter
UTILITY             const|debug|eval|fetch|textformat|math
ACCSESSORS          assign|isset|index|index_prev|index_next|iteration|first|last|show|total|from|item
HTML                html_checkboxes|html_image|html_table|html_options|html_radios|html_select_date|html_select_time
MODIFIER            tuncate|cat|spacify|lower|upper|date_format|default|replace|strip|indent|wordwrap|nl2br
MORE                "captialize|regex_replace|count_characters|count_sentences|count_paragraphs|count_words|strip_tags|escape"
INCLUDE             include
CONFIG_LOAD         config_load
FILE_ATTRIB         file

%x STRING
%x ESCAPED
%x IF_BLOCK
%x IF_CONDITION
%x incl
%x OFF
%%

{COMMENT}                               { /* eat up comment */ }
{LBRACE}                                { printf(" { "); BEGIN ESCAPED; }
<OFF>{INCLUDE}                          { printf(" INCLUDE "); BEGIN(incl); } // turned OFF for now, need to debug!
<OFF>\"                                 { BEGIN STRING; s = buf; }
<STRING>\\n                             { *s++ = '\n'; }
<STRING>\\t                             { *s++ = '\t'; }
<STRING>\\\"                            { *s++ = '\"'; }
<STRING>\"                              {*s = 0; BEGIN 0; printf("found '%s'\n", buf); }
<STRING>\n                              { printf("invalid string"); exit(1); }
<STRING>.                               { *s++ = *yytext; }
<ESCAPED,IF_CONDITION>{HTML}                { printf(" HTML "); }
<ESCAPED,IF_CONDITION>{UTILITY}             { printf(" UTILITY "); }
<ESCAPED,IF_CONDITION>{MODIFIER}            { printf(" MODIFIER "); }
<ESCAPED,IF_CONDITION>{ACCSESSORS}          { printf(" ACCSESSORS "); }
<ESCAPED,IF_CONDITION>{CONFIG}              { printf(" CONFIG "); }
<ESCAPED,IF_CONDITION>{CONFIG_LOAD}         { printf(" CONFIG_LOAD "); }
<ESCAPED,IF_CONDITION>{FILE_ATTRIB}         { printf(" FILE_ATTRIB "); }
<ESCAPED,IF_CONDITION>{HTTP}                { printf(" HTTP "); }
<ESCAPED,IF_CONDITION>{NOT}                 { printf(" NOT "); } //return NOT; }
<ESCAPED,IF_CONDITION>{AND}                 { printf(" AND "); } //return AND; }
<ESCAPED,IF_CONDITION>{OR}                  { printf(" OR "); } //return OR; }
<ESCAPED,IF_CONDITION>{LESS_THAN}           { printf(" LESS_THAN "); } //return LESS_THAN; }
<ESCAPED,IF_CONDITION>{LESS_THAN_EQUAL}     { printf(" LESS_THAN_EQUAL "); } //return LESS_THAN_EQUAL; }
<ESCAPED,IF_CONDITION>{GREATER_THAN}        { printf(" GREATER_THAN "); } //return GREATER_THAN; }
<ESCAPED,IF_CONDITION>{GREATER_THAN_EQUAL}  { printf(" GREATER_THAN_EQUAL "); } //return GREATER_THAN_EQUAL; }
<ESCAPED,IF_CONDITION>{SLASH}               { printf(" SLASH "); } //return SLASH; }
<ESCAPED,IF_CONDITION>{BACK_SLASH}          { printf(" BACK_SLASH "); } //return BACK_SLASH; }
<ESCAPED,IF_CONDITION>{VBAR}                { printf(" VBAR "); } //return VBAR; }
<ESCAPED,IF_CONDITION>{AT}                  { printf(" AT "); }
<ESCAPED,IF_CONDITION>{PLUS}                { printf(" PLUS "); } //return PLUS; }
<ESCAPED,IF_CONDITION>{MINUS}               { printf(" MINUS "); } //return MINUS;}
<ESCAPED,IF_CONDITION>{ASTERIK}             { printf(" ASTERIK "); } //return ASTERIK; }
<ESCAPED,IF_CONDITION>{EQUAL}               { printf(" EQUAL "); } //return EQUAL; }
<ESCAPED,IF_CONDITION>{NOT_EQUAL}           { printf(" NOT_EQUAL "); } //return NOT_EQUAL; }
<ESCAPED,IF_CONDITION>{DOT}                 { printf(" DOT "); } //return DOT; }
<ESCAPED,IF_CONDITION>{PERCENT}             { printf(" PERCENT ");} //return PERCENT; }
<ESCAPED,IF_CONDITION>{COLON}               { printf(" COLON "); } //return COLON; }
<ESCAPED,IF_CONDITION>{LBRACKET}            { printf(" LBRACKET "); } //return LBRACKET; }
<ESCAPED,IF_CONDITION>{RBRACKET}            { printf(" RBRACKET "); } //return RBRACKET; }
<ESCAPED,IF_CONDITION>{LPAREN}              { printf(" LPAREN "); } //return RPAREN; }
<ESCAPED,IF_CONDITION>{RPAREN}              { printf(" RPAREN "); } //return LPAREN; }
<ESCAPED,IF_CONDITION>{SEMI_COLON}          { printf(" SEMI_COLON "); } //return SEMI_COLON; }
<ESCAPED,IF_CONDITION>{QUOTE}               { printf(" QUOTE "); } //return QUOTE; }
<ESCAPED,IF_CONDITION>{SINGLE_QUOTE}        { printf(" SINGLE_QUOTE "); } //return SINGLE_QUOTE; }
<ESCAPED,IF_CONDITION>{NUMBER}              { printf(" NUMBER "); } //return NUMBER; }
<ESCAPED,IF_CONDITION>{RBRACE}              { printf(" } "); BEGIN INITIAL; }
<IF_CONDITION>[^}]                          {  ECHO; }
<IF_CONDITION>[}]                           { printf("IF_BLOCK"); ECHO; BEGIN IF_BLOCK; }
<IF_BLOCK>[^{]                              { ECHO; }
<IF_BLOCK>{END_IF}                          { printf(" end if ...'\n"); BEGIN INITIAL; }
<ESCAPED>{IF}                           { printf(" IF_BLOCK "); BEGIN IF_CONDITION; } //return IF; }
<ESCAPED>{ELSE}                         { printf(" ELSE_BLOCK "); BEGIN IF_BLOCK; } //return ELSE; }
<ESCAPED>{ELSEIF}                       { printf(" ELSEIF "); BEGIN IF_CONDITION; } //return ELSEIF; }
<ESCAPED>{FOREACHELSE}                  { printf(" FOREACHELSE "); BEGIN IF_BLOCK; } //return FOREACHELSE; }
<ESCAPED>{FOREACH}                      { printf(" FOREACH "); BEGIN IF_BLOCK; } //return FOREACH; }
<ESCAPED,IF_BLOCK>{END_FOREACHELSE}     { printf(" FOREACHELSE "); BEGIN ESCAPED; } //return FOREACHELSE; }
<ESCAPED,IF_BLOCK>{END_FOREACH}         { printf(" FOREACH "); BEGIN ESCAPED; } //return FOREACH; }
<ESCAPED,IF_BLOCK>{CONST_ID}            { printf(" [CONST_ID:%s] ", yytext); return CONST_ID; }
<ESCAPED,IF_BLOCK>{FUNC}                { printf(" [FUNC:%s] ", yytext); } //return ID;  }
<ESCAPED,IF_BLOCK>{ID}                  { printf(" [ID:%s] ", yytext); return ID;  }
<incl>[ \t]*                            { /* eat the whitespace */ }
<incl>[^ \t\n]+                         {
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
<<EOF>>                                 {
                                            if ( --include_stack_ptr < 0 )
                                            {
                                                return END_OF_FILE;
                                                //yyterminate();
                                            }
                                            else
                                            {
                                                yy_delete_buffer( YY_CURRENT_BUFFER );
                                                yy_switch_to_buffer(
                                                include_stack[include_stack_ptr] );
                                            }
                                        }

%%

#ifdef LEXER_EXE
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
#endif
