// License:    None
// Author:     Brian K Preston
// File Name:  ./utility.hpp
// Build Date: Thu Dec 21 09:06:55 AM CST 2023
// Version:    0.0.2

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