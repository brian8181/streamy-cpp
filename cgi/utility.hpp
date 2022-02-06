#ifndef _UTILITY_HPP
#define _UTILITY_HPP

#include <iostream>
#include <iterator>
#include <fstream>
#include <string>

using namespace std;

string fstream_readlines(string path);
string ifstream_readlines(string path);
map<string, string> create_map(string path);

#endif
