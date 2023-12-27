// License:    GPL
// Author:     Brian K Preston
// File Name:  streamy.cpp
// Build Date: Thu Dec 21 09:06:55 AM CST 2023
// Version:    0.0.2

#include <iostream>
#include <regex>
#include <sstream>
#include "streamy.hpp"
#include "utility.hpp"
#include "tokens.hpp"
// debug
#include "bash_color.h"

using namespace std;

streamy::streamy(const string& template_dir, const string& compile_dir, const string& config_dir, const string& cache_dir)
{
    this->template_dir = template_dir;
    this->compile_dir = compile_dir;
    this->config_dir = config_dir;
    this->cache_dir = cache_dir;
}

void streamy::load_config(const string& path)
{
    string s_out;
    read_stream(path, s_out);
    regex rgx = regex(LOAD_CONFIG_PAIR); 

    auto begin = sregex_iterator(s_out.begin(), s_out.end(), rgx, std::regex_constants::match_default);
    auto end = sregex_iterator(); 

    for (sregex_iterator iter = begin; iter != end; ++iter)
    {
        smatch match = *iter;
        string name = match[1].str();
        string value = match[2].str();
        pair<string, string> p(name, value);
        map_config.insert(p);
    }
}

void streamy::display(const string& tmpl)
{
    string _html;
    compile(tmpl, _html);
    // stdout final
    cout << _html << endl;
}

string& streamy::compile(const string& tmpl, /* out */ string& html)
{
    // open file the call parse function ...
    string full_path = this->template_dir + "/" + tmpl;
    // find escape sequences
    vector<std::pair<int, std::string>> escapes;
    find_escapes(full_path, escapes);
    vector<vector<string>> tokens;
    // lex tags in escape sequences
    lex_escapes(escapes, tokens);
    // parse the tokens appling agrammer rules
    parse(tokens, html);
    
    return html;
}

void streamy::assign(const string& name, const string& val)
{
    pair<string, string> p(name, val);
    map_vars.insert(p);
}

void streamy::assign(const string& name, const vector<string>& vec)
{
    pair<string, vector<string>> p(name, vec);
    map_arrays.insert(p);
}

void streamy::find_escapes(const string& tmpl, /* out*/ std::vector<pair<int, std::string>> escapes)
{
    string full_path = this->template_dir + "/" + tmpl;
    string s;
    read_stream(full_path, s);

    regex exp = regex(ESCAPE, std::regex::ECMAScript); // match
    smatch match;
    while(std::regex_search(s, match, exp, std::regex_constants::match_default))
    {
        std::string fmt_match_beg = match.format("$`");
        std::string fmt_match = match.format("$&");
        escapes.push_back(pair(TEXT, fmt_match_beg));
        escapes.push_back(pair(TAG, fmt_match));
        vector<string> tokens;
        lex(fmt_match, tokens);
        s = match.format("$'");
    }
    escapes.push_back(pair(TEXT, s));
}

void streamy::lex_escapes(std::vector<pair<int, std::string>> escapes, /* out */ vector<vector<string>>& tokens)
{
    int len = escapes.size();
    for(int i = 0; i < len; ++i)
    {
        pair<int, std::string> p = escapes[i];
        if(p.first == TAG)
        {   
            vector<string> tok_vec;
            lex(p.second, tok_vec);
            tokens.push_back(tok_vec);
        }
    }
}

void streamy::lex(const string& s, /* out */ vector<string>& tokens)
{
    string str = s;
    regex exp = regex(REGEXP_TOKENS, std::regex::ECMAScript); // match
    smatch match;

    while(std::regex_search(str, match, exp, std::regex_constants::match_default))
    {
        std::string fmt_match = match.format("$&");
        tokens.push_back(fmt_match);
        str = match.format("$'");
    }
}

void streamy::parse(const vector<vector<string>>& tokens, /* out */ string& html)
{
}

std::map<string, string>& streamy::get_map_config()
 {
    return map_config;
 }

 std::map<string, string>& streamy::get_map_vars()
 {
    return map_vars;
 }

 map<string, vector<string>>& streamy::get_map_arrays()
 {
    return map_arrays;
 }

void streamy::clear_all()
{
    map_config.clear();
    map_vars.clear();
    map_arrays.clear();
}

unsigned int streamy::get_state()
{
    return state;
}
