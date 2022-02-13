#ifndef _SMARTY_HPP
#define _SMARTY_HPP

#include <string>
#include <map>

using namespace std;

class smarty
{
public:
    smarty(string template_dir, string complie_dir, string config_dir, string cache_dir);
    ~smarty();

    bool assign(string name, string val);
    bool display(string tmpl);

private:

    map<string, string> config;
    map<string, string> symbols;
    map<string, std::map<string, string>> arrays;

    string template_dir;
    string compile_dir;
    string config_dir;
    string cache_dir;
};

#endif