#ifndef _SMARTYPP_HPP
#define _SMARTYPP_HPP


#include <string>
#include <map>

using namespace std;

class smartypp
{
public:
    smartypp();
    smartypp(string template_dir, string complie_dir, string config_dir, string cache_dir);
    ~smartypp();

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