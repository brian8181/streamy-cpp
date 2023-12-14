// License:    GPL
// Author:     Brian K Preston
// File Name:  streamy.hpp
// Build Date: Sun Oct  1 09:39:08 PM CDT 2023
// Version:    3.6.7

#ifndef _TOKENS_HPP
#define _TOKENS_HPP

#include <string>
#include <map>
#include <sstream>

using std::string;
using std::stringstream;
using std::map;

// escapes
const int TEXT = 0x1;
const int TAG = 0x2;
//token ids
const int OPEN_CURLY_BRACE_ID = 0x02;
const int CLOSE_CURLY_BRACE_ID = 0x04;
const int FORWARD_SLASH_ID = 0x08;
const int ASTERIK_ID = 0x10;
const int HASH_MARK_ID = 0x20;
const int DOLLAR_SIGN_ID = 0x40;

// tokens
const string OPEN_CURLY_BRACE = "\\{";
const string CLOSE_CURLY_BRACE = "\\}";
const string FORWARD_SLASH = "/";
const string ASTERIK = "\\*";
const string HASH_MARK = "#";
const string DOLLAR_SIGN = "\\$";
const string VARIABLE_OFFSETS = "[*#$]";


map<char, int> VARIABLE_OFFSETS_MAP = { {'$', DOLLAR_SIGN_ID }, {'#', HASH_MARK_ID }, {'*', ASTERIK_ID } };
//
const string ACTION_TOKEN = "(insert)|(include)|(config_load)";
const string KEY_WORDS = "(if)|(else)|(elseif)|(foreach)";
const string VALID_ESC_CHARS = "[\\w\\s\\[\\]+-=|$><^/#@~&*.%!~`_:;\"'\\\\,()]";
const string VALID_SYMBOL_CHARS = "[A-Za-z0-9_]";
const string VALID_FILE_CHARS = "[A-Za-z0-9_.]";
const string VALID_LITERAL_CHARS = "";
const string VALID_INT_LITERAL = "";
const string SYMBOL_NAME = "\\$?_*[A-Za-z]" + VALID_SYMBOL_CHARS + "*";
const string VARIABLE_TOKEN = "\\$(" + SYMBOL_NAME + ")";
const string COMMENT_TOKEN = "\\*\\s*" + VALID_SYMBOL_CHARS + "*\\s*\\*";
const string STATIC_VARIABLE_TOKEN = "\\s*#(" + SYMBOL_NAME + ")#\\s*";
const string MATCHED_OPEN_CURLY = "(" + VARIABLE_TOKEN 
                                    + ")|("
                                    + COMMENT_TOKEN
                                    + ")|("
                                    + ACTION_TOKEN
                                    + ")}("
                                    + STATIC_VARIABLE_TOKEN
                                    + ")";
const string VAR_MODIFIER = "(capitalize)|(indent)|(lower)|(spacify)|(string_format)|(truncate)|(date_format)|(escape)";
const string LOAD_CONFIG_PAIR = "([A-Za-z]" + VALID_SYMBOL_CHARS + "*)=(" + VALID_SYMBOL_CHARS + "*);";
const string EXPR_VARIABLE = "\\$(" + SYMBOL_NAME + ")(\\|" + VAR_MODIFIER +  ")?";
const string EXPR_OBJECT =  "\\{\\s*\\$(" + SYMBOL_NAME + ")(?:\\.)|(?:->)" + SYMBOL_NAME + "(\\(\\))*\\s*\\}";
const string EXPR_ARRAY = "\\$(" + SYMBOL_NAME + ")\\[([0-9]+)\\]";
const string EXPR_STATIC_VARIABLE = "\\s*#(" + SYMBOL_NAME + ")#\\s*";
const string EXPR_ACTION_FILE = ACTION_TOKEN + " file=\"" + VALID_FILE_CHARS + "+\"";
const string EXPR_COMMENT = "\\*\\s*" + VALID_SYMBOL_CHARS + "*\\s*\\*";
// lexing
const string ESCAPE = "\\{" + VALID_ESC_CHARS + "*\\}";
const string TOKENS = "(" + EXPR_VARIABLE + ")|(" + ACTION_TOKEN + ")";

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


// const int STATE_BEGIN = 0;
// const int STATE_INITIAL = 9999;
// const int STATE_MATCH_START = 0x2;
// const int STATE_MATCH_FILE_KEYWORD = 0x4;
// const int STATE_MATCH_MODIFIER = 0x8;
// const int STATE_MATCH_FILE_NAME = 0x1000;
// const int STATE_MATCH_VARIABLE = 1;
// const int STATE_MATCH_LITERAL = 0x4;
// const int EVENT_INITIALIZED = 0x1;
// // events
// const int EVENT_MATCHED_CURLY = 0x2;
// const int EVENT_FILE_KEYWORD = 0x4;
// const int EVENT_COMMENT = 0x20;
// const int EVENT_MODIFIER = 0x8;
// const int EVENT_VARIABLE = 0x10;
// const int EVENT_STATIC = 0x40;
// const int EVENT_BEGIN_IF = 0x40;
// const int EVENT_END_IF = 0x80;
// const int EVENT_LITERAL = 0x100;
// const int EVENT_FILE_NAE = 0x200;

#endif