%{
    #define MAX_INCLUDE_DEPTH 10
    #include <stdio.h>
    #include <stdio.h>
    #include "parser.tab.h"


    YY_BUFFER_STATE include_stack[MAX_INCLUDE_DEPTH];
    int include_stack_ptr = 0;
    int yylex(void);
    int yyerror(char* s);
    int fileno(FILE* f);

    extern char buf[100];
    extern char *s;
    #define LBRACKET 1
    #define RBRACKET 2
    #define NUMBER 3
    #define IF    4
    #define ELSE  5
%}

END_OF_FILE         \0
IDENTIFIER          _*[A-Za-z][A-Za-z0-9_]*
CONST_ID            #{IDENTIFIER}#
FUNC                {IDENTIFIER}+\([^)]*\)
ARRAY               {ID}\[[^\]]\]
COMMENT             \{[ \t]*\*[^*}]*\*[ \t]*\}
IF                  if
END_IF              "\{/if\}"
FOREACH             foreach
END_FOREACH         "/foreach"
FOREACHELSE         foreachelse
END_FOREACHELSE     "/foreachelse"
ELSE                else
END_ELSE            "/else"
ELSEIF              elseif
END_ELSEIF          "/elseif"
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
DOUBLE_QUOTE        "\""
SINGLE_QUOTE        "'"
SLASH               "/"
BACK_SLASH          "\\"
TICK                "`"
UNDERSCORE          "_"
DOLLAR_SIGN         "\$"
AT                  "@"
PLUS                "+"
MINUS               "-"
ASTERIK             "*"
EQUAL               "="
NOT_EQUAL           "!="
DOT                 "."
INDIRECT_MEMBER "->"
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

%x DOUBLE_QUOTED
%x SINGLE_QUOTED
%x ESCAPED
%x IF_BLOCK
%x IF_CONDITION
%x incl
%x OFF
%%

<INITIAL>{COMMENT}                      { /* eat up comment */                                                           }
<INITIAL>{LBRACE}                       { printf("LEX:BEGIN_ESCAPED _LINE__ \n"); BEGIN(ESCAPED);                                 }
<ESCAPED,IF_BLOCK>{RBRACE}              { printf("LEX:BEGIN_INITIAL\n"); BEGIN(INITIAL);                                 } // return RBRACE;
<OFF>{INCLUDE}                          { printf("LEX:INCLUDE\n"); BEGIN(incl);                                          } // turned OFF for now, need to debug!
<ESCAPED>{SINGLE_QUOTE}                 { printf("LEX:BEGIN_SINGLE_QUOTED\n"); BEGIN(SINGLE_QUOTED); s = buf;            }
<SINGLE_QUOTED>\\n                      { *s++ = '\n';                                                                   }
<SINGLE_QUOTED>\\t                      { *s++ = '\t';                                                                   }
<SINGLE_QUOTED>\\\"                     { *s++ = '\"';                                                                   }
<SINGLE_QUOTED>{SINGLE_QUOTE}           {
                                            printf("LEX:BEGIN_ESCAPED\n"); *s = 0;
                                            BEGIN(ESCAPED); printf("LITERAL\n");
                                            return STRING_LITERAL;
                                        }
<SINGLE_QUOTED>[\n}]                    { printf(" LEX invalid ESCAPED,SINGLE_QUOTED"); exit(1);                         }
<SINGLE_QUOTED>.                        { *s++ = *yytext;                                                                }
<SINGLE_QUOTED>{DOUBLE_QUOTE}           { printf("LEX:QUOTE\n"); return DOUBLE_QUOTED;                                   }
<ESCAPED>{DOUBLE_QUOTE}                 { printf("LEX:BEGIN_DOUBLE_QUOTED\n"); BEGIN(DOUBLE_QUOTED); s = buf;            }
<DOUBLE_QUOTED>\\n                      { *s++ = '\n';                                                                   }
<DOUBLE_QUOTED>\\t                      { *s++ = '\t';                                                                   }
<DOUBLE_QUOTED>\\\"                     { *s++ = '\"';                                                                   }
<DOUBLE_QUOTED>{DOUBLE_QUOTE}           {
                                            printf("LEX:BEGIN ESCAPED\n"); *s = 0;
                                            BEGIN(ESCAPED); printf("LEX:LITERAL\n");
                                            return STRING_LITERAL;
                                        }
