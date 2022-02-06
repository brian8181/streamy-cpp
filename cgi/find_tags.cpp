#include <iostream>
#include <iterator>
#include <regex>
#include <string>
#include "utility.hpp"

using namespace std;

int main(int argc, char* argv[])
{
    if(argc == 2)
    {
        // todo: validate inputs !
        string path = argv[1];
        string src = fstream_readlines(path);

        string name_exp = "[A-Za-z]+\\w*";
        regex src_epx = regex("\\{\\s*\\$(" + name_exp + ")\\s*\\}", regex::ECMAScript);
              
        auto begin = sregex_iterator(src.begin(), src.end(), src_epx);
        auto end = sregex_iterator(); 
        
        // for each match
		for (sregex_iterator iter = begin; iter != end; ++iter)
		{
            smatch match = *iter;
            std::ssub_match sub = match[1];
            cout << match.str() <<  " --> " << sub.str() << endl;
        }
    }
}