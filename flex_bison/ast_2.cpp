%%
calclist: /* nothing */
| calclist exp EOL {
printf("= %4.4g\n", eval($2));
treefree($2);
evaluate and print the AST
free up the AST

}
printf("> ");
| calclist EOL { printf("> "); } /* blank line or a comment */
;
exp: factor
| exp '+' factor { $$ = newast('+', $1,$3); }
| exp '-' factor { $$ = newast('-', $1,$3);}
;
factor: term
| factor '*' term { $$ = newast('*', $1,$3); }
| factor '/' term { $$ = newast('/', $1,$3); }
;
term: NUMBER { $$ = newnum($1); }
| '|' term { $$ = newast('|', $2, NULL); }
| '(' exp ')' { $$ = $2; }
| '-' term { $$ = newast('M', $2, NULL); }
;
%%