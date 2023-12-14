// // License:    GPL
// // Author:     Brian K Preston
// // File Name:  streamy.hpp
// // Build Date: Sun Oct  1 09:39:08 PM CDT 2023
// // Version:    3.6.7

// #ifndef _SYMBOLS_HPP
// #define _SYMBOLS_HPP

// #include <string>
// #include <sstream>

// using std::string;
// using std::stringstream;

// // tokens
// const int TEXT = 0x1;
// const int TAG = 0x2;

// const char OPEN_CURLY_BRACE = '{';
// const char CLOSE_CURLY_BRACE = '}';
// const char FORWARD_SLASH = '/';
// const string VALID_ESC_CHARS = "[\\w\\s\\[\\]+-=|$><^/#@~&*.%!~`_:;\"'\\\\,()]";
// const string VALID_SYMBOL_CHARS = "[A-Za-z0-9_]";
// const string VALID_FILE_CHARS = "[A-Za-z0-9_.]";
// const string VALID_LITERAL_CHARS = "";
// const string VALID_INT_LITERAL = "";
// const string SYMBOL_NAME = "\\$?_*[A-Za-z]" + VALID_SYMBOL_CHARS + "*";
// // state, found open curly brace
// const string VARIABLE_TOKEN = "\\$(" + SYMBOL_NAME + ")";
// const string COMMENT_TOKEN = "\\*\\s*" + VALID_SYMBOL_CHARS + "*\\s*\\*";
// const string ACTION_TOKEN = "(insert)|(include)|(config_load)";
// const string STATIC_VARIABLE_TOKEN = "\\s*#(" + SYMBOL_NAME + ")#\\s*";
// const string MATCHED_OPEN_CURLY = "(" + VARIABLE_TOKEN 
//                                     + ")|("
//                                     + COMMENT_TOKEN
//                                     + ")|("
//                                     + ACTION_TOKEN
//                                     + ")}("
//                                     + STATIC_VARIABLE_TOKEN
//                                     + ")";
// // state, found left hand side, looking for modifiers or close curly brace
// const string ACTION = "(insert)|(include)|(config_load)";
// const string VAR_MODIFIER = "(capitalize)|(indent)|(lower)|(spacify)|(string_format)|(truncate)|(date_format)|(escape)";
// const string LOAD_CONFIG_PAIR = "([A-Za-z]" + VALID_SYMBOL_CHARS + "*)=(" + VALID_SYMBOL_CHARS + "*);";
// const string EXPR_VARIABLE = "\\$(" + SYMBOL_NAME + ")(\\|" + VAR_MODIFIER +  ")?";
// const string EXPR_OBJECT =  "\\{\\s*\\$(" + SYMBOL_NAME + ")(?:\\.)|(?:->)" + SYMBOL_NAME + "(\\(\\))*\\s*\\}";
// const string EXPR_ARRAY = "\\$(" + SYMBOL_NAME + ")\\[([0-9]+)\\]";
// const string EXPR_STATIC_VARIABLE = "\\s*#(" + SYMBOL_NAME + ")#\\s*";
// const string EXPR_ACTION_FILE = ACTION + " file=\"" + VALID_FILE_CHARS + "+\"";
// const string EXPR_COMMENT = "\\*\\s*" + VALID_SYMBOL_CHARS + "*\\s*\\*";
// // lexing
// const string ESCAPE = "\\{" + VALID_ESC_CHARS + "*\\}";
// const string TOKENS = "(" + EXPR_VARIABLE + ")|(" + ACTION + ")";

// // group indexs
// const int TOKEN = 0; // todo
// const int ESC_REG_VAR = 2;
// const int ESC_ARRAY_VAR = 4;
// const int ESC_STATIC_VAR = 7;
// const int ESC_OBJECT = 0; // todo
// const int ESC_COMMENT = 8;
// const int ESC_INCLUDE = 9;
// const int ESC_LOAD_CONFIG = 0;
// const int ESC_STRING_LITERIAL = 0;
// const int ESC_NUMERIC_LITERAL = 0;
// const int ESC_DECIMAL_LITERAL = 0;
// const int ESC_SIGNED_NUMERIC_LITERAL = 0;
// const int ESC_UNSIGNED_NUMERIC_LITERAL = 0;
// const int ESC_INNNER_REG_VAR =  0;

// #endif
