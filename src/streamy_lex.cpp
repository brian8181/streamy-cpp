#include <iostream>
#include <string>
#include <fstream>
#include <filesystem>
#include <regex>
#include "streamy.hpp"

using namespace std;

int main(int argc, char *argv[])
{
    try
    {
        std::filesystem::path path(argv[0]);
        string project_folder = path.parent_path().parent_path();
        string config_path = project_folder + "/test/config/config";

        streamy sm(project_folder + "/www/templates", project_folder + "/www/compile", project_folder + "/www/config", project_folder + "/www/cache");
        sm.load_config(config_path);

        sregex_iterator begin = sregex_iterator(src.begin(), src.end(), rgx, std::regex_constants::match_default);
        auto end = sregex_iterator();

        for (sregex_iterator iter = begin; iter != end; ++iter)
        {
            smatch match = *iter;
            string name = match[1].str();
            string value = match[3].str() + match[5].str() + match[7].str();
            pair<string, string> p(name, value);
            sm.config.insert(p);
        }
        auto begin = sregex_iterator(src.begin(), src.end(), rgx, std::regex_constants::match_default);
        auto end = sregex_iterator();

        for (sregex_iterator iter = begin; iter != end; ++iter)
        {
            smatch match = *iter;
            string name = match[1].str();
            string value = match[3].str() + match[5].str() + match[7].str();
            pair<string, string> p(name, value);
            sm.config.insert(p);
        }
        cout << "******* Display Configuration ******" << endl;
        std::map<string, string>::iterator end = sm.config.end();
        for (std::map<string, string>::iterator iter = sm.config.begin(); iter != end; ++iter)
        {
            cout << "key: " << iter->first << " , value: " << iter->second << endl;
        }

        string tmpl = "test.tpl";
        string _out;
        sm.lex(tmpl, _out);

        cout << "******* Display Configuration ******" << endl;
        cout << _out << endl;
    }
    catch (const std::exception &e)
    {
        std::cerr << "Error reading file ... " << e.what() << endl;
    }
    return 0;
}