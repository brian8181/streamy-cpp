// License:    GPL
// Author:     Brian K Preston
// File Name:  streamy_lex.cpp
// Build Date: Sun Oct  1 09:39:08 PM CDT 2023
// Version:    3.6.7

#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <filesystem>
#include <regex>
#include "fileio.hpp"
#include "streamy.hpp"

using namespace std;

void  lex(string& s)
{
    cout << "Lexing..." << endl;

    const string ESCAPE = "\\{[\\w\\s\\[\\]+-=|$><^/#@~&*.%!~`_:;\"'\\\\,]*\\}";
    regex exp = regex(ESCAPE, regex::ECMAScript); // match
    smatch match;

    while(std::regex_search(s, match, exp, std::regex_constants::match_default))
    {
        std::string fmt_match_beg = match.format("<TEXT>$`</TEXT>");
        std::string fmt_match = match.format("<TAG>$&</TAG>");
        s = match.format("$'");
        std::cout << fmt_match_beg << endl;
        std::cout << fmt_match << endl;
    }
    cout << s << endl;

    cout << "End Lexing..." << endl;
}

int main(int argc, char *argv[])
{
    std::filesystem::path root(argv[0]);
    string root_str = root.replace_extension("conf");
    map<string, string> pairs = get_config(root_str);

    const string project_folder = pairs["project_folder"];
    const string template_folder = pairs["template_folder"];
    const string default_template = pairs["default_template"];
    
    // check for input or use default
    string template_name = default_template;
    if (argc > 1)
    {
        template_name.clear();
        template_name = argv[1];
    }
    const string file_path = template_folder + template_name;
    string output;
    try
    {
        ifs_read_all(file_path, output);
        lex(output);
    }
    catch (const std::exception &e)
    {
        std::cerr << "Error reading file ... " << e.what() << endl;
    }
    cout << output;

    // *** //
    
    //filesystem::path path(argv[0]);
    string parent = root.parent_path().parent_path();
    string config_path = project_folder + "/test/config/config";

    streamy sm(project_folder + "/test/templates", project_folder + "/test/compile", project_folder + "/test/config", project_folder + "/test/cache");
    string s_out;
    sm.load_config(config_path, s_out);

    cout << "******* Display Configuration ******" << endl;
    map<string, string>::iterator end = sm.config.end();
    for (map<string, string>::iterator iter = sm.config.begin(); iter != end; ++iter)
    {
        cout << "key: " << iter->first << " , value: " << iter->second << endl;
    }

    cout << "******* Display template stream ******" << endl;
    //string tmpl = "test.tpl";
    string _out;
    sm.lex_file("lex_all.tpl", _out);
    //cout << _out;

    //string _html;
    //sm.parse(_out, _html); // parse generates the final HTLM from temaple
    //cout << _html;

    

    sm.assign("headers", "HEADERS");
    sm.assign("page_title", "streamyCPP Test Page");
    sm.assign("body", "The Body");
    sm.assign("admin_email", "admin@something.com");
    sm.assign("version", "0.1");
    sm.assign("version_date", "Feb, 14 2022");
    string display_out;
    sm.display("default.tpl", display_out);

    // int len = sm.tokens.size();
    // for(int i = 0; i < len; ++i)
    // {
    //     if(sm.tokens[i].first)
    //         cout << sm.tokens[i].second;
    //     else
    //     {
    //         cout << "TAG_REPLACE" << sm.tokens[i].second;
    //     }
    // }



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
      
    cout << "******* Test Remove File Comments  ******" << endl;
    string comments;
    comments = sm.remove_file_comments("test_comments.tpl", comments);
    cout << comments << endl;

    cout << "******* Test Remove Comments  ******" << endl;
    string full_path = "/home/brian/src/streamy-cpp/test/templates/test_comments.tpl";
    string file;
    file = sm.read_stream(full_path, file);
    string c;
    c = sm.remove_comments(file, c);
    cout << c << endl;
    return 0;
}