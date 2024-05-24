%{
	#include "stext.tab.h"
	int yyerror(char *s);
	extern char *yytext;
	int yylex();


%}


TEXT                  [A-Za-z0-9]+\n
NOT_TEXT					[^a-z0-9]


%%




{TEXT} { printf("TEXT %s", yylex); return TEXT; }
{NOT_TEXT} { printf("NOT_TEXT %s", yylex); return TEXT; }
.	yyerror("invalid character");

%%

 int  main()
 {
	unsigned char c = 1;
	while(c)
	{
		yylex();
		if(strlen(yytext) < 1)
		{
			c = 0;
			break;
		}
	}
 }

int yywrap(void)
{
	return 1;
}