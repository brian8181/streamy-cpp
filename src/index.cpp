// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

// License:    GPL
// Author:     Brian K Preston
// File Name:  main.cpp
// Build Date: Sun Oct  1 09:39:08 PM CDT 2023
// Version:    3.6.7

#include <iostream>
#include <cstring>
#include <unistd.h>         /* for STDIN_FILENO */
#include <sys/select.h>     /* for pselect   */
#include <string>
#include <getopt.h>
#include <filesystem>
#include "bash_color.h"
#include "fileio.hpp"
#include "streamy.hpp"

using namespace std;

int parse_options(int argc, char* argv[])
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
    const string file_path = template_folder + "/" + template_name;
    const string config_path = project_folder + "/test/config/config";

    streamy sm(project_folder + "/test/templates", project_folder + "/test/compile", project_folder + "/test/config", project_folder + "/test/cache");
    string s_out;
    sm.load_config(config_path, s_out);

    cout << "******* Display Configuration ******" << endl;
    map<string, string>::iterator end = sm.config.end();
    for (map<string, string>::iterator iter = sm.config.begin(); iter != end; ++iter)
    {
        cout << "key: " << iter->first << " , value: " << iter->second << endl;
    }

    vector<string> citys = { "Mesquite",  "Dallas", "Addison", "New York",     "London", 
                             "Barcelona", "Madrid", "Paris",   "Las Angelels", "Las Vegas", 
                             "Garland",   "Richardson", "Plano"};
    sm.assign("citys", citys);

    sm.config.insert(pair<string, string>("version", "2000"));
    sm.config.insert(pair<string, string>("mail_message", "No Mail!"));
    sm.config.insert(pair<string, string>("admin_email", "webmaster@streamy-cpp.com"));
    sm.vars.insert(pair<string, string>("version", "2000"));
    sm.vars.insert(pair<string, string>("mail_message", "No Mail!"));
    sm.vars.insert(pair<string, string>("admin_email", "webmaster@streamy-cpp.com"));
    sm.assign("headers", "HEADERS");
    sm.assign("page_title", "*PAGE_TITLE*");
    sm.assign("body", "**THE BODY**");
    sm.assign("admin_email", "admin@something.com");
    sm.assign("version", "0.1");
    sm.assign("version_date", "Feb, 14 2022");
    string display_out;
    sm.display("test_vars.tpl");
    
    return 0;
}

int stdin_ready (int filedes)
{
	fd_set set;
	// declare/initialize zero timeout 
	struct timespec timeout = { .tv_sec = 0 };
	// initialize the file descriptor set
	FD_ZERO(&set);
	FD_SET(filedes, &set);
	// check stdin_ready is ready on filedes 
	return pselect(filedes + 1, &set, NULL, NULL, &timeout, NULL);
}

int main(int argc, char* argv[])
{
	try
	{
		if(stdin_ready(STDIN_FILENO))
		{
			std::string buffer;
			std::cin >> buffer;
			// add piped buffer to end of argv
			char* argvtmp[sizeof(char*) * argc+1];
			memcpy(argvtmp, argv, sizeof(char*) * argc);
			argvtmp[argc] = &buffer[0];
			argv = argvtmp;
			++argc;
		}
		return parse_options(argc, argv);
	}
	catch(std::logic_error& ex)
	{
	 	std::cout << ex.what() << std::endl;
	}
}

