// License:    None
// Author:     Brian K Preston
// File Name:  ./utility.cpp
// Build Date: Thu Dec 21 09:06:55 AM CST 2023
// Version:    0.0.2

#include <sstream>
#include <fstream>
#include <map>
#include "utility.hpp"

using std::map;
using std::ostringstream;

// void combine_regex(map<string&, string&> strings, string& or_strings)
// {
//     string name;
//     ostringstream s;
//     s << "(";
//     int len = strings.size();
//     for(int i = 0; i < len; ++i)
//     {   
//         s << name << ")|(";
//     }
//     s << name[len] << ")";
// }

int read_bits(const smatch& m)
{
    int len = m.size();
    unsigned int bits = 0;
    for(int i = 0; i < len && i < 32; ++i)
    {
        bits |= (int(m[i].matched) << i);
    }
    return bits;
}

string& read_stream(const string& path, /* out */ string& s_out)
{
    std::ifstream ifstrm(path);
    std::string output((std::istreambuf_iterator<char>(ifstrm)), std::istreambuf_iterator<char>());
    s_out = output;
    return s_out;
}

string& trim(string &s, char c)
{
    if(s.at(s.length()-1) == c)
        s.pop_back();

    return s;
}

string& ltrim(std::string &s)
{
    int len = s.size();
    int i;
    for(i = 0; i < len; ++i)
    {
        if(!std::isspace(s[i]))
            break;
    }
    string::iterator beg = s.begin(); 
    s.erase(beg, beg+i);
    return s;
}

string& rtrim(std::string &s)
{
    int len = s.size();
    int i = len;
    for(;i > 0; --i)
    {
        if(!std::isspace(s[i-1]))
            break;
    }
    string::iterator end = s.end(); 
    s.erase(end-(len-i), end);
    return s;
}

string& trim(std::string &s)
{
    rtrim(s);
    ltrim(s);
    return s;
}