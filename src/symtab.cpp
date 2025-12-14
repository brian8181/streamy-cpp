
extern "C" {
    #include "symtab.h"
}
#include <string>
#include <map>

using std::string;

static std::map<std::string, std::string> stab;

void add_symbol(const char* id_cstr, const char* val_cstr)
{
    string id(id_cstr);
    string val(val_cstr);

    stab[id] = val;
}

void remove_symbol(const char* cstr)
{
    string s(cstr);
    auto v = stab.find(s);
    stab.erase(v);
}

void clear_symbols()
{
    stab.clear();
}

void* find_symbol(const char* cstr)
{
    string s(cstr);
    auto v = stab.find(s);
    return (v == stab.end()) ? (void*)0 : (void*)0;
}
