// License:    GPL
// Author:     Brian K Preston
// File Name:  utility.hpp
// Build Date: Sun Oct  1 09:39:08 PM CDT 2023
// Version:    3.6.7

#ifndef _UTILITY_HPP
#define _UTILITY_HPP

#include <string>

using std::string;

string& trim(string &s, char c);
string& ltrim(std::string &s);
string& rtrim(std::string &s);
string& trim(std::string &s);

#endif