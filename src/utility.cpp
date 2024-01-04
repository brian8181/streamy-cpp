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

// get file lines as vector
vector<string> getlines(string path)
{
    std::ifstream file;
    file.open(path, std::ios::in);

    vector<string> lines;
    if (file.is_open())
    {
        string line;
        while (getline(file, line))
        {
            lines.push_back(line);
        }
        file.close();
    }
    return lines;
}

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

bool file_exist(const string& path)
{
    std::fstream strm(path);
    strm.open(path, std::ios::in);
    bool ret = strm.is_open();
    strm.close();
    return ret;
}

map<string, string>& get_name_value_pairs(string path, /* out */ map<string, string>& pairs)
{
    std::ifstream file;
    file.open(path, std::ios::in); //open a file

    if (file.is_open()) 
    {   
        string line;
        while(getline(file, line))
        { 
            size_t pos = line.find('=');
            string name = line.substr(0, pos-1);
            name = trim(name);
            string value = line.substr(pos+1);
            value = trim(value);
            std::pair<string, string> p(name, value);
            pairs.insert(p);
        }
        file.close(); //close the file
    }
    return pairs;
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