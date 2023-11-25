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

using namespace std;

const string ESCAPE = "\\{[\\w\\s\\[\\]+-=|$><^/#@~&*.%!~`_:;\"'\\\\,]*\\}";
const string SYMBOL_NAME = "\\b[_.~]*[A-Za-z][A-Za-z0-9_.-~]*\\b";
const string LOAD_CONFIG_PAIR = "([A-Za-z][A-Za-z0-9]*)=([A-Za-z0-9]*);";
const string INCLUDE = "\\{\\s*\\include file\\s*=\\s*\"(.*?)\"\\s*\\}";
const string VARIABLE = "\\{\\s*\\$(" + SYMBOL_NAME + ")\\s*\\}";
const string COMMENT = "\\n?\\{\\s*\\*[\\w\\s\\p]*\\*\\s*\\}\\n?";

class streamy
{
public:
    streamy(const string& template_dir, const string& complie_dir, const string& config_dir, const string& cache_dir);

    bool load_config(const string& path, /* out */ string& s_out);
    bool assign(const string& name, const string& val);
    bool assign(const string& name, const vector<string>& vec);
    bool assign(const string& name, const map<string, string>& map);
    bool display(const string& tmpl);
    string& lex_file(string& tmpl, /*out*/ string& s_out);
    string& include_file(const string& tmpl, string& s_out);
    string& include(const string& tmpl, /*out*/ string& s_out);

     // maps
    std::map<string, string> streamy_vars;
    std::map<string, string> config;
    std::map<string, string> vars;
    std::map<string, vector<string>> var_arrays;
    std::map<string, std::map<string, string>> arrays;

    string& read_stream(const string& path, /* out */string& out);
        
    string& trim(string &s, char c);
    string& ltrim(std::string &s);
    string& rtrim(std::string &s);
    string& trim(std::string &s);

    // config
    string template_dir;
    string compile_dir;
    string config_dir;
    string cache_dir;

public:
    string& remove_file_comments(const string& tmpl, /*out*/ string& s_out);
    string& remove_comments(const string& tmpl, /*out*/ string& s_out);
    string replace_tag(string& tmpl, const string& exp_str);
    string variable(const string& src);
    string left_delimiter = "{";
    string right_delimiter = "}";
};

#endif



