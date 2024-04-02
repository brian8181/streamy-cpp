// File Name:  colorize.hpp
// Build Date: Sat Nov 25 06:03:48 AM CST 2023
// Version:    0.0.0

#ifndef _COLORIZE_HPP
#define _COLORIZE_HPP

#include <string>

using std::string;

enum eColor
{
    RED,
    GREEN,
    BLUE,
    YELLOW,
    CYAN,
    MAGENTA,
    GREY,
    WHITE,
    BLACK
};

class colorize
{

public:
    colorize();
    void  set(string s, unsigned int color);
    void  reset();
    
};

#endif
