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
    streamy();
    streamy(const string& template_dir, const string& complie_dir, const string& config_dir, const string& cache_dir);
    void config_load(const string& path);
    void config_load(const string& path, const string& section);
    void display(const string& file);
    void assign(const string& name, const string& val);
    void assign(const string& name, const vector<string>& vec);
    string& fetch(const string& tmpl, const string& cache_id, const string& compile_id, /*out*/ string& html);
    map<string, string>& get_map_vars();
    map<string, string>& get_map_config();
    map<string, vector<string>>& get_map_arrays();
    vector<pair<string, string>>& get_registered_object(string object_name, /*out*/ vector<pair<string, string>>& registered_object);
    string smarty_prefilter_name(const string& src, const string& smarty);
    string smarty_postfilter_name(const string& src, const string& smarty);
    void clear_all();
    void clear_config();
    void clear_config(string name);
    void clear_assign();
    void clear_assign(string name);
    void clear_cache();
    unsigned int get_state();
    
private:
    string& compile(const string& tmpl, /* out */ string& html);
    void find_escapes(const string& tmpl, /* out*/ std::vector<pair<int, std::string>>& escapes);
    void lex_escapes(vector<pair<int, string>> escapes, /* out */ vector<vector<string>>& tokens);
    void lex(const string& s, /* out */ vector<string>& tokens);
    void parse(vector<std::vector<string>>& tokens, /* out */ string& html);
    void get_next_token(); 

    // types
    typedef vector<pair<int, string>> token_vector;
    
    // map    
    map<string, string> map_config;
    map<string, string> map_vars;
    map<string, string> map_const;
    map<string, vector<string>> map_arrays;
    map<string, pair<string, vector<string>>> map_objects;
    map<int, string> token_map;

    // config
    string template_dir;
    string compile_dir;
    string config_dir;
    string cache_dir;

    bool caching = false;
    bool config_overwrite = false;
    bool autoload_filters = false;

    string version = "0.0.1";
    string templ;
    string ldelm;
    string rdelm;
    // state
    unsigned int state;
};

#endif



