%{
    #include <math.h>
%}

%s expect

%%

expect-floats        BEGIN(expect);

<expect>[0-9]+.[0-9]+   {
                            printf( "found a float, = %f\n",
                            atof( yytext ) );
                        }
<expect>\n   {

                BEGIN(INITIAL);
            }
[0-9]+      {
                printf( "found an integer, = %d\n",
                atoi( yytext ) );
            }
"."         printf( "found a dot\n" );

%%

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