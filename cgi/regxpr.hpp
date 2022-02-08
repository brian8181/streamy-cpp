#ifndef _REGEXPR_HPP
#define _REGEXPR_HPP

#include <string>

using std::string;

string name_exp = "[A-Za-z]+\\w*";
string var = "\\{\\s*\\$(" + name_exp + ")\\s*\\}";

#endif