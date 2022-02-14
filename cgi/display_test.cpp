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
    map<string, string> m;
    assign("page_title", "Home", m);
    assign("test1", "ONE", m);
    assign("test2", "TWO", m);

    cout << "Assign: " << endl;
    cout << "page_title=" << m["page_title"] << " : " << "test1=" << m["test1"] << " : " << "test2=" << m["test2"] << endl; 

    if(argc == 2)
    {
        string path = argv[1];
        cout << "Tags List: " << endl;
        map<string, string> tags;
        tags["AAA"] = "TEST_AAA";
        tags["BBB"] = "TEST_BBB";
        tags["CCC"] = "TEST_CCC";

        get_tags(path, tags);
        // list<string>::iterator begin = tags.begin();
        // list<string>::iterator end = tags.end();
        // for(list<string>::iterator iter = begin; iter != end; ++iter)
        // {
        //     cout << iter->c_str() << endl;
        // }
    }
}