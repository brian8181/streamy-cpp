// License:    GPL
// Author:     Brian K Preston
// File Name:  streamy.cpp
// Build Date: Sun Oct  1 09:39:08 PM CDT 2023
// Version:    3.6.7

#include <iostream>
#include <regex>
#include <fstream>
#include <sstream>
#include "bash_color.h"
#include "symbols.hpp"
#include "streamy.hpp"
#include "tokens.hpp"

using namespace std;

string& read_stream(const string& path, /* out */ string& s_out)
{
    std::ifstream ifstrm(path);
    std::string output((std::istreambuf_iterator<char>(ifstrm)), std::istreambuf_iterator<char>());
    s_out = output;
    return s_out;
}

int read_bits(const smatch& m)
{
    int len = m.size();
    unsigned int bits = 0;
    for(int i = 0; i < len && i < 32; ++i)
    {
        bits |= (int(m[i].matched) << i);
    }
    return bits;
}

streamy::streamy(const string& template_dir, const string& compile_dir, const string& config_dir, const string& cache_dir)
{
    this->template_dir = template_dir;
    this->compile_dir = compile_dir;
    this->config_dir = config_dir;
    this->cache_dir = cache_dir;
}

string& streamy::load_config(const string& path, /* out */ string& s_out)
{
    s_out = read_stream(path, s_out);
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
    return s_out;
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

void streamy::display(const string& file)
{
    // open file the call parse function ...
    string full_path = this->template_dir + "/" + file;
    // stdout all unescaped text send escaped text to the lexer
    std::vector<pair<int, std::string>> escaped;
    find_escaped_text(file, escaped);
    std::vector<pair<int, std::string>> tokens;
    // tokenize the template code
    lex(file, tokens);
    // parse the tokens appling agrammer rules
    string _html;
    parse(tokens, _html); 
    // stdout final
    cout << _html << endl;

    #if DEBUG
    int len = tokens.size();
    for(int i = 0; i < len; ++i)
    {
        cout << tokens[i].first << " : " << tokens[i].second << endl;
    }
    #endif
    
}

void streamy::clear_all()
{
    map_config.clear();
    map_vars.clear();
    map_arrays.clear();
}

void streamy::find_escaped_text(const string& tmpl, /* out */ std::vector<pair<int, std::string>>& tokens)
{
    string full_path = this->template_dir + "/" + tmpl;
    string s;
    read_stream(full_path, s);
    tokens.clear(); // clear tokens

    regex exp = regex(ESCAPE, std::regex::ECMAScript); // match
    smatch match;
    while(std::regex_search(s, match, exp, std::regex_constants::match_default))
    {
        std::string fmt_match_beg = match.format("$`");
        std::string fmt_match = match.format("$&");
        tokens.push_back(pair(TEXT, fmt_match_beg));

        // {   // parse tags
        //     tokens.push_back(pair(TAG, fmt_match));
        //     tokens.clear(); // clear tokens
        //     regex exp = regex(FIRST_PASS, std::regex::ECMAScript); // match
        //     smatch match;
        //     while(std::regex_search(s, match, exp, std::regex_constants::match_default))
        //     {
        //         std::string fmt_match = match.format("$&");
        //         tokens.push_back(pair(TAG, fmt_match));
        //         s = match.format("$'");
        //     }
        //     tokens.push_back(pair(TEXT, s));
        // }

        s = match.format("$'");
    }
    tokens.push_back(pair(TEXT, s));
}

void streamy::lex(const string& tmpl_name, /* out */ std::vector<pair<int, std::string>>& tokens)
{
    string full_path = this->template_dir + "/" + tmpl_name;
    string s;
    read_stream(full_path, s);
    tokens.clear(); // clear tokens

    regex exp = regex(FIRST_PASS, std::regex::ECMAScript); // match
    smatch match;
    while(std::regex_search(s, match, exp, std::regex_constants::match_default))
    {
        std::string fmt_match = match.format("$&");
        tokens.push_back(pair(TAG, fmt_match));
        s = match.format("$'");
    }
    tokens.push_back(pair(TEXT, s));
}

void streamy::parse(const std::vector<pair<int, std::string>>& tokens, /* out */ string& html)
{
    stringstream shtml;
    stringstream sexpr;

    sexpr       << "(" 
                << EXPR_COMMENT 
                << ")|("  
                << EXPR_STATIC_VARIABLE
                << ")|(" 
                << EXPR_VARIABLE
                << ")|("
                << EXPR_ARRAY 
                << ")|("
                << EXPR_ACTION_FILE 
                << ")";
 
    int len = tokens.size();
    for(int i = 0; i < len; ++i)
    {
        switch(tokens[i].first)
        {
            case TEXT:
                shtml << tokens[i].second;
                break;
            case TAG:

            string expression_stream = sexpr.str();
            // regex exp = regex(expression_stream, regex::ECMAScript); // match
            // smatch m;
            // std::regex_search(tokens[i].second, m, exp);

            // int bits  = read_bits(m);
        
            // if (!m.empty())
            // {
            //     //if(m[ESC_REG_VAR].matched || m[ESC_STATIC_VAR].matched || m[ESC_ARRAY_VAR].matched || m[ESC_COMMENT].matched || m[ESC_INCLUDE].matched)
            //     {
            //         shtml << FMT_FG_GREEN << "MATCH( " << FMT_RESET << FMT_FG_BLUE << FMT_UNDERLINE << tokens[i].second
            //             << FMT_RESET_UNDERLINE << FMT_RESET << FMT_FG_GREEN << " )" << FMT_RESET << " : " << std::oct << bits;
            //         break;
            //     }
            // }
            // shtml << FMT_FG_RED << "ERROR( " << FMT_RESET << FMT_FG_LIGHT_CYAN << tokens[i].second << FMT_RESET << FMT_FG_RED << " )" << FMT_RESET;
            string tag = tokens[i].second;
            token_vector toks;
            lex(tag, toks);
            break;
        }
    }
    html = shtml.str();
}

std::map<string, string>& streamy::get_map_config(/* out */ std::map<string, string>& config)
 {
    config = map_config;
    return config;
 }

 std::map<string, string>& streamy::get_map_vars(/* out */ std::map<string, string>& vars)
 {
    vars = map_vars;
    return vars;
 }
