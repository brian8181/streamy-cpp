#include <iostream>
#include <iterator>
#include <regex>
#include <fstream>
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

        string name_exp = "([A-Za-z]+\\w*)";
        //string value_exp = "(((\\w+))|('(\\w+)')|(\\\"(\\w+)\\\"))";          
        string value_exp = "(\\w+)|('(\\w+)')|(\\\"(\\w+)\\\")";
        regex src_exp = regex(name_exp + "\\s+=\\s+" + value_exp); 
                      
        auto begin = sregex_iterator(src.begin(), src.end(), src_exp);
        auto end = sregex_iterator(); 
        
        // for each match
		for (sregex_iterator iter = begin; iter != end; ++iter)
		{
            smatch match = *iter;
            //std::ssub_match sub = match[1];
            //cout << "Match: --> " << match.str() <<  "; Name: --> " << match[1].str() << "; Value: --> " << match[6].str() << endl;
            cout << "Match: --> " << match.str() <<  "; Name: --> " << match[1].str() << "; Value: --> " << match[2].str() << endl;

            for(int i = 0; i < 9; ++i)
            {
                cout << "sub" << "[" << i << "] = " << match[i].str() << endl; 
            }

            string value;
            if(match[2].str().size() == 0)
            {
                if(match[4].str().size() == 0)
                {
                    if(match[6].str().size() == 0)
                    {
                        value = "";
                    }
                    else
                    {
                        value = match[6];
                    }
                }
                else
                {
                    value = match[4];
                }
            }
            else
            {
                value = match[2];
            }
            
            cout << "Value: = " << value << endl;
        }
    }
}