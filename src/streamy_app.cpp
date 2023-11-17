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
// File Name:  no file name
// Build Date: Sun Oct  1 09:39:08 PM CDT 2023
// Version:    3.6.7

#include <iostream>
#include <cstring>
#include <string>
#include <unistd.h>         /* for STDIN_FILENO */
#include <sys/select.h>     /* for pselect   */
#include <string>
#include <getopt.h>
#include <filesystem>
#include "streamy.hpp"

using namespace std;

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

int parse_options(int argc, char* argv[])
{
	filesystem::path fs_path(argv[0]);
    string project_path = fs_path.parent_path();

	const string template_name = project_path + "/default.tpl";
    const string project_folder = project_path + "/cgi_web";
    const string conf_path = project_path + "/test/conf_test.txt";
	
	#ifdef DEBUG
	cout << "Testing streamy display ..." <<  endl;
	#endif
	
    streamy sm(project_folder + "/www/templates", project_folder + "/www/compile", project_folder + "/www/config", project_folder + "/www/cache");
    sm.load_config(conf_path);
    sm.assign("headers", "HEADERS");
    sm.assign("page_title", "streamyCPP Test Page");
    sm.assign("body", "The Body");
    sm.assign("admin_email", "admin@something.com");
    sm.assign("version", "0.1");
    sm.assign("version_date", "Feb, 14 2022");
    sm.display("default.tpl");

	#ifdef DEBUG
	cout << "End display ..." <<  endl;
	#endif

	return 0;
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

