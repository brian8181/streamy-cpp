
extern "C" {
    #include "symtab.h"
}
#include <iostream>
#include <iomanip>
#include <string>
#include <sstream>
#include <map>
#include <cstring>

using std::string;
using std::endl;

static std::map<std::string, struct symbol> symtab;

void add_symbol(const char* id_cstr, const char* val_cstr)
{
    symbol s;
    s.id = (char*)malloc( (sizeof(char) * strlen(id_cstr)) + 1 );
    strcpy(s.id, id_cstr);
    s.type = 0;
    symtab[s.id] = s;
}

void remove_symbol(const char* cstr)
{
    string s(cstr);
    auto v = symtab.find(s);
    free((*v).second.id);
    symtab.erase(v);
}

void clear_symbols()
{
    auto end = symtab.end();
    for(auto iter = symtab.begin(); iter != end; ++iter)
        free((*iter).second.id);
    symtab.clear();
}

void* find_symbol(const char* cstr)
{
    string s(cstr);
    auto v = symtab.find(s);
    return (v == symtab.end()) ? (void*)0 : (void*)0;
}

// void print(const symbol& s, /* out */ std::stringstream ss)
// {
//     ss  << "symbol" << endl << "{" << endl
//         << "\tname: " << s.id << endl
//         << "\ttype: " << s.stype << endl
//         << "\tvalue: " << (long*)s.pval << endl
//         << "\taddress: " << std::hex << (long*)s.pval << endl
//         << "}" << endl;
//}
