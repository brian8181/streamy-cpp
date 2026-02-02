%{
    #include <stdio.h>
    #include <string.h>
    #include "p.tab.h"
    #include "utility.h"

    extern YYSTYPE yylval;

    extern int yywrap();
    extern int yylex(void);
    int yyerror(char* s);
    int fileno(FILE* f);

    /* include defines */
    #define MAX_INCLUDE_DEPTH 10
    YY_BUFFER_STATE include_stack[MAX_INCLUDE_DEPTH];
    int pstack = 0;
    extern char buf[100];
    extern char *s;
    #define YY_BUFFER YY_CURRENT_BUFFFER
%}

END_OF_FILE         \0
VALID_CHARS         [A-Za-z0-9*@_.~+-]
FIRST_CHAR          [A-Za-z*@_.~+-]
ID                  [A-Za-z*@_.~+-][A-Za-z0-9*@_.~+-]*
SYMBOL              $[A-Za-z*@_.~+-][A-Za-z0-9*@_.~+-]*
CONST_SYMBOL        #[A-Za-z*@_.~+-][A-Za-z0-9*@_.~+-]*#
ARRAY               [A-Za-z*@_.~+-][A-Za-z0-9*@_.~+-]*\[[^\]]\]
COMMENT             \{[ \t]*\*[^*}]*\*[ \t]*\}
FILE_NAME           [A-Za-z0-9_.-~+#@]
IF                  if
ELSE                "else"
ELSEIF              "elseif"
FOREACH             foreach
FOREACHELSE         foreachelse
VBAR                "|"
COLON               ":"
LBRACKET            "["
RBRACKET            "]"
LBRACE              "{"
RBRACE              "}"
LPAREN              "("
RPAREN              ")"
COMMA               ","
SEMI_COLON          ";"
DOUBLE_QUOTE        "\""
SINGLE_QUOTE        "'"
SLASH               "/"
BACK_SLASH          "\\"
AT                  "@"
PLUS                "+"
MINUS               "-"
ASTERIK             "*"
EQUAL               "="
NOT_EQUAL           "!="
DOT                 "."
INDIRECT_MEMBER     "->"
PERCENT             "%"
AMPERSAND           "&"
NOT                 "!"
AND                 "&&"
OR                  "||"
LESS_THAN           "<"
LESS_THAN_EQUAL     "<="
GREATER_THAN        ">"
GREATER_THAN_EQUAL  ">="
NUMERIC_LITERAL     [0-9]+
REQUIRE             require
CONFIG_LOAD         config_load
INSERT              insert
INCLUDE             include
FILE_ATTRIB         file
ASSIGN              assign
VAR_ATTRIB          var
VALUE_ATTRIB        value
FROM_ATTRIB         from
ITEM_ATTRIB         item
KEY_ATTRIB          key
NAME_ATTRIB         name
CAPITALIZE          captialize
CAT                 cat
COUNT_CHARACTERS    count_chacters
COUNT_PARAGRAPHS    count_paragraphs
COUNT_SENTENCES     count_sentences
COUNT_WORDS         count_words
DATE_FORMAT         date_format
DEFAULT             default
ESCAPE              escape
INDENT              indent
LOWER               lower
UPPER               upper
STRIP               strip
NL2BR               nl2br
REGX_REPLACE        regx_replace
REPLACE             replace
SPACIFY             spacify
STRING_FORMAT       string_format
STRIP_TAGS          strip_tags
TRUNCATE            truncate
WORDWRAP            wordwrap



%x DOUBLE_QUOTED
%x SINGLE_QUOTED
%x ESCAPED
%x IF_BLOCK
%x IF_CONDITION
%x INCLUDING
%x OFF
%%


{COMMENT}                               {  /* eat up comment */ printf("LEX:COMMENT=\"%s\"", yytext); }
{LBRACE}                                {
                                            //printf("LEX:LBRACE\n");
                                            printf("LEX:BEGIN ESCAPED\n");
                                            BEGIN(ESCAPED);
                                            return LBRACE;
                                        }

<ESCAPED>{
{RBRACE}                                {
                                            printf("LEX:RBRACE\n");
                                            printf("LEX:BEGIN INITIAL\n");
                                            BEGIN(INITIAL);
                                            return RBRACE;
                                        }
{SINGLE_QUOTE}                          { printf("LEX:BEGIN_SINGLE_QUOTED\n"); BEGIN(SINGLE_QUOTED); s = buf;                           }
{DOUBLE_QUOTE}                          { printf("LEX:BEGIN_DOUBLE_QUOTED\n"); BEGIN(DOUBLE_QUOTED); s = buf;                           }
{NUMERIC_LITERAL}                       {
                                            printf("LEX:NUMERIC_LITERAL=%s\n", yytext);
                                            yylval.ival = atoi(yytext);
                                            return NUMERIC_LITERAL;
                                        }

{SYMBOL}                                { printf("LEX:[SYMBOL:%s]\n", yytext); yylval.sval = yytext;       return SYMBOL;               }
{CONST_SYMBOL}                          { printf("LEX:[CONST_SYMBOL:%s]\n", yytext); yylval.sval = yytext; return CONST_SYMBOL;         }
[ \t]*                                  { /********************************** eat whitespace *********************************/         }
} // END ESCAPED
<IF_CONDITION>{
{RBRACE}                                { printf("LEXIF_BLOCK"); BEGIN(IF_BLOCK);                                                       }
[^}]                                    { ECHO; }
} // END IF_CONDITION
<IF_BLOCK>[^{]                          { ECHO; }
<<EOF>>                                 {
                                            printf("LEX:<<EOF>>\n");
                                            // //return END;
                                            return 0;
                                        }

%%
