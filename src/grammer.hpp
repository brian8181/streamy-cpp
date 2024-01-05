// License:    None
// Author:     Brian K Preston
// File Name:  grammer.hpp
// Build Date: Thu Jan  4 07:56:02 PM CST 2024
// Version:    0.0.1

#ifndef _GRAMMER_HPP
#define _GRAMMER_HPP

#include <string>

using std::string;


enum en_token
{
    ID_IF                 = 0x01,
    ID_ELSE               = 0x02,
    ID_ELSEIF             = 0x04,
    ID_FOREACH            = 0x08,
    ID_FOREACHELSE        = 0x0100,
    ID_LITERAL            = 0x0200,
    ID_OPEN_CURLY_BRACE   = 0x0400,
    ID_CLOSE_CURLY_BRACE  = 0x0800,
    ID_ASTERIK            = 0x1000,
    ID_HASH_MARK          = 0x2000,
    ID_DOLLAR_SIGN        = 0x4000,
    ID_DOT                = 0x8000,
    ID_EQUAL              = 0x10000,
    ID_FILE_FUNCTION      = 0x20000,
    ID_VBAR               = 0x40000,
    ID_COLON              = 0x80000,
    ID_SEMI_COLON         = 0x100000
};


// const string VALID_ESC_CHARS = "[\\w\\s\\[\\]+-=|$><^/#@~&*.%!~`_:;\"'\\\\,()]";
// const string VALID_SYMBOL_CHARS = "[A-Za-z0-9_]";
// const string VALID_FILE_CHARS = "[A-Za-z0-9_.]";

// const string SYMBOL_NAME = "\\$?_*[A-Za-z]" + VALID_SYMBOL_CHARS + "*";
// const string VARIABLE_TOKEN = "\\$(" + SYMBOL_NAME + ")";
// const string COMMENT_TOKEN = "\\*\\s*" + VALID_SYMBOL_CHARS + "*\\s*\\*";
// const string STATIC_VARIABLE_TOKEN = "\\s*#(" + SYMBOL_NAME + ")#\\s*";

// //const string LITERAL_TEXT = "\\\"(" + VALID_ESC_CHARS + ")\\\"";
// const string LITERAL_NUMERIC = "[0-9]*.?[0-9]*";
// //const string LITERAL_COMMENT = "\\*(" + VALID_SYMBOL_CHARS + ")\\*";
// const string WHITE_SPACE = "[:[space]:]";

// const string ACTION_TOKEN = "(insert)|(include)|(config_load)";
// // const string MATH = "(abs)|(ceil)|(cos)|(exp)|(floor)|(log)|(log10)|(max)|(min)|(pi)|(pow)|(rand)|(round)|(sin)|(sqrt)|(srans)|(tan)";
// const string KEY_WORDS = "(if)|(else)|(elseif)|(foreach)|(foreachelse)|(literal)|(section)|(strip)|(assign)|(counter)|(cycle)|(debug)|(eval)|(fetch)|(html_checkboxes)";

// const string MATCHED_OPEN_CURLY = "(" + VARIABLE_TOKEN 
//                                     + ")|("
//                                     + COMMENT_TOKEN
//                                     + ")|("
//                                     + ACTION_TOKEN
//                                     + ")}("
//                                     + STATIC_VARIABLE_TOKEN
//                                     + ")";
// const string VAR_MODIFIER = "(capitalize)|(indent)|(lower)|(spacify)|(string_format)|(truncate)|(date_format)|(escape)";
// const string LOAD_CONFIG_PAIR = "([A-Za-z]" + VALID_SYMBOL_CHARS + "*)=(" + VALID_SYMBOL_CHARS + "*);";

// const string EXPR_VARIABLE = "\\$(" + SYMBOL_NAME + ")(\\|" + VAR_MODIFIER +  ")?";
// const string EXPR_OBJECT =  "\\{\\s*\\$(" + SYMBOL_NAME + ")(?:\\.)|(?:->)" + SYMBOL_NAME + "(\\(\\))*\\s*\\}";
// const string EXPR_ARRAY = "\\$(" + SYMBOL_NAME + ")\\[([0-9]+)\\]";
// const string EXPR_STATIC_VARIABLE = "\\s*#(" + SYMBOL_NAME + ")#\\s*";
// const string EXPR_ACTION_FILE = ACTION_TOKEN + " file=\"" + VALID_FILE_CHARS + "+\"";
// const string EXPR_COMMENT = "\\*\\s*" + VALID_SYMBOL_CHARS + "*\\s*\\*";

// // lexing
// const string ESCAPE = "\\{" + VALID_ESC_CHARS + "*\\}";
// const string TOKENS = "(" + EXPR_VARIABLE + ")|(" + ACTION_TOKEN + ")";


#endif