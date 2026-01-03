#ifndef _SYMTAB_H_
#define _SYMTAB_H_

typedef struct symbol
{
    char* id;
    char* stype_modifiers;
    char* stype;
    void* pval;
} symbol;

typedef struct node
{
    symbol* val;
    struct node* next;
} node;

void init(symbol* s);
void add_symbol(const char* id_cstr, const char* val_cstr);
void remove_symbol(const char* cstr);
void clear_symbols();
symbol* find_symbol(const char* cstr);
node* find_tail();

#endif
