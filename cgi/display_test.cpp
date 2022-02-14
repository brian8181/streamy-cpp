#include <iostream>
#include <iterator>
#include <regex>
#include <string>
#include <map>
#include <list>
#include "utility.hpp"
#include "display_test.hpp"

using namespace std;

int main(int argc, char* argv[])
{
    if(argc == 2)
    {
        string path = argv[1];
        map<string, string> tags;
        assign("AAA", "TEST_AAA", tags);
        assign("BBB", "TEST_BBB", tags);
        assign("CCC", "TEST_CCC", tags);
        string out = match_replace_tags(path, tags);
        cout << out << endl;
    }
}