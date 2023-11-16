#ifndef _streamy_HPP
#define _streamy_HPP

#include <string>
#include <vector>
#include <map>

using namespace std;

class streamy
{
public:
    streamy(const string& template_dir, const string& complie_dir, const string& config_dir, const string& cache_dir);
    ~streamy();

    bool load_config(const string& path);
    bool assign(const string& name, const string& val);
    template <class T> bool assign(const string& name, vector<T>& values);
    bool display(const string& tmpl);

    //string readfile(const string& path);
    string read_stream(const string& path);
    //string fread(string path);
    string include(const string& tmpl);
    string variable(const string& src);
    string remove_comments(const string& tmpl);
    string if_sequence(const string& src);
    string lex(const string& tmpl);
    string replace_tag(string& tmpl, const string& exp_str);
    string& trim(string &s, char c);
    string& ltrim(std::string &s);
    string& rtrim(std::string &s);
    string& trim(std::string &s);
    // test functons
    string get_conf(string s);

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



