#ifndef _REGEXPR_HPP
#define _REGEXPR_HPP

#include <string>
#include <map>

using namespace std;

const string ESCAPE = "\\{\\$?(.*?)\\}";
const string ESCAPE2 = "\\{\\(.*)\\}";
const string COMMENT = "\\n?\\{\\s*\\*[\\w\\s\\p]*\\*\\s*\\}\\n?";
const string CONFIG = "\\{\\s*#([A-Aa-z]\\w*)#\\s*\\}";
const string VARIABLE = "\\{\\$(.*?)\\}";
const string VARIABLE2 = "\\$(.*?)";
// todo default values ...
const string INCLUDE = "\\{\\include file=\"(.*?)\"\\}";
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

#endif