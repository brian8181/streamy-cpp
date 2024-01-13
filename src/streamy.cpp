// File Name:  streamy.cpp
// Build Date: Thu Dec 21 09:06:55 AM CST 2023
// Version:    0.0.2

#include <iostream>
#include <sstream>
#include <map>
#include <filesystem>
#include <regex>
#include "streamy.hpp"
#include "utility.hpp"
#include "tokens.hpp"
#include "grammer.hpp"
#include "bash_color.h"

using namespace std;

map<string, unsigned int> _token_map = {  {"{", ID_OPEN_CURLY_BRACE}, {"}", ID_CLOSE_CURLY_BRACE}, {"#", ID_HASH_MARK}, {"*", ID_ASTERIK}, {"$", ID_DOLLAR_SIGN}, 
                                          {"=", ID_EQUAL}, {"|", ID_VBAR}, {":", ID_COLON}, {"\"", ID_DOUBLE_QUOTE}, {"'", ID_SINGLE_QUOTE}, {".", ID_DOT},
                                          {"+", ID_PLUS}, {"-", ID_MINUS}, {"%", ID_MODULUS}, 
                                          {"[", ID_OPEN_BRACE}, {"]", ID_CLOSE_BRACE}, {";", ID_SEMI_COLON},
                                          {"&&", ID_LOGICAL_AND}, {"||", ID_LOGICAL_OR}, {"!", ID_LOGICAL_NOT},
                                          {"if", ID_IF}, {"ELSEIF", ID_ELSEIF}, {"ELSE", ID_ELSE}, {"foreach", ID_FOREACH}, {"foreachelse", ID_FOREACHELSE},
                                          {"include", ID_BUILTIN_FUNCTION }, {"config_load", ID_BUILTIN_FUNCTION }, {"insert", ID_BUILTIN_FUNCTION},
                                          {"assign", ID_BUILTIN_FUNCTION }, {"fetch", ID_BUILTIN_FUNCTION}, {"capture", ID_BUILTIN_FUNCTION },
                                          {"upper", ID_MODIFIER_UPPER}, {"lower", ID_MODIFIER_LOWER}, {"truncate", ID_MODIFIER_TRUNCATE}, {"capitalize", ID_MODIFIER_CAPATIALIZE},
                                          {"indent", ID_MODIFIER_INDENT} };
unsigned int token_id = 0;

streamy::streamy()
{
    this->template_dir = "../streamy/templates";
    this->compile_dir = "../streamy/compile";
    this->config_dir = "../streamy/config";
    this->cache_dir = "../streamy/cache";
}

streamy::streamy(const string& template_dir, const string& compile_dir, const string& config_dir, const string& cache_dir)
{
    this->template_dir = template_dir;
    this->compile_dir = compile_dir;
    this->config_dir = config_dir;
    this->cache_dir = cache_dir;
}

void streamy::load_config(const string& path)
{
    const unsigned int ID_NAME_VALUE_PAIR = 0;
    const unsigned int ID_NAME            = 1;
    const unsigned int ID_VALUE           = 2;
    const unsigned int ID_NUMERIC_LITERAL = 2;
    const unsigned int ID_STRING_LITERAL  = 3;

    // get configuration file by lines
    vector<string> lines;
    lines = getlines(path, lines);
    // create one only section (global)
    string section_name = "global";
    map<string, string> section_map;
    pair<string, map<string, string>> sp(section_name, section_map);
    map_sections_config.insert(sp);

    int len = lines.size();
    for(int i = 0; i < len; ++i)
    {
        string line = lines[i];
        regex rgx = regex(CONFIG_PAIR);
        smatch match;
        regex_match(line, match, rgx);
                
        if(match[ID_NAME_VALUE_PAIR].matched)
        {
            // get name
            string symbol_name = match[ID_NAME].str();
            // get value
            string value = (match[ID_VALUE].matched) ? 
                match[ID_NUMERIC_LITERAL].str() : match[ID_STRING_LITERAL].str();
            // create pair    
            pair<string, string> p(symbol_name, value);
            map_sections_config[section_name].insert(p);
        }
    }
}

