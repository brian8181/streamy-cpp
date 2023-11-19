#include <iostream>
#include <regex>
#include <fstream>
#include "patterns.hpp"
#include "streamy.hpp"
#include "base64.hpp"

streamy::streamy(const string& template_dir, const string& compile_dir, const string& config_dir, const string& cache_dir)
{
    string s = "test/";
    s = trim(s, '/');

    this->template_dir = template_dir;
    this->compile_dir = compile_dir;
    this->config_dir = config_dir;
    this->cache_dir = cache_dir;

    trim(this->template_dir, '/');
    trim(this->compile_dir, '/');
    trim(this->config_dir, '/');
    trim(this->cache_dir, '/');
}

streamy::~streamy()
{
}

bool streamy::load_config(const string& path)
{
    string src = read_stream(path);
    regex rgx = regex(LOAD_CONFIG_PAIR); 

    auto begin = sregex_iterator(src.begin(), src.end(), rgx, std::regex_constants::match_default);
    auto end = sregex_iterator(); 

    for (sregex_iterator iter = begin; iter != end; ++iter)
    {
        smatch match = *iter;
        string name = match[1].str();
        string value = match[2].str();
        pair<string, string> p(name, value);
        config.insert(p);
    }
    return true;
}

bool streamy::assign(const string& name, const string& val)
{
    pair<string, string> p(name, val);
    vars.insert(p);
    return true;
}

template <class T> bool streamy::assign(const string& name, vector<T>& values)
{
    pair<string, vector<T>> p(name, values);
    vars.insert(p);
    return true;
}

bool streamy::display(const string& tmpl)
{
    string src = include(tmpl);
    src = remove_comments(src);
    src = if_sequence(src);
    //src = variable(src);

    //REPLACE VARIABLES
    regex exp = regex(VARIABLE, regex::ECMAScript); // match
    auto begin = sregex_iterator(src.begin(), src.end(), exp, std::regex_constants::match_default);
    auto end = sregex_iterator(); 
    string output;
    int beg_pos = 0;
    for (sregex_iterator iter = begin; iter != end; ++iter)
    {
        smatch match = *iter;
        std::ssub_match sub = match[1];
        std::string s(sub.str());
        string& tag = trim(s);
        
        int end_pos = match.position();
        output += src.substr(beg_pos, end_pos-beg_pos);
        map<string, string>::const_iterator find_iter = vars.find(tag);
        if(find_iter != vars.end())
        {
            output += find_iter->second;
        }
        beg_pos = end_pos + match.length();
    }
    output = replace_tag(output, ESCAPE);
    cout << output << endl;
    return true;
}

std::string streamy::include(const string& tmpl)
{
    string path = template_dir + "/" + tmpl;
    string src = read_stream(path);
    regex exp = regex(INCLUDE, regex::ECMAScript);

    auto begin = sregex_iterator(src.begin(), src.end(), exp, std::regex_constants::match_default);
    auto end = sregex_iterator(); 
    string output;
    int beg_pos = 0;
    for (sregex_iterator iter = begin; iter != end; ++iter)
    {
        smatch match = *iter;
        std::ssub_match sub = match[1];
        std::string s(sub.str());
        string& tag = trim(s);
        
        int end_pos = match.position();
        output += src.substr(beg_pos, end_pos-beg_pos);
        // call include recursively
        output += include(tag);
        beg_pos = end_pos + match.length();
    }
    output += src.substr(beg_pos);

    return output;
}

string streamy::variable(const string& src)
{
    regex exp = regex(VARIABLE, regex::ECMAScript); // match
    auto begin = sregex_iterator(src.begin(), src.end(), exp, std::regex_constants::match_default);
    auto end = sregex_iterator(); 
    string output;
    int beg_pos = 0;
    for (sregex_iterator iter = begin; iter != end; ++iter)
    {
        smatch match = *iter;
        std::ssub_match sub = match[1];
        std::string s(sub.str());
        string& tag = trim(s);
        
        int end_pos = match.position();
        output += src.substr(beg_pos, end_pos-beg_pos);
        map<string, string>::const_iterator find_iter = vars.find(tag);
        if(find_iter != vars.end())
        {
            output += find_iter->second;
        }
        beg_pos = end_pos + match.length();
    }
    output += src.substr(beg_pos);

    return output;
}

