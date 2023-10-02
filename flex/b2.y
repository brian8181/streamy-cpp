input:
%empty
| input line
;
line:
’\n’
| exp ’\n’
;
exp:
NUM
| exp exp ’+’
| exp exp ’-’
| exp exp ’*’
| exp exp ’/’
| exp exp ’^’
| exp ’n’
;
%%
{ printf ("%.10g\n", $1); }
{ $$ = $1 + $2;
}
{ $$ = $1 - $2;
}
{ $$ = $1 * $2;
}
{ $$ = $1 / $2;
}
{ $$ = pow ($1, $2); }
{ $$ = -$1;
}
/* Exponentiation */
/* Unary minus
*/