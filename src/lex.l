%{
    #include <stdio.h>
    #include <string.h>
    #include "parser.tab.h"
    #include "utility.h"

    extern YYSTYPE yylval;

    int yylex(void);
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
SYMBOL              \$[A-Za-z*@_.~+-][A-Za-z0-9*@_.~+-]*
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
UNESCAPED_TEXT                [^{]+


%x DOUBLE_QUOTED
%x SINGLE_QUOTED
%x ESCAPED
%x IF_BLOCK
%x IF_CONDITION
%x INCLUDING
%x OFF
%%

<INITIAL>{
{COMMENT}                               {  /* eat up comment */ printf("LEX:COMMENT=\"%s\"", yytext); }
{LBRACE}                                {
                                            printf("LEX:LBRACE\n");
                                            printf("LEX:BEGIN ESCAPED\n");
                                            BEGIN(ESCAPED);
                                            return LBRACE;
                                        }
{UNESCAPED_TEXT}                        {
                                             printf("LEX:TEXT\n");
                                             return UNESCAPED_TEXT;
                                        }
} // END INITIAL
<SINGLE_QUOTED,DOUBLE_QUOTED>{
\\n                                     { *s++ = '\n'; }
\\t                                     { *s++ = '\t'; }
\\\"                                    { *s++ = '\"'; }
[\n}]                                   { printf("LEX: missing closing quote"); exit(1); }
} // END SINGLE_QUOTED or DOUBLE_QUOTED
<SINGLE_QUOTED>{
{VALID_CHARS}                           { *s++ = *yytext; }
{SINGLE_QUOTE}                          {
                                            printf("LEX:SINGLE_QUOTE\n");
                                            printf("LEX:BEGIN ESCAPED\n");
                                            BEGIN(ESCAPED);
                                            *s = '\0';
                                            s = &buf[0];
                                            printf("LEX:STRING_LITERAL=\"%s\"\n", buf);
                                            return STRING_LITERAL;
                                        }
} // END SINGLE_QUOTE
<DOUBLE_QUOTED>{
{VALID_CHARS}                           { *s++ = *yytext; }
{DOUBLE_QUOTE}                          {
                                            printf("LEX:DOUBLE_QUOTE\n");
                                            printf("LEX:BEGIN ESCAPED\n");
                                            BEGIN(ESCAPED);
                                            *s = '\0';
                                            s = &buf[0];
                                            printf("LEX:STRING_LITERAL=\"%s\"\n", buf);
                                            return STRING_LITERAL;
                                        }
} // END DOUBLE_QUOTE
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
{ASSIGN}                                { printf("LEX:ASSIGN\n");                         return ASSIGN;                                }
{REQUIRE}                               { printf("LEX:REQUIRE\n");                        return REQUIRE;                               }
{CONFIG_LOAD}                           { printf("LEX:CONFIG_LOAD\n");                    return CONFIG_LOAD;                           }
{INSERT}                                { printf("LEX:INSERT\n");                         return INSERT;                                }
{FILE_ATTRIB}                           { printf("LEX:FILE_ATTRIB\n");                    return FILE_ATTRIB;                           }
{VAR_ATTRIB}                            { printf("LEX:VAR_ATTRIB\n");                     return VAR_ATTRIB;                            }
{VALUE_ATTRIB}                          { printf("LEX:VALUE_ATTRIB\n");                   return VALUE_ATTRIB;                          }
{FROM_ATTRIB}                           { printf("LEX:FROM_ATTRIB\n");                    return FROM_ATTRIB;                           }
{KEY_ATTRIB}                            { printf("LEX:KEY_ATTRIB\n");                     return KEY_ATTRIB;                            }
{NAME_ATTRIB}                           { printf("LEX:NAME_ATTRIB\n");                    return NAME_ATTRIB;                           }
{CAPITALIZE}                            { printf("LEX:CAPITALIZE\n");                     return CAPITALIZE;                            }
{CAT}                                   { printf("LEX:CAT\n");                            return CAT;                                   }
{COUNT_CHARACTERS}                      { printf("LEX:COUNT_CHARACTERS\n");               return COUNT_CHARACTERS;                      }
{COUNT_SENTENCES}                       { printf("LEX:COUNT_SENTENCES\n");                return COUNT_SENTENCES;                       }
{COUNT_PARAGRAPHS}                      { printf("LEX:COUNT_PARAGRAPHS\n");               return COUNT_PARAGRAPHS;                      }
{COUNT_WORDS}                           { printf("LEX:COUNT_WORDS\n");                    return COUNT_WORDS;                           }
{DATE_FORMAT}                           { printf("LEX:DATE_FORMAT\n");                    return DATE_FORMAT;                           }
{DEFAULT}                               { printf("LEX:DEFAULT\n");                        return DEFAULT;                               }
{ESCAPE}                                { printf("LEX:ESCAPE\n");                         return ESCAPE;                                }
{INDENT}                                { printf("LEX:INDENT\n");                         return INDENT;                                }
{STRIP}                                 { printf("LEX:STRIP\n");                          return STRIP;                                 }
{NL2BR}                                 { printf("LEX:NL2BR\n");                          return NL2BR;                                 }
{REPLACE}                               { printf("LEX:REPLACE\n");                        return REPLACE;                               }
{SPACIFY}                               { printf("LEX:SPACIFY\n");                        return SPACIFY;                               }
{STRING_FORMAT}                         { printf("LEX:STRING_FORMAT\n");                  return STRING_FORMAT;                         }
{STRIP_TAGS}                            { printf("LEX:STRIP_TAGS\n");                     return STRIP_TAGS;                            }
{TRUNCATE}                              { printf("LEX:TRUNCATE\n");                       return TRUNCATE;                              }
{UPPER}                                 { printf("LEX:UPPER\n");                          return UPPER;                                 }
{LOWER}                                 { printf("LEX:LOWER\n");                          return LOWER;                                 }
{NOT}                                   { printf("LEX:NOT\n");                            return NOT;                                   }
{AND}                                   { printf("LEX:AND\n");                            return AND;                                   }
{OR}                                    { printf("LEX:OR\n");                             return OR;                                    }
{LESS_THAN}                             { printf("LEX:LESS_THAN\n");                      return LESS_THAN;                             }
{LESS_THAN_EQUAL}                       { printf("LEX:LESS_THAN_EQUAL\n");                return LESS_THAN_EQUAL;                       }
{GREATER_THAN}                          { printf("LEX:GREATER_THAN\n");                   return GREATER_THAN;                          }
{GREATER_THAN_EQUAL}                    { printf("LEX:GREATER_THAN_EQUAL\n");             return GREATER_THAN_EQUAL;                    }
{SLASH}                                 { printf("LEX:SLASH\n");                          return SLASH;                                 }
{BACK_SLASH}                            { printf("LEX:BACK_SLASH\n");                     return BACK_SLASH;                            }
{VBAR}                                  { printf("LEX:VBAR\n");                           return VBAR;                                  }
{AMPERSAND}                             { printf("LEX:AMPERSAND\n");                      return AMPERSAND;                             }
{AT}                                    { printf("LEX:AT\n");                             return AT;                                    }
{PLUS}                                  { printf("LEX:PLUS\n");                           return PLUS;                                  }
{MINUS}                                 { printf("LEX:MINUS\n");                          return MINUS;                                 }
{ASTERIK}                               { printf("LEX:ASTERIK\n");                        return ASTERIK;                               }
{EQUAL}                                 { printf("LEX:EQUAL\n");                          return EQUAL;                                 }
{NOT_EQUAL}                             { printf("LEX:NOT_EQUAL\n");                      return NOT_EQUAL;                             }
{DOT}                                   { printf("LEX:DOT\n");                            return DOT;                                   }
{INDIRECT_MEMBER}                       { printf("LEX:INDIRECT_MEMBER\n");                return INDIRECT_MEMBER;                       }
{PERCENT}                               { printf("LEX:PERCENT\n");                        return PERCENT;                               }
{COLON}                                 { printf("LEX:COLON\n");                          return COLON;                                 }
{COMMA}                                 { printf("LEX:COMMA\n");                          return COMMA;                                 }
{LBRACKET}                              { printf("LEX:LBRACKET\n");                       return LBRACKET;                              }
{RBRACKET}                              { printf("LEX:RBRACKET\n");                       return RBRACKET;                              }
{LPAREN}                                { printf("LEX:LPAREN\n");                         return LPAREN;                                }
{RPAREN}                                { printf("LEX:RPAREN\n");                         return RPAREN;                                }
{SEMI_COLON}                            { printf("LEX:SEMI_COLON\n");                     return SEMI_COLON;                            }
{IF}                                    { printf("LEX:IF\n"); BEGIN(ESCAPED);             return IF;                                    }
{ELSE}                                  { printf("LEX:ELSE_BLOCK\n"); BEGIN(IF_BLOCK);    return ELSE;                                  }
{ELSEIF}                                { printf("LEX:ELSEIF\n"); BEGIN(IF_BLOCK);        return ELSEIF;                                }
{FOREACHELSE}                           { printf("LEX:FOREACHELSE\n"); BEGIN(IF_BLOCK);   return FOREACHELSE;                           }
{FOREACH}                               { printf("LEX:FOREACH\n"); BEGIN (IF_BLOCK);      return FOREACH;                               }
{SYMBOL}                                { printf("LEX:[SYMBOL:%s]\n", yytext); yylval.sval = yytext;       return SYMBOL;               }
{CONST_SYMBOL}                          { printf("LEX:[CONST_SYMBOL:%s]\n", yytext); yylval.sval = yytext; return CONST_SYMBOL;         }
[ \t]*                                  { /********************************** eat whitespace *********************************/         }
} // END ESCAPED
<IF_CONDITION>{
{RBRACE}                                { printf("LEXIF_BLOCK"); BEGIN(IF_BLOCK);                                                       }
[^}]                                    { ECHO; }
} // END IF_CONDITION
<IF_BLOCK>[^{]                          { ECHO; }
<ESCAPED>{INCLUDE}                      { printf("LEX:INCLUDE\n"); printf("LEX:BEGIN(INCLUDE)\n"); BEGIN(INCLUDING);  return INCLUDE;  }
<INCLUDING>{
[^{RBRACE}]+                            {
                                            printf("LEX:INCLUDING \"%s\"\n", buf);

                                            // bkp todo!
                                            // {include file="name"}
                                            regmatch_t* pmatch;
                                            char* pattern = "\\{include file=\\\"(.*)\\\"\\}";
                                            regex_match(pattern, yytext, 2, pmatch);

                                            // include file name
                                            if ( pstack >= MAX_INCLUDE_DEPTH )
                                            {
                                                fprintf( stderr, "error: includes nested too deeply" );
                                                exit( 1 );
                                            }
                                            include_stack[pstack++] = YY_CURRENT_BUFFER;

                                            yyin = fopen( yytext, "r" );
                                            if ( ! yyin )
                                            {
                                                printf( "error: could not open file, %s", yytext );
                                            }

                                            yy_switch_to_buffer( yy_create_buffer( yyin, YY_BUF_SIZE ) );
                                            printf("LEX:BEGIN INITIAL\n");
                                            BEGIN(INITIAL);
                                        }
{RBRACE}                                {
                                            printf("LEX:RBRACE\n");
                                            printf("LEX:BEGIN(INITIAL)\n");
                                            BEGIN(INITIAL);
                                            return RBRACE;
                                        }
<<EOF>>                                 {

                                            printf("LEX:<<EOF>>\n");
                                            yyrestart( yyin );
                                            if ( --pstack < 0 )
                                            {
                                                yyterminate();
                                            }
                                            else
                                            {
                                                yy_delete_buffer( YY_CURRENT_BUFFER );
                                                yy_switch_to_buffer(
                                                include_stack[pstack] );
                                            }
                                        }
} // end INCLUDING
<<EOF>>                                 {
                                            printf("LEX:<<EOF>>\n");
                                            return END;
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
#endif

#ifdef MAIN_IMP
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
