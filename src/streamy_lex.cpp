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
        string project_folder = path.string();
        string config_path = project_folder + "test/config";

        streamy sm(project_folder + "/www/templates", project_folder + "/www/compile", project_folder + "/www/config", project_folder + "/www/cache");
        sm.load_config(config_path);
        string tmpl = "test.tpl";
        string _out;
        sm.lex(tmpl, _out);
        cout << _out << endl;
    }
    catch (const std::exception &e)
    {
        std::cerr << "Error reading file ... " << e.what() << endl;
    }
    return 0;
}