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
        cout << "ifstream_readlines" << endl;
        string path = argv[1];
        string src0 = ifstream_readlines(path);
        cout << src0 << endl;

        cout << endl << endl << "fstream_read" << endl;
        string src1 = fstream_read(path);
        cout << src1 << endl;

        cout << endl << endl << "fstream_read" << endl;
        string src2 = ifstream_readlines(path);
        cout << src2 << endl;
    }
}