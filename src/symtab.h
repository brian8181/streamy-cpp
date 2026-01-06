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
    struct node* prev;
} node;


typedef struct binary_node
{
    void* data;
    struct node* left;
    struct node* right;
} binary_node;

typedef struct tree_node
{
    void* data;
    int count;
    struct tree_node* nodes;
} tree_node;


typedef struct map_node
{
    int key;
    char*name;
    symbol* sym;
} map_node;

typedef struct object
{
    char* fields[255];
    symbol symbols[255];
    struct node* next;
} object;



void init_root();

void init_symtable();
void add_symbol(const char* id_cstr, const char* val_cstr);
void remove_symbol(const char* cstr);
void clear_symbols();
symbol* find_symbol(const char* cstr);
node* find_tail();

#endif
