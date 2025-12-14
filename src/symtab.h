#ifndef _SYMTAB_H_
#define _SYMTAB_H_
extern "C"
{
    void add_symbol(const char* id_cstr, const char* val_cstr);
    void remove_symbol(const char* cstr);
    void clear_symbols();
    void* find_symbol(const char* cstr);
}

#endif
