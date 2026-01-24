
#include "bash_color.hpp"
#include "log.hpp"
#include <iostream>
#include <string>

using std::cout;
using std::string;
using std::endl;


void log( string msg, int line_number )
{
		cout << FMT_FG_RED << "LOG INFO: " << FMT_RESET << msg << FMT_ITALIC << FMT_FG_BLUE
			<< " [line: " << line_number << "] - "
			<< FMT_FG_LIGHT_GREY << __TIMESTAMP__ << FMT_RESET << endl;
}
