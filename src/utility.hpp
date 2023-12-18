// License:    GPL
// Author:     Brian K Preston
// File Name:  utility.hpp
// Build Date: Sun Oct  1 09:39:08 PM CDT 2023
// Version:    3.6.7

#ifndef _UTILITY_HPP
#define _UTILITY_HPP

#include <string>
#include <regex>

using std::string;
using std::smatch;

//  void combine_regex(map<string&, string&> strings, string& or_strings);
int read_bits(const smatch& m);
string& read_stream(const string& path, /* out */ string& s_out);
string& trim(string& s, char c);
string& ltrim(string& s);
string& rtrim(string& s);
string& trim(string& s);


#endif