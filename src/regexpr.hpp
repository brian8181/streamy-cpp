#ifndef _REGEXPR_HPP
#define _REGEXPR_HPP

#include <string>
#include <map>

using namespace std;

// https://cplusplus.com/reference/regex/ECMAScript/

const string s1 = R"([-!"#$%&'()*+,./:;<=>?@[\\\]^_`{|}~])";
const string punct = R"([-!"#%&'()*,./:;?@[\\\]_{}])"; //ascii
const string symbols = R"([$+<=>^`|~])"; //ascii
const string name_exp = "[A-Za-z]+\\w*";
const string var = "\\{\\s*\\$(" + name_exp + ")\\s*\\}";
const string command = "(config_load|include|insert)\\sfile='(.*)'";
const string COMMAND = "(config_load|include|insert|literal|strip|capture|section|assign|debug|eval|fetch|math)";
const string ESCAPE = "\\{\\$?(.*?)\\}";
const string ESCAPE2 = "\\{\\(.*)\\}";
const string COMMENT = "\\n?\\{\\s*\\*[\\w\\s\\p]*\\*\\s*\\}\\n?";
const string CONFIG = "\\{\\s*#([A-Aa-z]\\w*)#\\s*\\}";
const string SYMBOL_NAME = "\\b[_.~]*[A-Za-z][A-Za-z0-9_.-~]*\\b";
const string VARIABLE = "\\{\\s*\\$(" + SYMBOL_NAME + ")\\s*\\}";
const string VARIABLE2 = "\\$(" + SYMBOL_NAME + ")";
const string INCLUDE = "\\{\\s*\\include file\\s*=\\s*\"(.*?)\"\\s*\\}";
const string CONFIG_LOAD = "\\{\\config_load file=\"(.*?)\"\\}";
const string COMMENT_OR_VARIABLE = "((" + COMMENT + ")" +  "|" + "(" + VARIABLE + "))";
const string LOAD_CONFIG_VALUE = "((\\w+)|('(\\w+)')|(\\\"(\\w+)\\\"))";
const string LOAD_CONFIG_NAME = "[A-Za-z][A-Za-z0-9]*=[A-Za-z0-9]*";
const string LOAD_CONFIG_PAIR = "([A-Za-z][A-Za-z0-9]*)=([A-Za-z0-9]*)";
const string string_literal1 = "(\\\"[\\w\\.]*\\\")"; // "ABC"makes
const string string_literal2 = "(\\'[\\w*\\.]*\\')";  // 'ABC'
const string string_literal = string_literal1 + "|" + string_literal2;
const string ABC = "\\$([_.~]*[A-Za-z][\\w_.-~]*)";
const string ABC2 = "\\$\\w+";
const string TEST = "\\b[-._~]*[A-Za-z][-.~A-Za-z0-9]*\\b";
const string SYMB_NAME = "\\b[-._~]*[A-Za-z][-.~A-Za-z0-9]*\\b";
const string IF_KEYWORD = "\\{if\\s+\\$" + SYMB_NAME + "\\s*\\}";
const string ENDIF_KEYWORD = "\\{/if\\}";
const string ELSE_KEYWORD = "\\{if\\s+\\(.*?)\\}";
const string ARRAY_KEYWORD = "array\\(" + string_literal1 + "|" + string_literal1 + "\\)";

#endif