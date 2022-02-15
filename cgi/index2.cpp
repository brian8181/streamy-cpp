#include <iostream>
#include <string>
#include "../src/smarty.h"

using namespace std;

int main(int argc, char* argv[])
{ 
    cout << "content-type: text/html" << endl << endl;

    string path = "./templates/index_test.tpl";
    smarty sm("./templates", "./complie", "./config", "./cache"); 
    sm.assign("headers", "");
    sm.assign("page_title", "SmartyCPP Test Page");
    sm.assign("body", "The Body");
    sm.assign("admin_email", "admin@something.com");
    sm.assign("version", "0.1");
    sm.assign("version_date", "Feb, 14 2022");
    sm.display(path);
    
    return 0;
}