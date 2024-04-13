%option noyywrap nodefault yylineno case-insensitive
/* the symbol table */
%{
    struct symbol
    {
        char *name;
        struct ref *reflist;
    };

    /* a word */
    struct ref
    {
        struct ref *next;
        char *filename;
        int flags;
        int lineno;
    };

    /* simple symt ab of fixed size */
    #define NHASH 9997
    struct symbol symtab[NHASH];
    struct symbol *lookup(char*);
    void addref(int, char*, char*,int);
    char *curfilename;
    /* name of current input file */
%}
%%

%%
/* rules for concordance generator */
/* skip common words */
a |
an |
and |
are |
as |
at |
be |
but |
for |
in |
is |
it |
of |
on |
or |
that |
the |
this |
to
/* ignore */
[a-z]+(\'(s|t))? { addref(yylineno, curfilename, yytext, 0); }
.|\n
%%
{ addref(yylineno, curfilename, yytext, 0); }
