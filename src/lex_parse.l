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
ID                  \${IDENTIFIER}
CONST_ID            #{IDENTIFIER}#
QUALAFIED_ID        {ID}(("."|"->"){IDENTIFIER})+
FUNC                {IDENTIFIER}+[ /t]*\([^)]*\)
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

%x QUOTED
%x ESCAPED
%x IF_BLOCK
%x IF_CONDITION
%x incl
%x OFF
%%

<INITIAL>{COMMENT}                      { /* eat up comment */                                                           }
<INITIAL>{LBRACE}                       { printf("BEGIN ESCAPED\n   "); BEGIN(ESCAPED);                                   }
<ESCAPED,IF_BLOCK>{RBRACE}              { printf("BEGIN INITIAL\n"); BEGIN(INITIAL);                                      } // return RBRACE;
<OFF>{INCLUDE}                          { printf(" LEX:INCLUDE "); BEGIN(incl);                                          } // turned OFF for now, need to debug!
<ESCAPED>{SINGLE_QUOTE}                 { printf("BEGIN QUOTED\n"); BEGIN(QUOTED); s = buf;                               }
<QUOTED>\\n                             { *s++ = '\n';                                                                   }
<QUOTED>\\t                             { *s++ = '\t';                                                                   }
<QUOTED>\\\"                            { *s++ = '\"';                                                                   }
<QUOTED>{SINGLE_QUOTE}                  {
                                            printf("BEGIN ESCAPED\n"); *s = 0;
                                            BEGIN ESCAPED; printf(" LITERAL='%s'\n", buf);
                                            return STRING_LITERAL;
                                        }