string streamy::replace_tag(string& src, const string& exp_str)
{
    string path = template_dir;
    regex exp = regex(exp_str, regex::ECMAScript);

    auto begin = sregex_iterator(src.begin(), src.end(), exp, std::regex_constants::match_default);
    auto end = sregex_iterator(); 
    string output;
    int beg_pos = 0;
    for (sregex_iterator iter = begin; iter != end; ++iter)
    {
        smatch match = *iter;
        int end_pos = match.position();
        output += src.substr(beg_pos, end_pos-beg_pos);
        output += "@* ESCAPE: " + match.str() + " *@"; //testing
        beg_pos = end_pos + match.length();
    }
    output += src.substr(beg_pos);

    return output;
}

string streamy::remove_comments(const string& src)
{
    regex exp = regex(COMMENT, regex::ECMAScript); // match
    auto begin = sregex_iterator(src.begin(), src.end(), exp, std::regex_constants::match_default);
    auto end = sregex_iterator(); 

    string output;
    int beg_pos = 0;
    for (sregex_iterator iter = begin; iter != end; ++iter)
    {
        smatch match = *iter;
        int end_pos = match.position();
        // remove comment
        output += src.substr(beg_pos, end_pos-beg_pos);
        beg_pos = end_pos + match.length();
    }
    output += src.substr(beg_pos);

    return output;
}

string streamy::if_sequence(const string& src)
{
    string IF_SEQUENCE;
    regex exp = regex(IF_SEQUENCE, regex::ECMAScript); // match
    auto begin = sregex_iterator(src.begin(), src.end(), exp, std::regex_constants::match_default);
    auto end = sregex_iterator(); 

    string output;
    int beg_pos = 0;
    for (sregex_iterator iter = begin; iter != end; ++iter)
    {
        smatch match = *iter;
        int end_pos = match.position();
        std::ssub_match sub = match[1];
        std::string s(sub.str());
        string& tag = trim(s);
        //HTML
        output += "@IF SEQUENCE@\n";
        output += "@HTML@ " + tag + " @HTML@\n";
        output += "@/IF_SEQUENCE@\n";
        output += src.substr(beg_pos, end_pos-beg_pos);
        beg_pos = end_pos + match.length();
    }
    output += src.substr(beg_pos);

    return output;
}

std::string streamy::read_stream(const string& path)
{
    string src;
    ifstream file;
    file.open(path, ios::in); //open a file
    if (file.is_open())
    {   
        string tp;
        while(getline(file, tp))
        { 
            src += tp;
        }
        file.close(); //close the file object.
    }
    return src;
}

std::string& streamy::trim(string &s, char c)
{
    if(s.at(s.length()-1) == c)
        s.pop_back();

    return s;
}

string& streamy::ltrim(std::string &s)
{
    int len = s.size();
    int i;
    for(i = 0; i < len; ++i)
    {
        if(!std::isspace(s[i]))
            break;
    }
    string::iterator beg = s.begin(); 
    s.erase(beg, beg+i);
    return s;
}

string& streamy::rtrim(std::string &s)
{
    int len = s.size();
    int i = len;
    for(;i > 0; --i)
    {
        if(!std::isspace(s[i-1]))
            break;
    }
    string::iterator end = s.end(); 
    s.erase(end-(len-i), end);
    return s;
}

string& streamy::trim(std::string &s)
{
    rtrim(s);
    ltrim(s);
    return s;
}

string& streamy::lex(const string& tmpl, /*out*/ string& s_out)
{
    #ifdef DEBUG
    cout << "Lexing..." << endl;
    #endif

    string full_path = this->template_dir + "/" + tmpl;
    string s = read_stream(full_path);
    const string ESCAPE = "\\{[\\w\\s\\[\\]+-=|$><^/#@~&*.%!~`_:;\"'\\\\,]*\\}";
    regex exp = regex(ESCAPE, regex::ECMAScript); // match
    smatch match;
    stringstream strm_str; 

    while(std::regex_search(s, match, exp, std::regex_constants::match_default))
    {
        std::string fmt_match_beg = match.format("TEXT: $`");
        std::string fmt_match = match.format("TAG $&");
        s = match.format("$'");
        strm_str << fmt_match_beg << endl;
        strm_str << fmt_match << endl;
    }
    strm_str << s << endl;

    #ifdef DEBUG
    cout << "End Lexing..." << endl;
    #endif
    s_out = strm_str.str();

    return s_out;
}

string streamy::get_conf(string s)
{
    return config[s];
}