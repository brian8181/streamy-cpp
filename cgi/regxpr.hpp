#ifndef _REGEXPR_HPP
#define _REGEXPR_HPP

#include <string>

using std::string;


string s1 = R"([-!"#$%&'()*+,./:;<=>?@[\\\]^_`{|}~])";
string punct = R"([-!"#%&'()*,./:;?@[\\\]_{}])"; //ascii
string sybols = R"([$+<=>^`|~])"; //ascii
string name_exp = "[A-Za-z]+\\w*";
string var = "\\{\\s*\\$(" + name_exp + ")\\s*\\}";

#endif