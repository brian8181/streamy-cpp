// License:    None
// Author:     Brian K Preston
// File Name:  ./utility.hpp
// Build Date: Thu Dec 21 09:06:55 AM CST 2023
// Version:    0.0.2

#ifndef _UTILITY_HPP
#define _UTILITY_HPP

#include <string>
#include <vector>
#include <map>
#include <regex>

using std::string;
using std::map;
using std::vector;
using std::smatch;

vector<string> getlines(string path);
int read_bits(const smatch& m);
bool file_exist(const string& path);
map<string, string>& get_name_value_pairs(string path, /* out */ map<string, string>& pairs);
string& read_stream(const string& path, /* out */ string& s_out);
string& trim(string& s, char c);
string& ltrim(string& s);
string& rtrim(string& s);
string& trim(string& s);

void match_whole_string(string src, string exp);


#endif