void streamy::display(const string& tmpl)
{
    string html;
    compile(tmpl, html);
}

string& streamy::fetch(const string& tmpl, const string& cache_id, const string& compile_id, /*out*/ string& html)
{
    compile(tmpl, html);
    return html;
}

string& streamy::compile(const string& tmpl, /* out */ string& html)
{
    const string full_path = this->template_dir + "/" + tmpl;
    vector<vector<std::pair<int, string>>> escapes;    
    escapes.reserve(100);
    lex(full_path, escapes);

    // debug !
    int len = escapes.size();
    for(int i = 0; i < len; ++i)
    {
        int slen = escapes[i].size();
        for(int j = 0; j < slen; ++j)
        {
              cout << escapes[i][j].second;
        }
    }

    // parse the tokens appling agrammer rules
    // parse(tokens, html);
    return html;
}

void streamy::assign(const string& symbol_name, const string& val)
{
    pair<string, string> p(symbol_name, val);
    map_vars.insert(p);
}

void streamy::assign(const string& symbol_name, const vector<string>& vec)
{
    pair<string, vector<string>> p(symbol_name, vec);
    map_arrays.insert(p);
}

void streamy::lex(const string& tmpl, /* out*/ vector<vector<pair<int, string>>>& escapes)
{
    string s;
    read_stream(tmpl, s);
    regex escape_exp = regex(ESCAPE, std::regex::ECMAScript);
    smatch e_match;
    while(regex_search(s, e_match, escape_exp, std::regex_constants::match_default))
    {
        vector<string> begin_text = { e_match.prefix() };
        if(begin_text[0].size()) escapes.push_back( vector<pair<int, string>>( {{TEXT, begin_text[0]}} ) ); 
        escapes.push_back( vector<pair<int, string>>( {{TAG, e_match.str()}} ) );
        
        // if(!e_match.size())
        //     return;
     
        // // now start lexing 
        // regex oper_exp = regex(HEX_LITERAL + "|" + FLOAT_LITERAL + "|" + LOGICAL_OPERATORS + "|" + OPERATORS, regex::ECMAScript); 
        // smatch o_match;
        // string sub_str = e_match.str();
        // while(regex_search(sub_str, o_match, oper_exp, regex_constants::match_default))
        // {
        //     // push back match as token
        //     escapes.push_back( vector<pair<int, string>>( {{ TOKEN, o_match.str() }} ) );
        //     if(!isspace(o_match.str()[0]))  escapes.push_back(vector<pair<int, string>>( {{ TOKEN, o_match.str() }} ) );

        //     // after o_match to end of string
        //     string match_suffix = s;
        //     if(o_match.str() == "*" || o_match.str() == "#" || o_match.str() == "\"" || o_match.str() == "'")
        //     {
        //         int pos = match_suffix.find_first_of("*#\"'");
        //         escapes.push_back(vector<pair<int, string>>( {{ TOKEN, match_suffix.substr(0, pos ) }} ));
        //         escapes.push_back(vector<pair<int, string>>( {{ TOKEN, match_suffix.substr(pos, 1 ) }} ));
        //         match_suffix = s.substr(pos+1, 1);
        //     }
        // }
        s = (e_match.suffix().str().size()) ? e_match.suffix().str() : string("");
    }
    if(s.size() > 0)
    {
           escapes.push_back( vector<pair<int, string>>( {{ TEXT,  s }} ));
    }
}

