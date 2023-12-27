
#ifndef _PATTERNS_HPP
#define _PATTERNS_HPP

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
const string ESCAPE2 = "\\{\\(.*)\\}";
const string CONFIG = "\\{\\s*#([A-Aa-z]\\w*)#\\s*\\}";
//const string VARIABLE2 = "\\$(" + SYMBOL_NAME + ")";
const string CONFIG_LOAD = "\\{\\config_load file=\"(.*?)\"\\}";


//const string COMMENT_OR_VARIABLE = "((" + COMMENT + ")" +  "|" + "(" + VARIABLE + "))";
const string LOAD_CONFIG_VALUE = "((\\w+)|('(\\w+)')|(\\\"(\\w+)\\\"))";
const string LOAD_CONFIG_NAME = "[A-Za-z][A-Za-z0-9]*=[A-Za-z0-9]*";
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


//token ids
const int OPEN_CURLY_BRACE_ID = 0x02;
const int CLOSE_CURLY_BRACE_ID = 0x04;
const int FORWARD_SLASH_ID = 0x08;
const int ASTERIK_ID = 0x10;
const int HASH_MARK_ID = 0x20;
const int DOLLAR_SIGN_ID = 0x40;
const int EQUALS_OPERATOR_ID = 0x80;

// group indexs
const int TOKEN = 0; // todo
const int ESC_REG_VAR = 0x1000;
const int ESC_ARRAY_VAR = 0x2000;
const int ESC_STATIC_VAR = 0x4000;
const int ESC_OBJECT = 0x8000; 
const int ESC_COMMENT = 0x10000;
const int ESC_INCLUDE = 0x20000;
const int ESC_LOAD_CONFIG = 0x40000;
const int ESC_STRING_LITERIAL = 0x80000;
const int ESC_NUMERIC_LITERAL = 0x100000;
const int ESC_DECIMAL_LITERAL = 0x200000;
const int ESC_SIGNED_NUMERIC_LITERAL = 0x400000;
const int ESC_UNSIGNED_NUMERIC_LITERAL = 0x800000;
const int ESC_INNNER_REG_VAR =  0x1000000;

map<char, int> VARIABLE_OFFSETS_MAP = { {'$', DOLLAR_SIGN_ID }, {'#', HASH_MARK_ID }, {'*', ASTERIK_ID } };


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