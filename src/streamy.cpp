// License:    GPL
// Author:     Brian K Preston
// File Name:  streamy.cpp
// Build Date: Sun Oct  1 09:39:08 PM CDT 2023
// Version:    3.6.7

#include <iostream>
#include <regex>
#include <fstream>
#include "patterns.hpp"
#include "streamy.hpp"
#include "base64.hpp"

streamy::streamy(const string& template_dir, const string& compile_dir, const string& config_dir, const string& cache_dir)
{
    this->template_dir = template_dir;
    this->compile_dir = compile_dir;
    this->config_dir = config_dir;
    this->cache_dir = cache_dir;

    trim(this->template_dir, '/');
    trim(this->compile_dir, '/');
    trim(this->config_dir, '/');
    trim(this->cache_dir, '/');
}

bool streamy::load_config(const string& path, /* out */ string& s_out)
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
        config.insert(p);
    }
    return true;
}

bool streamy::assign(const string& name, const string& val)
{
    pair<string, string> p(name, val);
    vars.insert(p);
    return true;
}

bool streamy::assign(const string& name, const vector<string>& vec)
{
    pair<string, vector<string>> p(name, vec);
    var_arrays.insert(p);
    return true;
}

string& streamy::display_file(const string& file, /* out */ string& s_out)
{
     // open file the call parse function ...
    string full_path = this->template_dir + "/" + file;
    string src;
    //read_stream(full_path, src);
    return display(file, s_out);
}

string& streamy::display(const string& tmpl, /* out */ string& s_out)
{
    lex_file(tmpl, s_out);
    string _html;
    parse(s_out, _html); // parse generates the final HTLM from temaple
    cout << _html << endl;
    return s_out;
}
    

bool streamy::display_(const string& tmpl)
{
    string src;
    src = include_file(tmpl, src);
    //src = remove_comments(src);
    //src = if_sequence(src);
    //src = variable(src);

    //REPLACE VARIABLES
    regex exp = regex(VARIABLE, regex::ECMAScript); // match
    auto begin = sregex_iterator(src.begin(), src.end(), exp, std::regex_constants::match_default);
    auto end = sregex_iterator(); 
    string output;
    int beg_pos = 0;
    for (sregex_iterator iter = begin; iter != end; ++iter)
    {
        smatch match = *iter;
        std::ssub_match sub = match[1];
        std::string s(sub.str());
        string& tag = trim(s);
        
        int end_pos = match.position();
        output += src.substr(beg_pos, end_pos-beg_pos);
        map<string, string>::const_iterator find_iter = vars.find(tag);
        if(find_iter != vars.end())
        {
            output += find_iter->second;
        }
        beg_pos = end_pos + match.length();
    }
    output = replace_tag(output, ESCAPE);
    cout << output << endl;
    return true;
}

string& streamy::read_stream(const string& path, /* out */ string& out)
{
    std::ifstream ifstrm(path);
    std::string output((std::istreambuf_iterator<char>(ifstrm)), std::istreambuf_iterator<char>());
    out = output;
    return out;
}

string& streamy::include_file(const string& tmpl, /* out */ string& s_out)
{
    string path = template_dir + "/" + tmpl;
    string src = read_stream(path, s_out);
    regex exp = regex(INCLUDE, regex::ECMAScript);

    auto begin = sregex_iterator(src.begin(), src.end(), exp, std::regex_constants::match_default);
    auto end = sregex_iterator(); 
    int beg_pos = 0;
    for (sregex_iterator iter = begin; iter != end; ++iter)
    {
        smatch match = *iter;
        std::ssub_match sub = match[1];
        string s(sub.str());
        string& tag = trim(s);
        
        int end_pos = match.position();
        s_out += src.substr(beg_pos, end_pos-beg_pos);
        // call include recursively
        s_out += include_file(tag, s_out);
        beg_pos = end_pos + match.length();
    }
    s_out += src.substr(beg_pos);
    return s_out;
}

string& streamy::include(const string& tmpl, /*out*/ string& s_out)
{
    regex exp = regex(INCLUDE, regex::ECMAScript); // match
    smatch match;
    stringstream strm_str; 
    string s;

    while(std::regex_search(tmpl, match, exp, std::regex_constants::match_default))
    {
        std::string fmt_match_beg = match.format("$`");
        std::string fmt_match = match.format("$&");
        s = match.format("$'");
        std::ssub_match sub = match[1];
        strm_str << fmt_match_beg;
        strm_str << "[*FILE HERE: " << fmt_match << " file=" << sub.str() << " *]" << endl;
    }

    strm_str << s;
    s_out = strm_str.str();
    return s_out;
}

