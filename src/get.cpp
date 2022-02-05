// get not params
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main(int argc, char* argv[])
{
    if(argc > 1)
    {
        string path = argv[1];
        fstream newfile;
        newfile.open(path, ios::in); //open a file to perform read operation using file object
        if (newfile.is_open())
        {   //checking whether the file is open
            string tp;
            while(getline(newfile, tp))
            { //read data from file object and put it into string.
                cout << tp << "\n"; //print the data of the string
            }
            newfile.close(); //close the file object.
        }
    }
    else
    {
        cout << "content-type: text/html" << endl << endl;
        cout << "<h1>CGI C++ example</h1>" << endl;
    }
}