
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "symtab.h"

// root sym_table
static symbol_tab* symtab;

void init_symtable()
{
   symbol* streamy_init_object = (symbol*)malloc(sizeof(symbol));
   // todo allocate strings ...
   streamy_init_object->id = "$streamy";
   streamy_init_object->stype = "object";
   streamy_init_object->stype_modifiers = "static";
   streamy_init_object->pval = 0;

   symtab = (symbol_tab*)malloc(sizeof(symbol_tab));
   symtab->head = (node*)malloc(sizeof(node));
   symtab->head->val = streamy_init_object;
   symtab->head->next = 0;
}

void init_sub_table(symbol_tab* parent)
{
    symbol_tab* symtab = (symbol_tab*)malloc( sizeof(symbol_tab) );
    symtab->head = 0;
    // todo!
    //symtab->parent = parent->head;
}

void add_symbol(symbol_tab* stab, const char* id_cstr, const char* val_cstr)
{
    // create symbol
    symbol* sym = (symbol*)malloc( sizeof(symbol) );
    sym->id = (char*)malloc( strlen(id_cstr) + 1 );
    sym->pval = (char*)malloc( strlen(val_cstr) + 1 );
    node* new_node = (node*)malloc( sizeof(node) );
    new_node->val = sym;
    // add node / symbol to tail
    node* tail = find_tail(stab);
    new_node->next = 0;
    tail->next = new_node;
}

void insert_symbol(symbol_tab* stab, const char* dst_id, const char* src_id, const char* src_val)
{
    // create symbol
    symbol* src_sym = (symbol*)malloc( sizeof(symbol) );
    src_sym->id = (char*)malloc( strlen(src_id) + 1 );
    src_sym->pval = (char*)malloc( strlen(src_val) + 1 );
    node* src_node = (node*)malloc( sizeof(node) );
    src_node->val = src_sym;
    // add node
    node* dst_node = find_node(stab, dst_id);
    src_node->next = dst_node->next;
    dst_node->next = src_node;
}

void remove_symbol(symbol_tab* stab, const char* cstr)
{
    node* cur = symtab->head;
    if(stab != 0)
        cur = stab->head;
    while(cur->next != 0)
    {
        symbol* s = cur->next->val;
        if(strcmp((char*)s->pval, cstr))
        {
            node* tmp = cur->next->next;
            free(cur->next);
            cur->next = 0;
            cur->next = tmp;
        }
    }
}

void clear_symbols(symbol_tab* stab)
{
    node* cur = symtab->head;
    if(stab != 0)
        cur = stab->head;
    while(cur != 0)
    {
        node* tmp = cur->next;
        free(cur);
        cur = tmp;
    }
}

symbol* find_symbol(symbol_tab* stab, const char* cstr)
{
    node* cur = symtab->head;
    if(stab != 0)
        cur = stab->head;
    while(cur->next != 0)
    {
        symbol* s = cur->val;
        if(strcmp((char*)s->pval, cstr))
            return s;
        cur = cur->next;
    }
    return 0;
}

node* find_node(symbol_tab* stab, const char* cstr)
{
    node* cur = symtab->head;
    if(stab != 0)
        cur = stab->head;
    while(cur->next != 0)
    {
        symbol* s = cur->val;
        if(strcmp((char*)s->pval, cstr))
            return cur;
        cur = cur->next;
    }
    return 0;
}

node* find_tail(symbol_tab* stab)
{
    node* cur = symtab->head;
    if(stab != 0)
        cur = stab->head;
    while(cur->next != 0);
    return cur;
}
