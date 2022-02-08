#pragma once

#include <string>
#include <map>

//using std::string;
//using std::map;

using namespace std;

class smartypp
{
public:
    smartypp();
    smartypp(std::string template_dir, std::string complie_dir, std::string config_dir, std::string cache_dir);
    //~smartypp();

    bool assign(std::string name, std::string val);
    bool display(string tmpl);

private:

    map<std::string, std::string> symbols;

    std::string template_dir;
    std::string compile_dir;
    std::string config_dir;
    std::string cache_dir;
};