<DOUBLE_QUOTED>[\n}]                    { printf(" LEX invalid ESCAPED,SINGLE_QUOTED"); exit(1);                          }
<DOUBLE_QUOTED>.                        { *s++ = *yytext;                                                                 }
<DOUBLE_QUOTED>{SINGLE_QUOTE}           { printf("LEX:SINGLE_QUOTE\n");                  return SINGLE_QUOTE;             }
<ESCAPED,IF_BLOCK>{UTILITY}             { printf("LEX:UTILITY\n");                                                        }
<ESCAPED,IF_BLOCK>{MODIFIER}            { printf("LEX:MODIFIER\n");                                                       }
<ESCAPED,IF_BLOCK>{ACCSESSORS}          { printf("LEX:ACCSESSORS\n");                                                     }
<ESCAPED,IF_BLOCK>{CONFIG}              { printf("LEX:CONFIG\n");                                                         }
<ESCAPED,IF_BLOCK>{CONFIG_LOAD}         { printf("LEX:CONFIG_LOAD\n");                    return CONFIG_LOAD;             }
<ESCAPED,IF_BLOCK>{FILE_ATTRIB}         { printf("LEX:FILE_ATTRIB\n");                    return FILE_ATTRIB;             }
<ESCAPED,IF_BLOCK>{HTML}                { printf("LEX:HTML\n");                           } // return HTTP;               }
<ESCAPED,IF_BLOCK>{HTTP}                { printf("LEX:HTTP\n");                           } // return HTTP;               }
<ESCAPED,IF_BLOCK>{NOT}                 { printf("LEX:NOT\n");                            } // return NOT;                }
<ESCAPED,IF_BLOCK>{AND}                 { printf("LEX:AND\n");                            } // return AND;                }
<ESCAPED,IF_BLOCK>{OR}                  { printf("LEX:OR\n");                             } // return OR;                 }
<ESCAPED,IF_BLOCK>{LESS_THAN}           { printf("LEX:LESS_THAN\n");                      } // return LESS_THAN;          }
<ESCAPED,IF_BLOCK>{LESS_THAN_EQUAL}     { printf("LEX:LESS_THAN_EQUAL\n");                } // return LESS_THAN_EQUAL;    }
<ESCAPED,IF_BLOCK>{GREATER_THAN}        { printf("LEX:GREATER_THAN\n");                   } // return GREATER_THAN;       }
<ESCAPED,IF_BLOCK>{GREATER_THAN_EQUAL}  { printf("LEX:GREATER_THAN_EQUAL\n");             } // return GREATER_THAN_EQUAL; }
<ESCAPED,IF_BLOCK>{SLASH}               { printf("LEX:SLASH\n");                          } // return SLASH;              }
<ESCAPED,IF_BLOCK>{BACK_SLASH}          { printf("LEX:BACK_SLASH\n");                     } // return BACK_SLASH;         }
<ESCAPED,IF_BLOCK>{VBAR}                { printf("LEX:VBAR\n");                           } // return VBAR;               }
<ESCAPED,IF_BLOCK>{AMPERSAND}           { printf("LEX:AMPERSAND\n");                      } // return AMPERSAND;          }
<ESCAPED,IF_BLOCK>{AT}                  { printf("LEX:AT\n");                             } // return AT;                 }
<ESCAPED,IF_BLOCK>{DOLLAR_SIGN}         { printf("LEX:DOLLAR_SIGN\n");                    return DOLLAR_SIGN;             }
<ESCAPED,IF_BLOCK>{PLUS}                { printf("LEX:PLUS\n");                           } // return PLUS;               }
<ESCAPED,IF_BLOCK>{MINUS}               { printf("LEX:MINUS\n");                          } // return MINUS;              }
<ESCAPED,IF_BLOCK>{ASTERIK}             { printf("LEX:ASTERIK\n");                        } // return ASTERIK;            }
<ESCAPED,IF_BLOCK>{EQUAL}               { printf("LEX:EQUAL\n");                          return EQUAL;                   }
<ESCAPED,IF_BLOCK>{NOT_EQUAL}           { printf("LEX:NOT_EQUAL\n");                      return NOT_EQUAL;               }
<ESCAPED,IF_BLOCK>{DOT}                 { printf("LEX:DOT\n");                            return DOT;                     }
<ESCAPED,IF_BLOCK>{INDIRECT_MEMBER}     { printf("LEX:INDIRECT_MEMBER\n");                return INDIRECT_MEMBER;         }
<ESCAPED,IF_BLOCK>{PERCENT}             { printf("LEX:PERCENT\n");                        } // return PERCENT;            }
<ESCAPED,IF_BLOCK>{COLON}               { printf("LEX:COLON\n");                          } // return COLON;              }
<ESCAPED,IF_BLOCK>{LBRACKET}            { printf("LEX:LBRACKET\n");                       return LBRACKET;                }
<ESCAPED,IF_BLOCK>{RBRACKET}            { printf("LEX:RBRACKET\n");                       return RBRACKET;                }
<ESCAPED,IF_BLOCK>{LPAREN}              { printf("LEX:LPAREN\n");                         return RPAREN;                  }
<ESCAPED,IF_BLOCK>{RPAREN}              { printf("LEX:RPAREN\n");                         return LPAREN;                  }
<ESCAPED,IF_BLOCK>{SEMI_COLON}          { printf("LEX:SEMI_COLON\n");                     } // return SEMI_COLON;         }
<ESCAPED,IF_BLOCK>{NUMBER}              { printf("LEX:NUMBER\n");                         return NUMBER;                  }
<ESCAPED,IF_BLOCK>{END_IF}              { printf("LEX:END_IF\n"); BEGIN(ESCAPED);         } // return IF;                 }
<IF_CONDITION>{RBRACE}                  { printf("LEXIF_BLOCK"); BEGIN(IF_BLOCK);                                         }
<IF_CONDITION>[^}]                      { ECHO;                                                                           }
<IF_BLOCK>[^{]                          { ECHO;                                                                           }
<ESCAPED>{IF}                           { printf("LEX:IF_BLOCK\n"); BEGIN(IF_BLOCK);       } // return IF;                }
<ESCAPED>{ELSE}                         { printf("LEX:ELSE_BLOCK\n"); BEGIN(IF_BLOCK);     } // return ELSE;              }
<ESCAPED>{ELSEIF}                       { printf("LEX:ELSEIF\n"); BEGIN(IF_BLOCK);         } // return ELSEIF;            }
<ESCAPED>{FOREACHELSE}                  { printf("LEX:FOREACHELSE\n"); BEGIN(IF_BLOCK);    } // return FOREACHELSE;       }
<ESCAPED>{FOREACH}                      { printf("LEX:FOREACH\n"); BEGIN (IF_BLOCK);       } // return FOREACH;           }
<ESCAPED,IF_BLOCK>{END_ELSE}            { printf("LEX:ELSE_BLOCK\n"); BEGIN(ESCAPED);      } // return ELSE;              }
<ESCAPED,IF_BLOCK>{END_ELSEIF}          { printf("LEX:END_ELSEIF\n"); BEGIN(ESCAPED);      } // return ELSEIF;            }
<ESCAPED,IF_BLOCK>{END_FOREACHELSE}     { printf("LEX:FOREACHELSE\n"); BEGIN(ESCAPED);     } // return FOREACHELSE;       }
<ESCAPED,IF_BLOCK>{END_FOREACH}         { printf("LEX:FOREACH\n"); BEGIN(ESCAPED);         } // return FOREACH;           }
<ESCAPED,IF_BLOCK>{CONST_ID}            { printf("LEX:[CONST_ID:%s]\n", yytext);           return CONST_ID;               }
<ESCAPED,IF_BLOCK>{FUNC}                { printf("LEX:[FUNC:%s]\n", yytext);               } // return FUNC;              }
<ESCAPED,IF_BLOCK>{IDENTIFIER}          { printf("LEX:[IDENTIFIER:%s]\n", yytext);         return IDENTIFIER;             }
<ESCAPED,incl>[ \t]*                    { /* eat the whitespace */                                                        }
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
                                            printf("<<EOF>>\n");
                                            return END_OF_FILE;
                                            // if ( !end && --include_stack_ptr < 0 )
                                            // {
                                            //     return END_OF_FILE;
                                            //     yyterminate();
                                            // }
                                            // else
                                            // {
                                            //     yy_delete_buffer( YY_CURRENT_BUFFER );
                                            //     yy_switch_to_buffer(
                                            //     include_stack[include_stack_ptr] );
                                            // }
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
