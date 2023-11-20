#include <iostream>
#include "bash_color.h"

using std::cout;
using std::endl;

int main(int argc, char* argv[])
{
    cout << FMT_FG_RED << "Hello World!" << FMT_RESET << endl;
    cout << FMT_FG_BLUE << "Hello World!"  << FMT_RESET << endl;
    cout << FMT_FG_GREEN << "Hello World!"  << FMT_RESET << endl;
    cout << FMT_FG_YELLOW << "Hello World!"  << FMT_RESET << endl;
    cout << FMT_FG_MAGENTA << "Hello World!"  << FMT_RESET << endl;
    cout << FMT_FG_CYAN << "Hello World!"  << FMT_RESET << endl;
    cout << FMT_FG_LIGHT_GREY << "Hello World!"  << FMT_RESET << endl;
    cout << FMT_FG_RED << "Hello World!"  << FMT_RESET << endl;
    cout << FMT_FG_LIGHT_GREEN << "Hello World!"  << FMT_RESET << endl;
    cout << FMT_FG_LIGHT_RED << "Hello World!"  << FMT_RESET << endl;
    cout << FMT_BG_LIGHT_RED << "Hello World!"  << FMT_RESET << endl;
    cout << FMT_BG_LIGHT_BLUE << "Hello World!"  << FMT_RESET << endl;
    
    return 0;
}
