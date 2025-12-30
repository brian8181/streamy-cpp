// File Name:  compiler.hpp
// Build Date: Sat Nov 25 06:03:48 AM CST 2023
// Version:    0.0.1

#ifndef _COMPILER_HPP
#define _COMPILER_HPP

#include <iostream>
#include <regex>
#include <string>
#include <map>
#include "constants.hpp"

//void create_alteration(const long int& flags, /* out */ string& pattern);

using std::string;
using std::map;

class compiler
{
public:
    void compile(const string& file);
    void recompile(const string&  file);
    void clean();

private:
    map<long, string> expresion_map;

};

#endif
