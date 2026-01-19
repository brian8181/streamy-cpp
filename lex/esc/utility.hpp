#ifndef _utility_HPP
#define _utility_HPP

#include <iostream>
#include <vector>
#include <map>

using std::string;
using std::vector;


using std::string;
using std::vector;
using std::map;

std::map<string, string>& get_config(const string& path, /* out */ map<string, string>& config);

string& to_lower(const string& s, /* out */ string& r);
string& to_lower(string& s); // in place
string& to_upper(const string& s, /* out */ string& r);
string& to_upper(string& s); // in place
string& ltrim(string& s);
string& rtrim(string& s);
string& trim(string& s);

template <typename ...Args>
void print(const Args& ...args);

int digits10(int n);
int atoi(const char* s);
void itoa(int& n, char* s);

template<class InputIt, class T, class FunT>
void split(InputIt first, InputIt last, const T& delim, FunT output);

typedef string line_t;
typedef vector<line_t> lines_t;
typedef string field_t;
typedef vector<field_t> record_t;
typedef vector<record_t> table_t;

std::vector<std::string> split(const std::string& s, char c);
vector<long>& psieve(const int& end, vector<long>& ret);

template <typename T> bool equal(const T& a, const T& b);

void redim(int from, int to);
string rebase(const unsigned int n, const unsigned int base);

#endif