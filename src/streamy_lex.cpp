#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <filesystem>
#include <regex>
#include "fileio.hpp"
#include "streamy.hpp"

using namespace std;

int main(int argc, char *argv[])
{
    filesystem::path path(argv[0]);
    string project_folder = path.parent_path().parent_path();
    string config_path = project_folder + "/test/config/config";

    streamy sm(project_folder + "/test/templates", project_folder + "/test/compile", project_folder + "/test/config", project_folder + "/test/cache");
    sm.load_config(config_path);

    cout << "******* Display Configuration ******" << endl;
    map<string, string>::iterator end = sm.config.end();
    for (map<string, string>::iterator iter = sm.config.begin(); iter != end; ++iter)
    {
        cout << "key: " << iter->first << " , value: " << iter->second << endl;
    }

    cout << "******* Display template stream ******" << endl;
    string tmpl = "test.tpl";
    string _out;
    sm.lex(tmpl, _out);
    cout << _out << endl;

    sm.assign("headers", "HEADERS");
    sm.assign("page_title", "streamyCPP Test Page");
    sm.assign("body", "The Body");
    sm.assign("admin_email", "admin@something.com");
    sm.assign("version", "0.1");
    sm.assign("version_date", "Feb, 14 2022");
    sm.display("default.tpl");

    cout << "******* Display Variables ******" << endl;
    map<string, string>::iterator vend = sm.vars.end();
    for (map<string, string>::iterator iter = sm.vars.begin(); iter != vend; ++iter)
    {
        cout << "key: " << iter->first << " , value: " << iter->second << endl;
    }              
   
    vector<string> names = {"Brian", "Chris", "Bob", "Sue", "Tammy", "Bill", "Julie", "Jancie", "David", "Shelly"};
    sm.assign("names_one", names);  
    vector<string> names2 = {"Christina", "Roger", "Brent", "Shara", "Tim", "Tom", "Jack", "Dian", "Ian", "Jill"};
    sm.assign("names_two", names2);
    vector<string> citys = {"Mesquite", "Dallas", "Addison", "New York", "London", "Barcelona", "Madrid", "Paris", "Las Angelels", "Las Vegas", "Garland", "Richardson", "Plano"};
    sm.assign("citys", citys);

    cout << "******* Display Arrays ******" << endl;
    map<string, vector<string>>::iterator avend = sm.var_arrays.end();
    for (map<string, vector<string>>::iterator iter = sm.var_arrays.begin(); iter != avend; ++iter)
    {
        cout << "key: " << iter->first << endl;
        int len = iter->second.size();
        for(int i = 0; i < len; ++i)
        {
            cout << "index: " << i << " value: " << iter->second[i] << endl;
        }
    }

    cout << "******* Test Include ******" << endl;
    string include;
    sm.include("test_include.tpl", include);
    cout << include << endl;    

    cout << "******* Test Include File ******" << endl;
    string include_file;
    sm.include_file("test_include.tpl", include_file);
    cout << include_file << endl;    
      
    cout << "******* Test File Comments  ******" << endl;
    string comments;
    comments = sm.remove_file_comments("test_comments.tpl", comments);
    cout << comments << endl;

    cout << "******* Test File Comments  ******" << endl;
    // string full_path = this->template_dir + "/" + tmpl;
    // string src = read_stream(full_path);


    return 0;
}