<QUOTED>[\n}]                           { printf(" LEX invalid ESCAPED,QUOTED"); exit(1);                                 }
<QUOTED>.                               { *s++ = *yytext;                                                                 }
<ESCAPED,IF_BLOCK>{UTILITY}             { printf(" LEX:UTILITY ");                                                        }
<ESCAPED,IF_BLOCK>{MODIFIER}            { printf(" LEX:MODIFIER ");                                                       }
<ESCAPED,IF_BLOCK>{ACCSESSORS}          { printf(" LEX:ACCSESSORS ");                                                     }
<ESCAPED,IF_BLOCK>{CONFIG}              { printf(" LEX:CONFIG ");                                                         }
<ESCAPED,IF_BLOCK>{CONFIG_LOAD}         { printf(" LEX:CONFIG_LOAD ");                    return CONFIG_LOAD;             }
<ESCAPED,IF_BLOCK>{FILE_ATTRIB}         { printf(" LEX:FILE_ATTRIB ");                    return FILE_ATTRIB;             }
<ESCAPED,IF_BLOCK>{HTML}                { printf(" LEX:HTML ");                           } // return HTTP;               }
<ESCAPED,IF_BLOCK>{HTTP}                { printf(" LEX:HTTP ");                           } // return HTTP;               }
<ESCAPED,IF_BLOCK>{NOT}                 { printf(" LEX:NOT ");                            } // return NOT;                }
<ESCAPED,IF_BLOCK>{AND}                 { printf(" LEX:AND ");                            } // return AND;                }
<ESCAPED,IF_BLOCK>{OR}                  { printf(" LEX:OR ");                             } // return OR;                 }
<ESCAPED,IF_BLOCK>{LESS_THAN}           { printf(" LEX:LESS_THAN ");                      } // return LESS_THAN;          }
<ESCAPED,IF_BLOCK>{LESS_THAN_EQUAL}     { printf(" LEX:LESS_THAN_EQUAL ");                } // return LESS_THAN_EQUAL;    }
<ESCAPED,IF_BLOCK>{GREATER_THAN}        { printf(" LEX:GREATER_THAN ");                   } // return GREATER_THAN;       }
<ESCAPED,IF_BLOCK>{GREATER_THAN_EQUAL}  { printf(" LEX:GREATER_THAN_EQUAL ");             } // return GREATER_THAN_EQUAL; }
<ESCAPED,IF_BLOCK>{SLASH}               { printf(" LEX:SLASH ");                          } // return SLASH;              }
<ESCAPED,IF_BLOCK>{BACK_SLASH}          { printf(" LEX:BACK_SLASH ");                     } // return BACK_SLASH;         }
<ESCAPED,IF_BLOCK>{VBAR}                { printf(" LEX:VBAR ");                           } // return VBAR;               }
<ESCAPED,IF_BLOCK>{AMPERSAND}           { printf(" LEX:AMPERSAND ");                      } // return AMPERSAND;          }
<ESCAPED,IF_BLOCK>{AT}                  { printf(" LEX:AT ");                             } // return AT;                 }
<ESCAPED,IF_BLOCK>{PLUS}                { printf(" LEX:PLUS ");                           } // return PLUS;               }
<ESCAPED,IF_BLOCK>{MINUS}               { printf(" LEX:MINUS ");                          } // return MINUS;              }
<ESCAPED,IF_BLOCK>{ASTERIK}             { printf(" LEX:ASTERIK ");                        } // return ASTERIK;            }
<ESCAPED,IF_BLOCK>{EQUAL}               { printf(" LEX:EQUAL ");                          return EQUAL;                   }
<ESCAPED,IF_BLOCK>{NOT_EQUAL}           { printf(" LEX:NOT_EQUAL ");                      return NOT_EQUAL;               }
<ESCAPED,IF_BLOCK>{DOT}                 { printf(" LEX:DOT ");                            return DOT;                     }
<ESCAPED,IF_BLOCK>{PERCENT}             { printf(" LEX:PERCENT ");                        } // return PERCENT;            }
<ESCAPED,IF_BLOCK>{COLON}               { printf(" LEX:COLON ");                          } // return COLON;              }
<ESCAPED,IF_BLOCK>{LBRACKET}            { printf(" LEX:LBRACKET ");                       } // return LBRACKET;           }
<ESCAPED,IF_BLOCK>{RBRACKET}            { printf(" LEX:RBRACKET ");                       } // return RBRACKET;           }
<ESCAPED,IF_BLOCK>{LPAREN}              { printf(" LEX:LPAREN ");                         } // return RPAREN;             }
<ESCAPED,IF_BLOCK>{RPAREN}              { printf(" LEX:RPAREN ");                         } // return LPAREN;             }
<ESCAPED,IF_BLOCK>{SEMI_COLON}          { printf(" LEX:SEMI_COLON ");                     } // return SEMI_COLON;         }
<ESCAPED,IF_BLOCK>{QUOTE}               { printf(" LEX:QUOTE ");                          } // return QUOTE;              }
<ESCAPED,IF_BLOCK>{SINGLE_QUOTE}        { printf(" LEX:SINGLE_QUOTE ");                   } // return SINGLE_QUOTE;       }
<ESCAPED,IF_BLOCK>{NUMBER}              { printf(" LEX:NUMBER ");                         } // return NUMBER;             }
<ESCAPED,IF_BLOCK>{END_IF}              { printf(" LEX:END_IF "); BEGIN(ESCAPED);          } // return IF;                 }
<IF_CONDITION>{RBRACE}                  { printf(" LEXIF_BLOCK"); BEGIN(IF_BLOCK);                                         }
<IF_CONDITION>[^}]                      { ECHO;                                                                           }
<IF_BLOCK>[^{]                          { ECHO;                                                                           }
<ESCAPED>{IF}                           { printf(" LEX:IF_BLOCK "); BEGIN(IF_BLOCK);       } // return IF;                 }
<ESCAPED>{ELSE}                         { printf(" LEX:ELSE_BLOCK "); BEGIN(IF_BLOCK);     } // return ELSE;               }
<ESCAPED>{ELSEIF}                       { printf(" LEX:ELSEIF "); BEGIN(IF_BLOCK);         } // return ELSEIF;             }
<ESCAPED>{FOREACHELSE}                  { printf(" LEX:FOREACHELSE "); BEGIN(IF_BLOCK);    } // return FOREACHELSE;        }
<ESCAPED>{FOREACH}                      { printf(" LEX:FOREACH "); BEGIN (IF_BLOCK);        } // return FOREACH;            }
<ESCAPED,IF_BLOCK>{END_ELSE}            { printf(" LEX:ELSE_BLOCK "); BEGIN(ESCAPED);      } // return ELSE;               }
<ESCAPED,IF_BLOCK>{END_ELSEIF}          { printf(" LEX:END_ELSEIF "); BEGIN(ESCAPED);      } // return ELSEIF;             }
<ESCAPED,IF_BLOCK>{END_FOREACHELSE}     { printf(" LEX:FOREACHELSE "); BEGIN(ESCAPED);     } // return FOREACHELSE;        }
<ESCAPED,IF_BLOCK>{END_FOREACH}         { printf(" LEX:FOREACH "); BEGIN(ESCAPED);         } // return FOREACH;            }
<ESCAPED,IF_BLOCK>{CONST_ID}            { printf(" LEX:[CONST_ID:%s] ", yytext);          return CONST_ID;                }
<ESCAPED,IF_BLOCK>{FUNC}                { printf(" LEX:[FUNC:%s] ", yytext);              } // return FUNC;               }
<ESCAPED,IF_BLOCK>{QUALAFIED_ID}        { printf(" LEX:[QUALAFIED_ID:%s] ", yytext);      return QUALAFIED_ID;            }
<ESCAPED,IF_BLOCK>{ID}                  { printf(" LEX:[ID:%s] ", yytext);                return ID;                      }
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
                                            printf("\n<<EOF>>\n");
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
