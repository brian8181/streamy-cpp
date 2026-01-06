%{
    #define MAX_INCLUDE_DEPTH 10
    #include <stdio.h>
    #include <string.h>
    #include "parser.tab.h"


    YY_BUFFER_STATE include_stack[MAX_INCLUDE_DEPTH];
    int include_stack_ptr = 0;
    int yylex(void);
    int yyerror(char* s);
    int fileno(FILE* f);

    extern char buf[100];
    extern char *s;
    char* strdup(char* str);
%}

END_OF_FILE         \0
IDENTIFIER          _*[A-Za-z][A-Za-z0-9_]*
SYMBOL              \${IDENTIFIER}
CONST_ID            #{IDENTIFIER}#
QUALAFIED_ID        {SYMBOL}(("."|"->"){IDENTIFIER})+
FUNC                {IDENTIFIER}+[ /t]*\([^)]*\)
ARRAY               {SYMBOL}\[[^\]]\]
COMMENT             \{[ \t]*\*[^*}]*\*[ \t]*\}
FILE_NAME           [A-Za-z0-9_.-~+#@]
IF                  if
END_IF              "\{/if\}"
FOREACH             foreach
END_FOREACH         "/foreach"
FOREACHELSE         foreachelse
END_FOREACHELSE     "/foreachelse"
ELSE                "else"
END_ELSE            "/else"
ELSEIF              "elseif"
END_ELSEIF          "/elseif"
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
INCLUDE             include
REQUIRE             require
CONFIG_LOAD         config_load
INSERT              insert
FILE_ATTRIB         file
ASSIGN              assign
VAR_ATTRIB          var
VALUE_ATTRIB        value

%x DOUBLE_QUOTED
%x SINGLE_QUOTED
%x ESCAPED
%x IF_BLOCK
%x IF_CONDITION
%x INCLUDING
%x OFF
%%

<INITIAL>{COMMENT}                      { printf("LEX:COMMENT\n");    /* eat up comment */                               }
<INITIAL>{LBRACE}                       { printf("LEX:LBRACE\n"); printf("LEX:BEGIN ESCAPED\n"); BEGIN(ESCAPED); return LBRACE; }
<ESCAPED>{RBRACE}                       { printf("LEX:RBRACE\n");  printf("LEX:BEGIN INITIAL\n"); BEGIN(INITIAL); return RBRACE; }
<ESCAPED>{INCLUDE}                      { printf("LEX:INCLUDE\n"); /*printf("LEX:BEGIN INCLUDE\n"); BEGIN(INCLUDING);*/ yylval.sval = strdup(yytext); return INCLUDE; }
<ESCAPED>{SINGLE_QUOTE}                 { printf("LEX:BEGIN_SINGLE_QUOTED\n"); BEGIN(SINGLE_QUOTED); s = buf;            }
<SINGLE_QUOTED>\\n                      { *s++ = '\n';                                                                   }
<SINGLE_QUOTED>\\t                      { *s++ = '\t';                                                                   }
<SINGLE_QUOTED>\\\"                     { *s++ = '\"';                                                                   }
<SINGLE_QUOTED>{SINGLE_QUOTE}           {
                                            printf("LEX:STRING_LITERAL=%s\n", s);
                                            *s = 0;
                                            printf("LEX:SINGLE_QUOTE\n");
                                            printf("LEX:BEGIN ESCAPED\n");
                                            BEGIN(ESCAPED);
                                            return STRING_LITERAL;
                                        }
<SINGLE_QUOTED>[\n}]                    { printf("LEX: missing closing quote"); exit(1);                                 }
<SINGLE_QUOTED>{FILE_NAME}              { *s++ = *yytext;                                                                }
<ESCAPED>{DOUBLE_QUOTE}                 { printf("LEX:BEGIN_DOUBLE_QUOTED\n"); BEGIN(DOUBLE_QUOTED); s = buf;            }
<DOUBLE_QUOTED>\\n                      { *s++ = '\n';                                                                   }
<DOUBLE_QUOTED>\\t                      { *s++ = '\t';                                                                   }
<DOUBLE_QUOTED>\\\'                     { *s++ = '\'';                                                                   }
<DOUBLE_QUOTED>{DOUBLE_QUOTE}           {
                                            printf("LEX:STRING_LITERAL=%s\n", s);
                                            *s = 0;
                                            printf("LEX:DOUBLE_QUOTE\n");
                                            printf("LEX:BEGIN ESCAPED\n");
                                            BEGIN(ESCAPED);
                                            return STRING_LITERAL;
                                        }
