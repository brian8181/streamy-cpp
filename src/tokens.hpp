// License:    GPL
// Author:     Brian K Preston
// File Name:  streamy.hpp
// Build Date: Sun Oct  1 09:39:08 PM CDT 2023
// Version:    3.6.7

#ifndef _TOKENS_HPP
#define _TOKENS_HPP

#include <string>
#include <sstream>

using std::string;
using std::stringstream;

const char OPEN_CURLY_BRACE = '{';
const char CLOSE_CURLY_BRACE = '}';
const char FORWARD_SLASH = '/';
const string VALID_ESC_CHARS = "[\\w\\s\\[\\]+-=|$><^/#@~&*.%!~`_:;\"'\\\\,()]";

#endif