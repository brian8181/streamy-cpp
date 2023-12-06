// License:    GPL
// Author:     Brian K Preston
// File Name:  streamy.hpp
// Build Date: Sun Oct  1 09:39:08 PM CDT 2023
// Version:    3.6.7

#ifndef _SYMBOLS_HPP
#define _SYMBOLS_HPP

#include <string>

using std::string;

// tokens
const int TEXT = 0x1;
const int TAG = 0x2;

// todo
const string ESCAPE = "\\{[\\w\\s\\[\\]+-=|$><^/#@~&*.%!~`_:;\"'\\\\,()]*\\}";
const string SYMBOL_NAME = "\\b\\$?_*[A-Za-z][A-Za-z0-9_]*\\b";
const string ACTION = "(insert)|(include)|(config_load)";
const string LOAD_CONFIG_PAIR = "([A-Za-z][A-Za-z0-9]*)=([A-Za-z0-9]*);";
// file
const string EXPR_ACTION_FILE = "\\{(insert)|(include)|(config_load) file=\"[A-Za-z.]+\"\\}";
// const string EXPR_INCLUDE = "\\{include file=\"[A-Za-z.]+\"\\}";
// const string EXPR_CONFIG_LOAD = "\\{\\s*config_load files=\"[A-Za-z.]+\"\\}";
// const string EXPR_INSERT = "\\{\\s*insert file\\s*=\\s*\"(.*?)\"\\s*\\}";
// variables
const string EXPR_VARIABLE = "\\$(" + SYMBOL_NAME + ")"; ;
const string EXPR_OBJECT =  "\\{\\s*\\$(" + SYMBOL_NAME + ")(?:\\.)|(?:->)" + SYMBOL_NAME + "(\\(\\))*\\s*\\}";
const string EXPR_ARRAY = "\\{\\s*\\$(" + SYMBOL_NAME + ")\\[([0-9]+)\\]\\s*\\}";
const string EXPR_STATIC_VARIABLE = "\\s*#(" + SYMBOL_NAME + ")#\\s*";
// other
const string EXPR_COMMENT = "\\{\\*[\\w\\s]*\\*\\}";
const string EXPR_ASSIGN = "";
const string TOKENS = "(" + EXPR_VARIABLE + ")|(" + ACTION + ")";
const string TAGS = "\\{\\s*(\\$(?:" + SYMBOL_NAME + "))|(\\*[\\w\\s\\p]*\\)\\s*\\}";

// group indexs
const int TOKEN = 0; // todo
const int ESC_REG_VAR = 2;
const int ESC_ARRAY_VAR = 4;
const int ESC_STATIC_VAR = 7;
const int ESC_OBJECT = 0; // todo
const int ESC_COMMENT = 8;
const int ESC_INCLUDE = 9;
const int ESC_LOAD_CONFIG = 0;
const int ESC_STRING_LITERIAL = 0;
const int ESC_NUMERIC_LITERAL = 0;
const int ESC_DECIMAL_LITERAL = 0;
const int ESC_SIGNED_NUMERIC_LITERAL = 0;
const int ESC_UNSIGNED_NUMERIC_LITERAL = 0;
const int ESC_INNNER_REG_VAR =  0;

#endif