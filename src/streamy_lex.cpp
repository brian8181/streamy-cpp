#include <iostream>
#include <string>
#include <vector>
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

        cout << "******* Display Arrays ******" << endl;
        vector<string> names = {"Brian", "Chris", "Bob", "Sue", "Tammy", "Bill", "Julie", "Jancie", "David", "Shelly"};
        sm.assign("names_one", names);  
        vector<string> names2 = {"Christina", "Roger", "Brent", "Shara", "Tim", "Tom", "Jack", "Dian", "Ian", "Jill"};
        sm.assign("names_two", names2);

        std::map<string, vector<string>>::iterator avend = sm.var_arrays.end();
        for (std::map<string, vector<string>>::iterator iter = sm.var_arrays.begin(); iter != avend; ++iter)
        {
            cout << "key: " << iter->first << endl; // << iter->second << endl;
            vector<string>::iterator end = iter->second.end();
            for(vector<string>::iterator iter2 = iter->second.begin(); iter2 != end; ++iter2)
            {
                cout << "value: " <<  *iter2 << endl;
            }
        }

        cout << "******* Test Include ******" << endl;
        string include;
        sm.include("test_include.tpl", include);
        cout << include << endl;    

        // cout << "******* Test Include File ******" << endl;
        // string include_file;
        // sm.include_file("test_include.tpl", include_file);
        // cout << include_file << endl;    
    }
    catch (const std::exception &e)
    {
        std::cerr << "Error reading file ... " << e.what() << endl;
    }
    return 0;
}