string& streamy::lex_file(const string& tmpl, /*out*/ string& s_out)
{
    string full_path = this->template_dir + "/" + tmpl;
    string s;
    read_stream(full_path, s);
    regex exp = regex(ESCAPE, std::regex::ECMAScript); // match
    smatch match;
    stringstream strm_str; 
    
    //vector<pair<int, std::string>> tokens;

    while(std::regex_search(s, match, exp, std::regex_constants::match_default))
    {
        std::string fmt_match_beg = match.format("$`");
        std::string fmt_match = match.format("$&");

        tokens.push_back(pair(1, fmt_match_beg));
        tokens.push_back(pair(0, fmt_match));
        s = match.format("$'");
        strm_str << fmt_match_beg;
        strm_str << fmt_match;
    }

    tokens.push_back(pair(1, s));
    strm_str << s;
    s_out = strm_str.str();

    return s_out;
}

string& streamy::parse_file(const string& file, /* out */ string& s_out)
{
    // open file the call parse function ...
    string full_path = this->template_dir + "/" + file;
    string src;
    read_stream(full_path, src);
    return parse(src, s_out);
}

string& streamy::parse(const string& tmpl, /* out */ string& s_out)
{
    int len = tokens.size();
    for(int i = 0; i < len; ++i)
    {
        if(tokens[i].first)
        {
            cout << tokens[i].second;
        }
        else
        {
            string key = tokens[i].second;
            cout << vars.at(key);
        }
    }

    return s_out;
}

string& streamy::parse_tag(const string& text, /* out */ string& s_out)
{
    return s_out;
}

std::string& streamy::trim(string &s, char c)
{
    if(s.at(s.length()-1) == c)
        s.pop_back();

    return s;
}

string& streamy::ltrim(std::string &s)
{
    int len = s.size();
    int i;
    for(i = 0; i < len; ++i)
    {
        if(!std::isspace(s[i]))
            break;
    }
    string::iterator beg = s.begin(); 
    s.erase(beg, beg+i);
    return s;
}

string& streamy::rtrim(std::string &s)
{
    int len = s.size();
    int i = len;
    for(;i > 0; --i)
    {
        if(!std::isspace(s[i-1]))
            break;
    }
    string::iterator end = s.end(); 
    s.erase(end-(len-i), end);
    return s;
}

string& streamy::trim(std::string &s)
{
    rtrim(s);
    ltrim(s);
    return s;
}

string& streamy::remove_file_comments(const string& tmpl, /*out*/ string& s_out)
{
    string full_path = this->template_dir + "/" + tmpl;
    string src;
    src = read_stream(full_path, src);

    regex exp = regex(COMMENT, regex::ECMAScript); // match
    auto begin = sregex_iterator(src.begin(), src.end(), exp, std::regex_constants::match_default);
    auto end = sregex_iterator();

    int beg_pos = 0;
    for (sregex_iterator iter = begin; iter != end; ++iter)
    {
        smatch match = *iter;
        int end_pos = match.position();
        // remove comment
        s_out += src.substr(beg_pos, end_pos-beg_pos);
        beg_pos = end_pos + match.length();
    }
    s_out += src.substr(beg_pos);

    return s_out;
}

string& streamy::remove_comments(const string& src, /*out*/ string& s_out)
{
    regex exp = regex(COMMENT, regex::ECMAScript); // match
    auto begin = sregex_iterator(src.begin(), src.end(), exp, std::regex_constants::match_default);
    auto end = sregex_iterator(); 

    int beg_pos = 0;
    for (sregex_iterator iter = begin; iter != end; ++iter)
    {
        smatch match = *iter;
        int end_pos = match.position();
        // remove comment
        s_out += src.substr(beg_pos, end_pos-beg_pos);
        beg_pos = end_pos + match.length();
    }
    s_out += src.substr(beg_pos);

    return s_out;
}

string streamy::variable(const string& src)
{
    regex exp = regex(VARIABLE, regex::ECMAScript); // match
    auto begin = sregex_iterator(src.begin(), src.end(), exp, std::regex_constants::match_default);
    auto end = sregex_iterator(); 
    string output;
    int beg_pos = 0;
    for (sregex_iterator iter = begin; iter != end; ++iter)
    {
        smatch match = *iter;
        std::ssub_match sub = match[1];
        std::string s(sub.str());
        string& tag = trim(s);
        
        int end_pos = match.position();
        output += src.substr(beg_pos, end_pos-beg_pos);
        map<string, string>::const_iterator find_iter = vars.find(tag);
        if(find_iter != vars.end())
        {
            output += find_iter->second;
        }
        beg_pos = end_pos + match.length();
    }
    output += src.substr(beg_pos);

    return output;
}

string streamy::replace_tag(string& src, const string& exp_str)
{
    string path = template_dir;
    regex exp = regex(exp_str, regex::ECMAScript);

    auto begin = sregex_iterator(src.begin(), src.end(), exp, std::regex_constants::match_default);
    auto end = sregex_iterator(); 
    string output;
    int beg_pos = 0;
    for (sregex_iterator iter = begin; iter != end; ++iter)
    {
        smatch match = *iter;
        int end_pos = match.position();
        output += src.substr(beg_pos, end_pos-beg_pos);
        output += "@* ESCAPE: " + match.str() + " *@"; //testing
        beg_pos = end_pos + match.length();
    }
    output += src.substr(beg_pos);

    return output;
}
