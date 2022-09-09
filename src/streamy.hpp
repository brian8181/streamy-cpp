#ifndef _SMARTY_HPP
#define _SMARTY_HPP

#include <string>
#include <map>

using namespace std;

class smarty
{
public:
    smarty(const string& template_dir, const string& complie_dir, const string& config_dir, const string& cache_dir);
    ~smarty();

    bool load_config(const string& path);
    bool assign(const string& name, const string& val);
    // bool assign(const string& name, vector<string>& values);
    // bool assign(const string& name, vector<int>& values);
    // bool assign(const string& name, vector<bool>& values);
    // bool assign<T>(const string& name, T val);
    // bool escape(const string& tmpl);
    bool display(const string& tmpl);

// testing make public
//private:

    string readfile(const string& path);
    string fread(string path);
    string include(const string& tmpl);
    string variable(const string& src);
    string remove_comments(const string& tmpl);
    string if_sequence(const string& src);
    string lex(const string& tmpl);
    string replace_tag(string& tmpl, const string& exp_str);

    // string& trim(string& s, char chars[]);
    string& trim(string &s, char c);
    string& ltrim(std::string &s);
    string& rtrim(std::string &s);
    string& trim(std::string &s);

    // test functons
    string get_conf(string s);

    // maps
    std::map<string, string> smarty_vars;
    std::map<string, string> config;
    std::map<string, string> vars;
    //std::map<string, vector<string>> var_arrays;
    std::map<string, std::map<string, string>> arrays;

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
