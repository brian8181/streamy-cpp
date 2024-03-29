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
#include "constants.hpp"
#include "bash_color.h"
#include "compiler.hpp"

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
                                          {"indent", ID_MODIFIER_INDENT}, {"TEXT", ID_UNESCAPED_TEXT}, {"include", ID_INCLUDE_FILE} };
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
    // todo
    compiler streamy_compiler;
    // todo testing
    //streamy_compiler.compile(tmpl);

    const string full_path = this->template_dir + "/" + tmpl;

    string s;
    read_stream(full_path, s);

    vector<std::pair<int, string>> escapes;
    escapes.reserve(100);
    lex(s, escapes);

    // // debug !
    cout << "finished lexing ... " << endl;
    int len = escapes.size();
    for(int i = 0; i < len; ++i)
    {
        cout << escapes[i].second;
    }

    // parse the tokens appling agrammer rules
    stringstream ss;
    parse(escapes, ss);

    cout << "Template parser finished ... " << endl;
    cout << ss.str();

    // // debug !
    // len = escapes.size();
    // for(int i = 0; i < len; ++i)
    // {
    //     int slen = escapes[i].size();
    //     for(int j = 0; j < slen; ++j)
    //     {
    //           cout << escapes[i][j].second;
    //     }
    // }

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

void streamy::lex(const string& src, /* out*/ vector<pair<int, string>>& escapes)
{
    string s = src;
    regex esc_rexp = regex(ESCAPE, std::regex::ECMAScript);
    smatch esc_match;
    while(regex_search(s, esc_match, esc_rexp, std::regex_constants::match_default))
    {
        // push begin
        if(esc_match.prefix().str().size())
        {
            escapes.push_back({TEXT, esc_match.prefix()});
        }
        // now start lexing
        regex oper_rexp = regex("(" + HEX_LITERAL + "|" + FLOAT_LITERAL + "|" + LOGICAL_OPERATORS + "|" + OPERATORS + ")", regex::ECMAScript);
        smatch oper_match;
        string e_sub_match = esc_match.str();
        while(regex_search(e_sub_match, oper_match, oper_rexp, regex_constants::match_default))
        {
            // push back match as token
            if(oper_match.prefix().str().size() > 0)
                escapes.push_back({TOKEN, oper_match.prefix().str()});

            if(oper_match.str().size() > 0)
                escapes.push_back( { TOKEN, oper_match.str()} );

            // after oper_match to end of string
            string suffix = oper_match.suffix().str();
            if(oper_match.str() == "*" || oper_match.str() == "#" || oper_match.str() == "\"" || oper_match.str() == "'")
            {
                int pos = suffix.find_first_of("*#\"'");
                int len = suffix.size();
                escapes.push_back({ TOKEN, suffix.substr(0, pos ) });

                len = len-(pos+1);
                if(len > 0)
                {
                    escapes.push_back({ TOKEN, suffix.substr(pos, 1 ) });
                    suffix = suffix.substr(pos+1, len);
                }
            }
            e_sub_match = suffix;
        }
        s = (esc_match.suffix().str().size()) ? esc_match.suffix().str() : string("");
    }
    if(s.size() > 0)
    {
           escapes.push_back( { TEXT,  s } );
    }
}

void streamy::parse(vector<pair<int, string>>& tokens, /* out */ stringstream& ss)
{
    int ilen = tokens.size();
    string symbol_name;

    // go through each escape
    int i = 0;
    while(i < ilen)
    {
        ++i;
        pair<int, string> token_pair = tokens[i];
        unsigned long token = token_pair.first == TEXT ? ID_UNESCAPED_TEXT : _token_map[token_pair.second];
        switch(token)
        {
            case ID_UNESCAPED_TEXT:
                ss << token_pair.second;
                // do nothing
                break;
            case ID_OPEN_CURLY_BRACE:
            case ID_CLOSE_CURLY_BRACE:
                break;
            case ID_DOLLAR_SIGN:
            {
                symbol_name = tokens[++i].second;
                string value = map_vars[symbol_name];
                ss << value;
                break;
            }
            case ID_HASH_MARK:
            {
                // move to name
                symbol_name = tokens[++i].second;
                string value = map_config[symbol_name];
                ss << value;
                // move to hash
                ++i; // move to next (hash mark)
                break;
            }
            case ID_ASTERIK:
            {
                i++; // move to comment
                if(tokens[i].first == TOKEN)
                    ++i; // move to *
                if(tokens[i].second[0] == '*')
                    ++i; // move to end
                if(tokens[i].second[0] == '}')
                    ++i; // move to \n
                if(tokens[i].second[0] == '\n')
                    ++i; // go
                break;
            }
            case ID_INCLUDE_FILE:
                ++i;
                if(tokens[i].second == "file")
                    ++i;  // move to next
                if(tokens[i].second[0] == '\"')
                {
                    ++i;
                    if(tokens[i].second[0] == TOKEN)
                    {
                        string file_name = tokens[i].second;
                        include_file(file_name, ss);
                        ++i;  // move to closing "
                    }
                }
                if(tokens[i].second[0] == '}')
                    ++i; // move to \n
                if(tokens[i].second[0] == '\n')
                    ++i; // go
                break;
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
                ss << FMT_FG_YELLOW << "todo: built in fucntion: " << FMT_RESET << FMT_FG_MAGENTA << std::hex << "0x" + token << FMT_RESET << endl;
                break;
            }
            case ID_IF:
            {
                ss << FMT_FG_YELLOW << "todo: built in fucntion: " << FMT_RESET << FMT_FG_MAGENTA << std::hex << "0x" + token << FMT_RESET << endl;
                break;
            }
            case ID_ELSE:
            {
                ss << FMT_FG_YELLOW << "todo: built in fucntion: " << FMT_RESET << FMT_FG_MAGENTA << std::hex << "0x" + token << FMT_RESET << endl;
                break;
            }
            case ID_FOREACH:
            {
                ss << FMT_FG_YELLOW << "todo: built in fucntion: " << FMT_RESET << FMT_FG_MAGENTA << std::hex << "0x" + token << FMT_RESET << endl;
                break;
            }
            case ID_FOREACHELSE:
            {
                ss << FMT_FG_YELLOW << "todo: built in fucntion: " << FMT_RESET << FMT_FG_MAGENTA << std::hex << "0x" + token << FMT_RESET << endl;
                break;
            }

            case ID_BUILTIN_FUNCTION:
            {
                ss << FMT_FG_YELLOW << "todo: built in fucntion: " << FMT_RESET << FMT_FG_MAGENTA << std::hex << "0x" + token << FMT_RESET << endl;
                break;
            }
            default:
            {
                ss << FMT_FG_RED << "error " << FMT_RESET << FMT_BOLD << "unknown token: "
                    << FMT_FG_BLUE << std::hex << "0x" + token << FMT_RESET << endl;
                break;
            }
        }
    }
}

void streamy::include_file(const string& file_name, /* out */ stringstream& ss)
{
    const string full_path = this->template_dir + "/" + file_name;
    string file_src;
    read_stream(file_name, file_src);
    ss << file_src;
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
