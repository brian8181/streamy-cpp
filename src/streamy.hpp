#ifndef _streamy_HPP
#define _streamy_HPP

#include <string>
#include <vector>
#include <map>

using namespace std;

const string SYMBOL_NAME = "\\b[_.~]*[A-Za-z][A-Za-z0-9_.-~]*\\b";
const string LOAD_CONFIG_PAIR = "([A-Za-z][A-Za-z0-9]*)=([A-Za-z0-9]*);";
const string ESCAPE = "\\{\\$?(.*?)\\}";
const string INCLUDE = "\\{\\s*\\include file\\s*=\\s*\"(.*?)\"\\s*\\}";
const string VARIABLE = "\\{\\s*\\$(" + SYMBOL_NAME + ")\\s*\\}";
const string COMMENT = "\\n?\\{\\s*\\*[\\w\\s\\p]*\\*\\s*\\}\\n?";

class streamy
{
public:
    streamy(const string& template_dir, const string& complie_dir, const string& config_dir, const string& cache_dir);

    bool load_config(const string& path);
    bool assign(const string& name, const string& val);
    template <class T> bool assign(const string& name, vector<T>& values);
    bool display(const string& tmpl);

public:
    string& lex(const string& tmpl, /*out*/ string& s_out);

private:
    string read_stream(const string& path);
    string include(const string& tmpl);
    string variable(const string& src);
    string remove_comments(const string& tmpl);
    string if_sequence(const string& src);
    string replace_tag(string& tmpl, const string& exp_str);
    string& trim(string &s, char c);
    string& ltrim(std::string &s);
    string& rtrim(std::string &s);
    string& trim(std::string &s);
    // test functons
    string get_conf(string s);

public:
    // maps
    std::map<string, string> streamy_vars;
    std::map<string, string> config;
    std::map<string, string> vars;
    std::map<string, vector<string>> var_arrays;
    std::map<string, std::map<string, string>> arrays;

private:
    // config
    string template_dir;
    string compile_dir;
    string config_dir;
    string cache_dir;
    // todo INACTIVE
    string left_delimiter = "{";
    string right_delimiter = "}";
};

#endif



