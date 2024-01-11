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
// File Name:  ./lexer_tester.cpp
// Build Date: Fri Dec 29 03:20:34 AM CST 2023
// Version:    0.1.0

#include <iostream>
#include <cstring>
#include <unistd.h>         /* for STDIN_FILENO */
#include <sys/select.h>     /* for pselect   */
#include <string>
#include <getopt.h>
#include <filesystem>
#include "bash_color.h"
#include "utility.hpp"
#include "streamy.hpp"

using namespace std;

int parse_options(int argc, char* argv[])
{
	// test match_single

	string exp = "abc";
	string text = "abc";
	bool match = match_single(exp, text);
	cout << "exp: " << "\"" << exp << "\"" << " matching " << "\"" << text << "\"" " : matched=" << (match ? "true":"false") << endl;

	exp = "abc";
	text = "abcabc";
	match = match_single(exp, text);
	cout << "exp: " << "\"" << exp << "\"" << " matching " << "\"" << text << "\"" " : matched=" << (match ? "true":"false") << endl;

    // array of values ...  
    vector<string> citys = { "Mesquite",  "Dallas", "Addison", "New York",     "London", 
                             "Barcelona", "Madrid", "Paris",   "Las Angelels", "Las Vegas", 
                             "Garland",   "Richardson", "Plano"};
    
    // initial configuration ...
    const string project_folder = "/home/brian/src/streamy-cpp";
    const string config_path = "/home/brian/src/streamy-cpp/test/config/lexer_tester.conf";

    streamy sm(project_folder + "/test/templates", project_folder + "/test/compile", project_folder + "/test/config", project_folder + "/test/cache");
    sm.load_config(config_path);
    sm.assign("citys", citys);
    sm.assign("headers", "HEADERS");
    sm.assign("page_title", "*PAGE_TITLE*");
    sm.assign("body", "**THE BODY**");
    sm.assign("admin_email", "admin@something.com");
    sm.assign("version", "0.1");
    sm.assign("version_date", "Feb, 14 2022");

	map<string, map<string, string>> config = sm.get_map_config_sections();
	map<string, map<string, string>>::iterator end = config.end();
	for(map<string, map<string, string>>::iterator iter = config.begin(); iter != end; ++iter)
	{
		string section_name = iter->first;
		cout << "[" + section_name + "]" << endl;
		map<string, string> cfg_section = iter->second;
		map<string, string>::iterator end = cfg_section.end();
		for(map<string, string>::iterator section_iter = cfg_section.begin(); section_iter != end; ++section_iter)
		{
			cout << "key = " << section_iter->first << " : value = " << section_iter->second << endl;
		}
	}

	if(argc < 2)
    {
        cout << "No file parameter." << endl;
        cout << "usage: "  << "lex_tester.cgi " << "[path to template file]" << endl; 
        return -1;
    }

	string file_path = project_folder + "/test/templates/" + argv[1];
    filesystem::path file = file_path;
	if(!file_exist(file.string()))
	{
		cout << file.filename() << " : file not found ..." << endl;
        cout << "usage: "  << "lex_tester.cgi " << "[path to template file]" << endl; 
		return -1;
	}

	cout << endl << FMT_FG_RED << "{ Begin streamy standard out --> ...}" << FMT_RESET << endl;
    string tmpl(file.filename());
    sm.display(tmpl);	
	cout << endl << FMT_FG_RED << "{ End streamy standard out --> ...}" << FMT_RESET << endl;

    return 0;
}

int stdin_ready (int filedes)
{
	fd_set set;
	// declare/initialize zero timeout ...
	struct timespec timeout = { .tv_sec = 0 };
	// initialize the file descriptor set ...
	FD_ZERO(&set);
	FD_SET(filedes, &set);
	// check stdin_ready is ready on filedes ...
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
			// add piped buffer to end of argv ...
			char* argvtmp[sizeof(char*) * argc+1] = {0};
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

