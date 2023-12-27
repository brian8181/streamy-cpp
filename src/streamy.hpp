// License:    None
// Author:     Brian K Preston
// File Name:  streamy.hpp
// Build Date: Thu Dec 21 09:06:55 AM CST 2023
// Version:    0.0.2

#ifndef _streamy_HPP
#define _streamy_HPP

#include <string>
#include <vector>
#include <map>
#include <regex>

using std::string;
using std::map;
using std::vector;
using std::pair;

 // escapes
const int TEXT = 0x1;
const int TAG = 0x2;

class streamy
{
public:
    streamy(const string& template_dir, const string& complie_dir, const string& config_dir, const string& cache_dir);
    void load_config(const string& path);
    void display(const string& file);
    void assign(const string& name, const string& val);
    void assign(const string& name, const vector<string>& vec);
    map<string, string>& get_map_vars();
    map<string, string>& get_map_config();
    map<string, vector<string>>& get_map_arrays();
    unsigned int get_state();
    void clear_all();
    
private:
    string& compile(const string& tmpl, /* out */ string& html);
    void find_escapes(const string& tmpl, /* out*/ std::vector<pair<int, std::string>> escapes);
    void lex(const string& s, /* out */ vector<string>& tokens);
    void parse(const std::vector<string>& tokens, /* out */ string& html); 

    // types
    typedef vector<pair<int, string>> token_vector;
    
    // map    
    map<string, string> map_config;
    map<string, string> map_vars;
    map<string, vector<string>> map_arrays;
    map<int, string> token_map;

    // config
    string template_dir;
    string compile_dir;
    string config_dir;
    string cache_dir;

    // state
    unsigned int state;
};

#endif



