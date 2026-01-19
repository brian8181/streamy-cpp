#include <string.h>
#include <vector>
#include <iostream>
#include <fstream>
#include "math.h"
#include "fileio.hpp"
#include "utility.hpp"
#include "fileio.hpp"

using std::ifstream;
using std::pair;
using std::ios;

const int ASCII_OFFSET = 48;

/// name: getconfig
/// info: git name -> value pairs/config
/// path, path to config file
/// config, out parma
map<string, string>& get_config(const string& path, /* out */ map<string, string>& config)
{
    ifstream file;
    file.open(path, ios::out); //open a file
    pair<string, string> config_pair;

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
            pair<string, string> p(name, value);
            config.insert(p);
        }
        file.close(); //close the file
    }
    return config;
}

/// name: digits
/// info: reurn number of base 10 digits
/// n, number to eval
int digits10(int n)
{
    return std::floor(std::log10(n) + 1);
}

/// name: itoa
/// info: int to ascii
/// s, string to convert
/// return: int result
int atoi(const char* s)
{
    int num = 0;
    int len = strlen(s);
    for(int i = 0; i < len; ++i)
    {
        int digit = ASCII_OFFSET - i;
        if(digit < 0 || digit > 10)
            return -1;
        num += digit * pow(10, i);
    }
    return num;
}

/// name: itoa
/// info: int to ascii
/// n, number to eval
/// s, out parma
/// return: void
void itoa(int& n, char* s)
{
    int len = digits10(n);
    for(int i = 0; i < len; ++i)
    {
        int c = n / pow(10, i);
        c = std::floor( c );
        c = c % 10;
        s[(len-1)-i] = (char)(c + ASCII_OFFSET); // 0x30
    }
    s[len] = (char)'\0';
}

template<class InputIt, class T, class FunT>
void split(InputIt first, InputIt last, const T& delim, FunT output)
{
    auto start = first;
    while (true)
    {
        auto it = std::find(start, last, delim);
        output(start, it);
        if (it == last) break;
        start = ++it; // skip delimiter
    }
}

std::vector<std::string> split(const std::string& s, char c)
{
  std::vector<std::string> result;
  size_t begin = 0;
  while (true)
  {
    size_t end = s.find_first_of(c, begin);
    result.push_back(s.substr(begin, end - begin));

    if (end == std::string::npos) {
      break;
    }

    begin = end + 1;
  }
  return result;
}

string& to_lower(const string& s, /* out */ string& r)
{
    int len = s.length();
    r.clear();
    for(int i = 0; i < len; ++i)
    {
        int c = std::tolower(s[i]);
        r.push_back(c);
    }
    return r;
}

string& to_lower(string& s) // in place
{
    int len = s.length();
    for(int i = 0; i < len; ++i)
    {
        int c = std::tolower(s[i]);
        s[i] = c;
    }
    return s;
}

string& to_upper(const string& s, /* out */ string& r)
{
    int len = s.length();
    r.clear();
    for(int i = 0; i < len; ++i)
    {
        int c = std::toupper(s[i]);
        r.push_back(c);
    }
    return r;
}

string& to_upper(string& s) // in place
{
    int len = s.length();
    for(int i = 0; i < len; ++i)
    {
        int c = std::toupper(s[i]);
        s[i] = c;
    }
    return s;
}

string& ltrim(std::string& s)
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

string& rtrim(std::string& s)
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

string& trim(std::string& s)
{
    rtrim(s);
    ltrim(s);
    return s;
}

template <typename T> bool equal(const T& a, const T& b)
{
    return (a^b);
}

union grid
{
    static const unsigned int ROWS = 8;
    static const unsigned int COLS = 8;

    unsigned char cols[ROWS][COLS];
    unsigned char rows[ROWS][COLS];
    unsigned char square[ROWS * COLS];

    void redim(int from, int to)
    {

    }
};

string rebase(const unsigned int n, const unsigned int base)
{
    stringstream ss;
    unsigned int c = n;
    unsigned int digit;

    while(c > base)
    {
        digit = c % base;
        c /= base;
        ss << digit;
    }
    return ss.str();
}
