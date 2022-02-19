#ifndef _SMARTY_HPP
#define _SMARTY_HPP

#include <string>
#include <map>

using namespace std;

const string WHITESPACE = " \n\r\t\f\v";

class smarty
{
public:
    smarty(const string& template_dir, const string& complie_dir, const string& config_dir, const string& cache_dir);
    ~smarty();

    bool load_config(const string& path);
    bool assign(const string& name, const string& val);
    bool display(const string& tmpl);

private:

    string readfile(const string& path);
    void ParseTag(string tag);
    string ltrim(const string &s);
    string rtrim(const string &s);
    string trim(const string &s);

    // std::string& ltrim(const std::string &s);
    // std::string& rtrim(const std::string &s);
    // std::string& trim(const std::string &s);

    map<string, string> config;
    map<string, string> symbols;
    map<string, std::map<string, string>> arrays;

    string template_dir;
    string compile_dir;
    string config_dir;
    string cache_dir;
};

#endif
