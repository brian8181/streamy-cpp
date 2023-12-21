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

class streamy
{
public:
    streamy(const string& template_dir, const string& complie_dir, const string& config_dir, const string& cache_dir);
    string& load_config(const string& path, /* out */ string& s_out);
    void display(const string& file);
    void assign(const string& name, const string& val);
    void assign(const string& name, const vector<string>& vec);
    map<string, string>& get_map_vars(/* out */ map<string, string>& vars);
    map<string, string>& get_map_config(/* out */ map<string, string>& config);
    map<string, vector<string>> & get_map_arrays(/* out */ map<string, vector<string>> & arrays);
    void clear_all();
    
private:
    void find_escapes(const string& tmpl);
    //void lex(const string& tmpl, /* out */ vector<pair<int, std::string>>& tokens);
    //void parse(const std::vector<pair<int, string>>& tokens, /* out */ string& html); 
    //void parse_tag(const string token, /* out */ string& html); 

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
};

#endif



