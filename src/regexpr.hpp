#ifndef _REGEXPR_HPP
#define _REGEXPR_HPP

#include <string>
#include <map>

using namespace std;

// https://cplusplus.com/reference/regex/ECMAScript/

string s1 = R"([-!"#$%&'()*+,./:;<=>?@[\\\]^_`{|}~])";
string punct = R"([-!"#%&'()*,./:;?@[\\\]_{}])"; //ascii
string symbols = R"([$+<=>^`|~])"; //ascii
string name_exp = "[A-Za-z]+\\w*";
string var = "\\{\\s*\\$(" + name_exp + ")\\s*\\}";
string command = "(config_load|include|insert)\\sfile='(.*)'";

const string COMMAND = "(config_load|include|insert|literal|strip|capture|section|assign|debug|eval|fetch|math)";
const string ESCAPE = "\\{\\$?(.*?)\\}";
const string ESCAPE2 = "\\{\\(.*)\\}";
const string COMMENT = "\\n?\\{\\s*\\*[\\w\\s\\p]*\\*\\s*\\}\\n?";
const string CONFIG = "\\{\\s*#([A-Aa-z]\\w*)#\\s*\\}";
const string SYMBOL_NAME = "\\b[_.~]*[A-Za-z][\\w_.-~]*\\b";
const string VARIABLE = "\\{\\s*\\$(" + SYMBOL_NAME + ")\\s*\\}";
const string VARIABLE2 = "\\$(" + SYMBOL_NAME + ")";
// todo default values ...
const string INCLUDE = "\\{\\s*\\include file\\s*=\\s*\"(.*?)\"\\s*\\}";
const string CONFIG_LOAD = "\\{\\config_load file=\"(.*?)\"\\}";
//
const string COMMENT_OR_VARIABLE = "((" + COMMENT + ")" +  "|" + "(" + VARIABLE + "))";

// from smarty::load_config
const string LOAD_CONFIG_VALUE = "((\\w+)|('(\\w+)')|(\\\"(\\w+)\\\"))";
const string LOAD_CONFIG_NAME = "([A-Za-z]+\\w*)";

//todo ...
const string string_literal1 = "(\\\"[\\w\\.]*\\\")"; // "ABC"
const string string_literal2 = "(\\'[\\w*\\.]*\\')";  // 'ABC'
const string string_literal = string_literal1 + "|" + string_literal2;

const string IF_KEYWORD = "\\{if\\(" + VARIABLE + ")\\}";
const string ENDIF_KEYWORD = "\\{/if\\s+}";
const string HTML = IF_KEYWORD + "([\\w<=>]*)" + ENDIF_KEYWORD;
const string ELSE_KEYWORD = "\\{if\\s+\\(.*?)\\}";
const string ARRAY_KEYWORD = "array\\(" + string_literal1 + "|" + string_literal1 + "\\)";

#endif
