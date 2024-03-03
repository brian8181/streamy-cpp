/* interface to the lexer */
extern int yylineno; /* from lexer */
void yyerror(char *s, ...);
/* symbol table */
struct symbol {
/* a variable name */
char *name;
double value;
struct ast *func;
/* stmt for the function */
struct symlist *syms; /* list of dummy args */
};
/* simple symtab of fixed size */
#define NHASH 9997
struct symbol symtab[NHASH];
struct symbol *lookup(char*);
/* list of symbols, for an argument list */
struct symlist {
struct symbol *sym;
struct symlist *next;
};