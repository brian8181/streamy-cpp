#include "streamy.h"

// name: getconfig
/// info: git name -> value pairs/config
/// path, path to config file
/// config, out parma
map<string, string>& get_config(const string& path, /* out */ map<string, string>& config)
{
    ifstream file;
    file.open(path, ios::out); //open a file
    pair<string, string> config_pair;

    if (file.is_open())
    {
        string line;
        while(getline(file, line))
        {
            size_t pos = line.find('=');
            string name = line.substr(0, pos-1);
            name = trim(name);
            string value = line.substr(pos+1);
            value = trim(value);
            pair<string, string> p(name, value);
            config.insert(p);
        }
        file.close(); //close the file
    }
    return config;
}
