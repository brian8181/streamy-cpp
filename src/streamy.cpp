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

void streamy::display(const string& file)
{
    // open file the call parse function ...
    string full_path = this->template_dir + "/" + file;
    // stdout all unescaped text send escaped text to the lexer
    find_escapes(file);
    std::vector<pair<int, std::string>> tokens;
    // tokenize the template code
    // lex(file, tokens);
    // parse the tokens appling agrammer rules
    string _html;
    // parse(tokens, _html); 
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

void streamy::find_escapes(const string& tmpl)
{
    string full_path = this->template_dir + "/" + tmpl;
    string s;
    read_stream(full_path, s);
    stringstream strm;

    regex exp = regex(ESCAPE, std::regex::ECMAScript); // match
    smatch match;
    while(std::regex_search(s, match, exp, std::regex_constants::match_default))
    {
        std::string fmt_match_beg = match.format("$`");
        std::string fmt_match = match.format("$&");
        strm << fmt_match_beg << fmt_match;

        // // lexing
        // string tok_s = fmt_match;
        // regex tok_exp = regex(FIRST_PASS, std::regex::ECMAScript); // match
        // smatch tok_match;

        // while(std::regex_search(tok_s, tok_match, tok_exp, std::regex_constants::match_default))
        // {
        //     std::string tok_fmt_match = tok_match.format("$&");
        //     tok_s = tok_match.format("$'");
        //     strm << "<ESCAPED>" << tok_s << "</ESCAPED>";
        // }
        
        s = match.format("$'");
    }
    strm << s;
    std::cout << strm.str();
}

void streamy::lex(const string& match)
{
    // // lexing
    // string tok_s = fmt_match;
    // regex tok_exp = regex(FIRST_PASS, std::regex::ECMAScript); // match
    // smatch tok_match;

    // while(std::regex_search(tok_s, tok_match, tok_exp, std::regex_constants::match_default))
    // {
    //     std::string tok_fmt_match = tok_match.format("$&");
    //     tok_s = tok_match.format("$'");
    //     strm << "<ESCAPED>" << tok_s << "</ESCAPED>";
    // }
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
            //lex(tag, toks);
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

 map<string, vector<string>> &streamy::get_map_arrays(/* out */ map<string, vector<string>> & arrays)
 {
    arrays = arrays;
    return arrays;
 }

void streamy::clear_all()
{
    map_config.clear();
    map_vars.clear();
    map_arrays.clear();
}
