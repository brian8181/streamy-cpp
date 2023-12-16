// License:    GPL
// Author:     Brian K Preston
// File Name:  streamy.hpp
// Build Date: Sun Oct  1 09:39:08 PM CDT 2023
// Version:    3.6.7

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

class streamy
{
public:
    streamy(const string& template_dir, const string& complie_dir, const string& config_dir, const string& cache_dir);
    string& load_config(const string& path, /* out */ string& s_out);
    void assign(const string& name, const string& val);
    void assign(const string& name, const vector<string>& vec);
    void display(const string& file);
    void clear_all();
    map<string, string>& get_map_vars(/* out */ map<string, string>& vars);
    map<string, string>& get_map_config(/* out */ map<string, string>& config);
    
private:
    // string& read_stream(const string& path, /* out */string& out);
    // int read_bits(const std::smatch& m);
    void find_escaped_text(const string& tmpl, /* out */ vector<pair<int, std::string>>& tokens);
    void lex(const string& tmpl, /* out */ vector<pair<int, std::string>>& tokens);
    void parse(const std::vector<pair<int, string>>& tokens, /* out */ string& html); 
    void parse_tag(const string token, /* out */ string& html); 

public:
    // maps
    map<string, string> map_config;
    map<string, string> map_vars;
    map<string, vector<string>> map_arrays;
    map<int, string> token_map;
    int state = 0;

    // testing
    typedef vector<pair<int, string>> token_vector;
    // token_vec v;
    // config
    string template_dir;
    string compile_dir;
    string config_dir;
    string cache_dir;
};

#endif



