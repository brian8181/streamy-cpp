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

const string ESCAPE = "\\{[\\w\\s\\[\\]+-=|$><^/#@~&*.%!~`_:;\"'\\\\,()]*\\}";
const string SYMBOL_NAME = "\\b[_.~]*[A-Za-z][A-Za-z0-9_.-~]*\\b";
const string LOAD_CONFIG_PAIR = "([A-Za-z][A-Za-z0-9]*)=([A-Za-z0-9]*);";

// file
const string INCLUDE = "\\{\\s*\\include file\\s*=\\s*\"(.*?)\"\\s*\\}";
const string CONFIG_LOAD = "\\{\\s*\\config_load file\\s*=\\s*\"(.*?)\"\\s*\\}";
const string INSERT = "\\{\\s*\\insert file\\s*=\\s*\"(.*?)\"\\s*\\}";

// variables
const string VARIABLE = "\\{\\s*\\$(" + SYMBOL_NAME + ")\\s*\\}";
const string OBJECT = "\\{\\s*\\$(" + SYMBOL_NAME + ")\\s*\\}";
const string ARRAY = "\\{\\s*\\$(" + SYMBOL_NAME + ")\\[([0-9]+)\\]\\s*\\}";
const string STATIC_VARIABLE = "\\{\\s*#(" + SYMBOL_NAME + ")#\\s*\\}";

const string COMMENT = "\\{\\s*\\*[\\w\\s\\p]*\\*\\s*\\}";
const string TAGS = "\\{\\s*(\\$(" + SYMBOL_NAME + "))|(\\*[\\w\\s\\p]*\\)\\s*\\}";




const int TEXT = 0x1;
const int TAG = 0x2;
const int OPEN_CURLY_BRACE = 0x4;
const int CLOSE_CURLY_BRACE = 0x8;
const int ASTERISK = 0x10;
const int HASH_MARK = 0x20;

const int REG_VAR = 2;
const int ARRAY_VAR = 4;
const int STATIC_VAR = 7;
const int ESC_COMMENT = 8;
const int ESC_INCLUDE = 9;

class streamy
{
public:
    streamy(const string& template_dir, const string& complie_dir, const string& config_dir, const string& cache_dir);
    bool load_config(const string& path, /* out */ string& s_out);
    bool assign(const string& name, const string& val);
    bool assign(const string& name, const vector<string>& vec);
    void display(const string& file);
    
private:
    string& read_stream(const string& path, /* out */string& out);
    bool lex(const string& tmpl, /* out */ std::vector<pair<int, std::string>>& tokens);
    //bool lex_(const string& tmpl, /* out */ std::vector<pair<int, std::string>>& tokens);
    bool parse(const std::vector<pair<int, std::string>>& tokens, /* out */ string& html); 
    bool parse_tag(const string token, /* out */ string& html); 
    string& include(const string& tmpl, /* out */ string& s_out);

public:
    // maps
    std::map<string, string> streamy_vars;
    std::map<string, string> config;
    std::map<string, string> vars;
    std::map<string, vector<string>> var_arrays;
    std::map<string, std::map<string, string>> arrays;

    // testing
    typedef std::vector<pair<int, std::string>> token_vector;
    token_vector v;
    
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
    // string& remove_file_comments(const string& tmpl, /*out*/ string& s_out);
    // string& remove_comments(const string& tmpl, /*out*/ string& s_out);
    // string replace_tag(string& tmpl, const string& exp_str);
    // string variable(const string& src);
    // string left_delimiter = "{";
    // string right_delimiter = "}";
};

#endif



