#ifndef _REGEXPR_HPP
#define _REGEXPR_HPP

#include <string>
#include <map>

using namespace std;

const string ESCAPE = "\\{\\$?(.*?)\\}";
const string ESCAPE2 = "\\{\\(.*)\\}";
const string COMMENT = "\\{\\s*\\*[\\w\\s\\p]*\\*\\s*\\}";
const string CONFIG = "\\{\\s*#([A-Aa-z]\\w*)#\\s*\\}";
const string VARIABLE = "\\{\\$(.*?)\\}";
const string VARIABLE2 = "\\$(.*?)";
const string INCLUDE = "\\{\\include file=\"(.*?)\"\\}";
const string CONFIG_LOAD = "\\{\\config_load file=\"(.*?)\"\\}";

const string COMMENT_OR_VARIABLE = "((" + COMMENT + ")" +  "|" + "(" + VARIABLE + "))";

#endif