void streamy::parse(vector<vector<string>>& tokens, /* out */ string& html)
{
    //int ilen = tokens.size();
    string symbol_name;
    //for(int i = 0; i < ilen; ++i)
    //{
        int jlen = tokens[0].size();
        for(int j = 0; j < jlen; ++j)
        {
            string token = tokens[0][j];
            //if(token.size() == 1)
            {
                switch(_token_map[token])
                {
                    case ID_OPEN_CURLY_BRACE:
                    case ID_CLOSE_CURLY_BRACE:
                        break;
                    case ID_DOLLAR_SIGN:
                    {
                        //vector<vector<string>>::iterator iter = tokens.begin();
                        symbol_name = tokens[0][j+1];
                        string value = map_vars[symbol_name];
                        html = value;
                        vector<string> line_vec = { value };
                        //tokens.push_back
                        //tokens.insert(iter+i, line_vec); 
                        break;
                    }
                    case ID_HASH_MARK:
                    {
                        //vector<vector<string>>::iterator iter = tokens.begin();
                        symbol_name = tokens[0][j+1];
                        string value = map_config[symbol_name];
                        html = value;
                        vector<string> line_vec = { value };
                        //tokens.erase(iter+i);
                        //tokens.insert(iter+i, line_vec); 
                        break;
                    }
                    case ID_ASTERIK:       
                    {
                        //vector<vector<string>>::iterator iter = tokens.begin();
                        //html = ""; do nothing, comment are just not displayed
                        //tokens.erase(iter+i);
                        break;
                    }
                    case ID_MODULUS:
                    case ID_LOGICAL_AND:
                    case ID_LOGICAL_OR:
                    case ID_LOGICAL_NOT:
                    case ID_LESS_THAN:
                    case ID_GREATER_THAN:
                    case ID_DOUBLE_QUOTE:
                    case ID_SINGLE_QUOTE:
                    case ID_PLUS:
                    case ID_MINUS:
                    case ID_VBAR:
                    case ID_DOT:
                    case ID_COLON:
                    case ID_SEMI_COLON:
                    case ID_OPEN_PAREN:
                    case ID_CLOSE_PAREN:
                    case ID_OPEN_BRACE:
                    case ID_CLOSE_BRACE:
                    case ID_EQUAL:
                    {
                        cout << FMT_FG_YELLOW << "todo: built in fucntion: " << FMT_RESET << FMT_FG_MAGENTA << token << FMT_RESET << endl; 
                        break;
                    }
                    case ID_IF:
                    {
                        cout << FMT_FG_YELLOW << "todo: built in fucntion: " << FMT_RESET << FMT_FG_MAGENTA << token << FMT_RESET << endl; 
                        break;
                    }
                    case ID_ELSE:
                    {
                        cout << FMT_FG_YELLOW << "todo: built in fucntion: " << FMT_RESET << FMT_FG_MAGENTA << token << FMT_RESET << endl; 
                        break;
                    }
                    case ID_FOREACH:
                    {
                        cout << FMT_FG_YELLOW << "todo: built in fucntion: " << FMT_RESET << FMT_FG_MAGENTA << token << FMT_RESET << endl; 
                        break;
                    }
                    case ID_FOREACHELSE:
                    {
                        cout << FMT_FG_YELLOW << "todo: built in fucntion: " << FMT_RESET << FMT_FG_MAGENTA << token << FMT_RESET << endl; 
                        break;
                    }
                    
                    case ID_BUILTIN_FUNCTION:
                    {
                        cout << FMT_FG_YELLOW << "todo: built in fucntion: " << FMT_RESET << FMT_FG_MAGENTA << token << FMT_RESET << endl; 
                        break;
                    }
                   default:
                   {
                        cout << FMT_FG_RED << "error " << FMT_RESET << FMT_BOLD << "unknown token: " 
                            << FMT_FG_BLUE << token << FMT_RESET << endl;
                        break;
                   }
                }
            }
        }
    //}
}

void streamy::clear_cache()
{
    // delete cache
    filesystem::path p = cache_dir;
}

map<string, map<string, string>>& streamy::get_map_config_sections()
{
    return map_sections_config;
}

map<string, string>& streamy::get_map_config()
{
    return map_config;
}

std::map<string, string>& streamy::get_map_vars()
{
    return map_vars;
}

map<string, vector<string>>& streamy::get_map_arrays()
{
    return map_arrays;
}

void streamy::clear_config()
{
    map_config.clear();
}

void streamy::clear_config(string symbol_name)
{
    map_config.erase(symbol_name);
}

void streamy::clear_assign()
{
    map_vars.clear();
}

void streamy::clear_assign(string symbol_name)
{
    map_vars.erase(symbol_name);
}

void streamy::clear_all()
{
    map_config.clear();
    map_vars.clear();
    map_arrays.clear();
}

unsigned int streamy::get_state()
{
    return state;
}
