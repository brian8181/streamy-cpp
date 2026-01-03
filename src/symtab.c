
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "symtab.h"
static node* g_head;

void init_streamy_symtable()
{
   symbol streamy_init_object;
   streamy_init_object.id = "$streamy";
   streamy_init_object.stype = "object";
   streamy_init_object.stype_modifiers = "static";
   streamy_init_object.pval = 0;

   g_head = (node*)malloc(sizeof(node));
   g_head->val = &streamy_init_object;
   g_head->next = 0;
}

void add_symbol(const char* id_cstr, const char* val_cstr)
{
    // create symbol
    symbol* s = (symbol*)malloc( sizeof(symbol) );
    s->id = (char*)malloc( (sizeof(char) * strlen(id_cstr)) + 1 );
    s->pval = (char*)malloc( (sizeof(char) * strlen(val_cstr)) + 1 );
    // add node
    node* tail = find_tail();
    tail->next = (node*)malloc(sizeof(node));
    tail = tail->next;
    tail->val = s;
    tail->next = 0;
}

void remove_symbol(const char* cstr)
{
    node* cur = g_head;
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

void clear_symbols()
{
    node* cur = g_head;
    while(cur != 0)
    {
        node* tmp = cur->next;
        free(cur);
        cur = tmp;
    }
}

symbol* find_symbol(const char* cstr)
{
    node* cur = g_head;
    while(cur->next != 0)
    {
        symbol* s = cur->val;
        if(strcmp((char*)s->pval, cstr))
            return s;
        cur = cur->next;
    }
    return 0;
}

node* find_tail()
{
    node* cur = g_head;
    while(cur->next != 0);
    return cur;
}
