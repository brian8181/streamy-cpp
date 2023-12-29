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

streamy::streamy()
{
    this->template_dir = "../streamy/templates";
    this->compile_dir = "../streamy/compile";
    this->config_dir = "../streamy/config";
    this->cache_dir = "../streamy/cache";
}

streamy::streamy(const string& template_dir, const string& compile_dir, const string& config_dir, const string& cache_dir)
{
    this->template_dir = template_dir;
    this->compile_dir = compile_dir;
    this->config_dir = config_dir;
    this->cache_dir = cache_dir;
}

void streamy::config_load(const string& path)
{
    // todo comments !
    // todo sections !
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

void streamy::config_load(const string& path, const string& section)
{
    // todo comments !
    // todo sections !
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

string& streamy::fetch(const string& tmpl, const string& cache_id, const string& compile_id, /*out*/ string& html)
{
    compile(tmpl, html);
    return html;
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

#ifdef DEBUG
    int len = escapes.size();
    for(int i =0; i < len; ++i)
    {
        if(escapes[i].first == TAG)
        {
            cout << FMT_FG_BLUE << "escape" << FMT_FG_RED << "-->" 
                 << FMT_FG_GREEN << escapes[i].second << FMT_RESET << endl;
        }
    }
    len = tokens.size(); 
    for(int i = 0; i < len; ++i)
    {
         cout << FMT_FG_RED << "Token-> ";
        int slen = tokens[i].size();
        for(int j = 0; j < slen; ++j)
        {
            cout << FMT_FG_YELLOW << tokens[i][j] << FMT_RESET << ", ";
        }
        cout << endl;
    }
#endif
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

void streamy::find_escapes(const string& tmpl, /* out*/ std::vector<pair<int, std::string>>& escapes)
{
    string s;
    read_stream(tmpl, s);
    regex exp = regex(ESCAPE, std::regex::ECMAScript);
    smatch match;
    while(std::regex_search(s, match, exp, std::regex_constants::match_default))
    {
        std::string fmt_match_beg = match.format("$`");
        std::string fmt_match = match.format("$&");
        escapes.push_back(pair(TEXT, fmt_match_beg));
        escapes.push_back(pair(TAG, fmt_match));
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
    string end_of_string = s;
    regex exp = regex(HEX_LITERAL + "|" + FLOAT_LITERAL + "|" + LOGICAL_OPERATORS + "|" + OPERATORS, std::regex::ECMAScript); 
    smatch match;

    while(std::regex_search(end_of_string, match, exp, std::regex_constants::match_default))
    {
        std::string fmt_match_beg = match.format("$`");
        std::string fmt_match = match.format("$&");
        if(fmt_match_beg.size() > 0)
            tokens.push_back(fmt_match_beg);
        if(!std::isspace(fmt_match[0]))    
            tokens.push_back(fmt_match);

        end_of_string = match.format("$'");
        if(fmt_match == "*" || fmt_match == "#" || fmt_match == "\"" || fmt_match == "'")
        {
            int pos = end_of_string.find_first_of("*#\"'");
            tokens.push_back(end_of_string.substr(0, pos));
            tokens.push_back(end_of_string.substr(pos, 1));
            end_of_string = end_of_string.substr(pos+1, 1);
            
            // need to debug!
            // regex exp_literal = regex("[#]", std::regex::ECMAScript); 
            // smatch literal_match;
            // if(std::regex_search(end_of_string , literal_match, exp_literal, std::regex_constants::match_default))
            // {
            //     fmt_match_beg = match.format("$`");
            //     fmt_match = match.format("$&");
            //     tokens.push_back(fmt_match_beg);
            // }
            // end_of_string = match.format("$'");
        }

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
