/* the "incl" state is used for picking up the name
* of an include file
*/
%x incl
%{
    #define MAX_INCLUDE_DEPTH 10
    YY_BUFFER_STATE include_stack[MAX_INCLUDE_DEPTH];
    int pstack = 0;


%}

%%


include             { BEGIN(incl); }
[a-z]+              { ECHO; }
[^a-z\n]*\n?        { ECHO; }
<incl>[ \t]*        { /* eat whitespace */ }
<incl>[^ \t\n]+     {
                        /* include file name */
                        if ( pstack >= MAX_INCLUDE_DEPTH )
                        {
                            fprintf( stderr, "error: includes nested too deeply" );
                            exit( 1 );
                        }
                        include_stack[pstack++] = YY_CURRENT_BUFFER;

                        // char* s = yytext;
                        // int len = strlen(yytext);
                        // int i = 0;
                        // while( i < len )
                        // {
                        //     if(yytext[i] == '\n')
                        //         yytext[i] = ' ';
                        //     ++i;
                        //     //printf("%s", yytext[i]);
                        // }

                        yyin = fopen( s, "r" );
                        if ( ! yyin )
                        {
                            printf( "error: could not open file, %s", yytext );
                        }

                        yy_switch_to_buffer( yy_create_buffer( yyin, YY_BUF_SIZE ) );
                        BEGIN(INITIAL);
                    }
<<EOF>>             {
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

%%

void rm_newline(char* s)
{
    int len = strlen(s);
    if( s[len-1] == '\n' )
        s[len-1] = '\0';
}

int yywrap(void)
{
    return 1;
}

int main(int argc, char** argv)
{
    /* skip over program name */
    ++argv, --argc;

    if ( argc > 0 )
    {
        yyin = fopen( argv[0], "r" );
    }
    else
    {
        yyin = stdin;
    }
    yylex();
}
