// File Name:  colorize.cpp
// Build Date: Sat Nov 25 06:03:48 AM CST 2023
// Version:    3.6.7

#include <iostream>
#include <string>
#include "bash_color.h"


using std::cout;
using std::string;


string& FMT_STRING(string& s, const string& format)
{
    s = format + s + FMT_RESET;
    return s;
}

string& COLOR_RED(string& s)
{
    return FMT_STRING(s, FMT_FG_RED);
}

string& COLOR_BLUE(string& s)
{
     return FMT_STRING(s, FMT_FG_BLUE);
}

string& COLOR_YELLOW(string& s)
{
    return FMT_STRING(s, FMT_FG_YELLOW);
}

string& COLOR_GREEN(string& s)
{
    return FMT_STRING(s, FMT_FG_GREEN);
}

void set(string s, unsigned int color)
{
    // reset();
    // string s = color + s + FMT_RESET;
    // cout << s;
}
