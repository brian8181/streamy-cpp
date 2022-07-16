#ifndef _REGEXPR_HPP
#define _REGEXPR_HPP

#include <string>
#include <map>

using namespace std;

const string ESCAPE = "\\{\\$?(.*?)\\}";
const string COMMENT = ".*";
const string VARIABLE = "\\{\\$(.*?)\\}";
const string INCLUDE = "\\{\\include file=\"(.*?)\"\\}";
const string CONFIG = ".*";


#endif