<DOUBLE_QUOTED>[\n}]                    { printf("LEX: missing closing quote\n"); exit(1);                                }
<DOUBLE_QUOTED>{FILE_NAME}              { *s++ = *yytext;                                                                 }
<ESCAPED>{NUMERIC_LITERAL}              {
                                            printf("LEX:NUMERIC_LITERAL=%s\n", yytext);
                                            yylval.sval = strdup(yytext);
                                            return NUMERIC_LITERAL;
                                        }
<ESCAPED>{ASSIGN}                       { printf("LEX:ASSIGN\n"); yylval.sval = strdup(yytext);       return ASSIGN;              }
<ESCAPED>{REQUIRE}                      { printf("LEX:REQUIRE\n"); yylval.sval = strdup(yytext);       return REQUIRE;            }
<ESCAPED>{CONFIG_LOAD}                  { printf("LEX:CONFIG_LOAD\n"); yylval.sval = strdup(yytext);  return CONFIG_LOAD;         }
<ESCAPED>{INSERT}                       { printf("LEX:INSERT\n"); yylval.sval = strdup(yytext);  return INSERT;         }
<ESCAPED>{FILE_ATTRIB}                  { printf("LEX:FILE_ATTRIB\n"); yylval.sval = strdup(yytext);  return FILE_ATTRIB;         }
<ESCAPED>{VAR_ATTRIB}                   { printf("LEX:VAR_ATTRIB\n"); yylval.sval = strdup(yytext);   return VAR_ATTRIB;          }
<ESCAPED>{VALUE_ATTRIB}                 { printf("LEX:VALUE_ATTRIB\n"); yylval.sval = strdup(yytext); return VALUE_ATTRIB;        }
<ESCAPED>{NOT}                          { printf("LEX:NOT\n");                            return NOT;                     }
<ESCAPED>{AND}                          { printf("LEX:AND\n");                            return AND;                     }
<ESCAPED>{OR}                           { printf("LEX:OR\n");                             return OR;                      }
<ESCAPED>{LESS_THAN}                    { printf("LEX:LESS_THAN\n");                      return LESS_THAN;               }
<ESCAPED>{LESS_THAN_EQUAL}              { printf("LEX:LESS_THAN_EQUAL\n");                return LESS_THAN_EQUAL;         }
<ESCAPED>{GREATER_THAN}                 { printf("LEX:GREATER_THAN\n");                   return GREATER_THAN;            }
<ESCAPED>{GREATER_THAN_EQUAL}           { printf("LEX:GREATER_THAN_EQUAL\n");             return GREATER_THAN_EQUAL;      }
<ESCAPED>{SLASH}                        { printf("LEX:SLASH\n");                          } // return SLASH;              }
<ESCAPED>{BACK_SLASH}                   { printf("LEX:BACK_SLASH\n");                     } // return BACK_SLASH;         }
<ESCAPED>{VBAR}                         { printf("LEX:VBAR\n");                           return VBAR;                    }
<ESCAPED>{AMPERSAND}                    { printf("LEX:AMPERSAND\n");                      return AMPERSAND;               }
<ESCAPED>{AT}                           { printf("LEX:AT\n");                             } // return AT;                 }
<ESCAPED>{PLUS}                         { printf("LEX:PLUS\n");                           return PLUS;                    }
<ESCAPED>{MINUS}                        { printf("LEX:MINUS\n");                          return MINUS;                   }
<ESCAPED>{ASTERIK}                      { printf("LEX:ASTERIK\n");                        return ASTERIK;                 }
<ESCAPED>{EQUAL}                        { printf("LEX:EQUAL\n"); return EQUAL;                   }
<ESCAPED>{NOT_EQUAL}                    { printf("LEX:NOT_EQUAL\n");                      return NOT_EQUAL;               }
<ESCAPED>{DOT}                          { printf("LEX:DOT\n");                            return DOT;                     }
<ESCAPED>{INDIRECT_MEMBER}              { printf("LEX:INDIRECT_MEMBER\n");                return INDIRECT_MEMBER;         }
<ESCAPED>{PERCENT}                      { printf("LEX:PERCENT\n");                        return PERCENT;                 }
<ESCAPED>{COLON}                        { printf("LEX:COLON\n");                          return COLON;                   }
<ESCAPED>{LBRACKET}                     { printf("LEX:LBRACKET\n");  return LBRACKET;                                     }
<ESCAPED>{RBRACKET}                     { printf("LEX:RBRACKET\n");  return RBRACKET;                                     }
<ESCAPED>{LPAREN}                       { printf("LEX:LPAREN\n");                         return LPAREN;                  }
<ESCAPED>{RPAREN}                       { printf("LEX:RPAREN\n");                         return RPAREN;                  }
<ESCAPED>{SEMI_COLON}                   { printf("LEX:SEMI_COLON\n");                     return SEMI_COLON;              }
<ESCAPED>{END_IF}                       { printf("LEX:END_IF\n"); BEGIN(ESCAPED);         } // return IF;                 }
<IF_CONDITION>{RBRACE}                  { printf("LEXIF_BLOCK"); BEGIN(IF_BLOCK);                                         }
<IF_CONDITION>[^}]                      { ECHO;                                                                           }
<IF_BLOCK>[^{]                          { ECHO;                                                                           }
<ESCAPED>{IF}                           { printf("LEX:IF_BLOCK\n"); BEGIN(IF_BLOCK);       } // return IF;                }
<ESCAPED>{ELSE}                         { printf("LEX:ELSE_BLOCK\n"); BEGIN(IF_BLOCK);     } // return ELSE;              }
<ESCAPED>{ELSEIF}                       { printf("LEX:ELSEIF\n"); BEGIN(IF_BLOCK);         } // return ELSEIF;            }
<ESCAPED>{FOREACHELSE}                  { printf("LEX:FOREACHELSE\n"); BEGIN(IF_BLOCK);    } // return FOREACHELSE;       }
<ESCAPED>{FOREACH}                      { printf("LEX:FOREACH\n"); BEGIN (IF_BLOCK);       } // return FOREACH;           }
<ESCAPED>{END_ELSE}                     { printf("LEX:ELSE_BLOCK\n"); BEGIN(ESCAPED);      } // return ELSE;              }
<ESCAPED>{END_ELSEIF}                   { printf("LEX:END_ELSEIF\n"); BEGIN(ESCAPED);      } // return ELSEIF;            }
<ESCAPED>{END_FOREACHELSE}              { printf("LEX:FOREACHELSE\n"); BEGIN(ESCAPED);     } // return FOREACHELSE;       }
<ESCAPED>{END_FOREACH}                  { printf("LEX:FOREACH\n"); BEGIN(ESCAPED);         } // return FOREACH;           }
<ESCAPED>{CONST_ID}                     { printf("LEX:[CONST_ID:%s]\n", yytext); yylval.sval = strdup(yytext); return CONST_ID;   }
<ESCAPED>{FUNC}                         { printf("LEX:[FUNC:%s]\n", yytext); yylval.sval = strdup(yytext); return FUNC;           }
<ESCAPED>{SYMBOL}                       {
                                            printf("LEX:[SYMBOL:%s]\n", yytext);
                                            yylval.sval = strdup(yytext);
                                            return SYMBOL;
                                        }
<ESCAPED>[ \t]*                         { /* eat the whitespace */ }
<OFF>[^ \t\n]+                          {
                                            // printf("LEX:INCLUDING filename\n");
                                            // /* got the include file name */
                                            // if ( include_stack_ptr >= MAX_INCLUDE_DEPTH )
                                            // {
                                            //     fprintf( stderr, "Includes nested too deeply" );
                                            //     exit( 1 );
                                            // }
                                            // include_stack[include_stack_ptr++] = YY_CURRENT_BUFFER;

                                            // yyin = fopen( yytext, "r" );
                                            // if ( ! yyin )
                                            // {
                                            //     printf( "could not open file, %s", yytext );
                                            // }

                                            // yy_switch_to_buffer( yy_create_buffer( yyin, YY_BUF_SIZE ) );
                                            BEGIN(ESCAPED);
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

char* strdup(char* s)
{
    char* dup = (char*)malloc((strlen(s) * sizeof(char)) + 1);
    strcpy(dup, s);
    return dup;
}

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
