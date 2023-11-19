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

        streamy sm(project_folder + "/test/templates", project_folder + "/test/compile", project_folder + "/test/config", project_folder + "/test/cache");
        sm.load_config(config_path);
        cout << "******* Display Configuration ******" << endl;

        std::map<string, string>::iterator end = sm.config.end();
        for (std::map<string, string>::iterator iter = sm.config.begin(); iter != end; ++iter)
        {
            cout << "key: " << iter->first << " , value: " << iter->second << endl;
        }

        string tmpl = "test.tpl";
        string _out;
        sm.lex(tmpl, _out);
        cout << "******* Display template stream ******" << endl;
        cout << _out << endl;

        sm.assign("headers", "HEADERS");
        sm.assign("page_title", "streamyCPP Test Page");
        sm.assign("body", "The Body");
        sm.assign("admin_email", "admin@something.com");
        sm.assign("version", "0.1");
        sm.assign("version_date", "Feb, 14 2022");
        sm.display("default.tpl");

        cout << "******* Display Variables ******" << endl;
        std::map<string, string>::iterator vend = sm.vars.end();
        for (std::map<string, string>::iterator iter = sm.vars.begin(); iter != vend; ++iter)
        {
            cout << "key: " << iter->first << " , value: " << iter->second << endl;
        }              

        vector names = {"Brian", "Chris", "Bob", "Sue", "Tammy", "Bill", "Julie", "Jancie", "David"};
        //sm.assign("Names", names);  
    }
    catch (const std::exception &e)
    {
        std::cerr << "Error reading file ... " << e.what() << endl;
    }
    return 0;
}