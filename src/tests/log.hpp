#ifndef _LOG_H
#define _LOG_H

#include "bash_color.hpp"
#include <string>

void log( std::string msg, int line_number );

#define LOG(msg) cout << FMT_FG_RED << "LOG INFO: " << FMT_RESET << msg << " - " << FMT_ITALIC << FMT_FG_BLUE <<  __FILE__ << " [line: " << __LINE__<< "] - "<< FMT_FG_LIGHT_GREY << __TIMESTAMP__ << FMT_RESET << endl;

#endif