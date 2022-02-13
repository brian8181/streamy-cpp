#ifndef _UTILITY_HPP
#define _UTILITY_HPP

#include <iostream>
#include <iterator>
#include <fstream>
#include <string>

using namespace std;

string fstream_readlines(string path);
string ifstream_readlines(string path);
string fstream_get(string path);
string fstream_read(string path);
//bool load_config(string path, map<string, string>& config);

void assign(string name, string val, map<string, string>& symbols);
string display(string name);
void find_tags(string path);

#endif
