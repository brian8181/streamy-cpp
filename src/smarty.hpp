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
    //bool escape(const string& tmpl);
    bool display(const string& tmpl);

private:

    string readfile(const string& path);
    string include(const string& tmpl);
    string comment(const string& tmpl);
    //string lex(const string& tmpl);
    string replace_tag(string& tmpl, const string& exp_str);

    //string& trim(string& s, char chars[]);
    string& trim(string &s, char c);
    string& ltrim(std::string &s);
    string& rtrim(std::string &s);
    string& trim(std::string &s);

    std::map<string, string> smarty_vars;
    std::map<string, string> config;
    std::map<string, string> vars;
    std::map<string, std::map<string, string>> arrays;

    string template_dir;
    string compile_dir;
    string config_dir;
    string cache_dir;

};

#endif
