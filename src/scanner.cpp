// @File Name:  ./scanner.cpp
// @Build Date: Thu, Sep 11, 2025  4:06:25 PM
// @Version:    0.0.1
#include <iostream>
#include <cstring>
#include <unistd.h>         /* for STDIN_FILENO */
#include <sys/select.h>     /* for pselect   */
#include <string>
#include <getopt.h>
#include <filesystem>
#include "bash_color.h"
#include "utility.hpp"
#include "streamy.hpp"
#include "constants.hpp"
#include "fileio.hpp"

using namespace std;


void lex(const string& src, /* out*/ vector<pair<int, string>>& escapes)
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
        regex oper_rexp = regex("(" + VARIABLE + ")", regex::ECMAScript);
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

int parse_options(int argc, char* argv[])
{

    string exp = "abc";
	string text = "abc";
	bool match = match_single(exp, text);
	cout << "exp: " << "\"" << exp << "\"" << " matching " << "\"" << text << "\"" " : matched=" << (match ? "true":"false") << endl;

	exp = "abc";
	text = "abcabc";
	match = match_single(exp, text);
	cout << "exp: " << "\"" << exp << "\"" << " matching " << "\"" << text << "\"" " : matched=" << (match ? "true":"false") << endl;

    // array of values ...
    vector<string> citys = { "Mesquite",  "Dallas", "Addison", "New York",     "London",
                             "Barcelona", "Madrid", "Paris",   "Las Angelels", "Las Vegas",
                             "Garland",   "Richardson", "Plano"};

    // initial configuration ...
    const string project_folder = "/home/brian/src/streamy-cpp";
    const string config_path = "/home/brian/src/streamy-cpp/test/config/lexer_tester.conf";

    streamy sm(project_folder + "/test/templates", project_folder + "/test/compile", project_folder + "/test/config", project_folder + "/test/cache");
    sm.load_config(config_path);
	sm.get_map_config()["test"] = "Config Var ...TESTING";
    sm.assign("citys", citys);
    sm.assign("headers", "HEADERS");
    sm.assign("page_title", "*PAGE_TITLE*");
    sm.assign("body", "**THE BODY**");
    sm.assign("admin_email", "admin@something.com");
    sm.assign("version", "0.1");
    sm.assign("version_date", "Feb, 14 2022");
	sm.display("test_vars.tpl");

	cout << endl << FMT_FG_RED << "{ Configuration Variables }" << FMT_RESET << endl;
	map<string, string> config_vars = sm.get_map_config();

	map<string, map<string, string>> config = sm.get_map_config_sections();
	map<string, map<string, string>>::iterator end = config.end();
	for(map<string, map<string, string>>::iterator iter = config.begin(); iter != end; ++iter)
	{
		string section_name = iter->first;
		cout << "[" + section_name + "]" << endl;
		map<string, string> cfg_section = iter->second;
		map<string, string>::iterator end = cfg_section.end();
		for(map<string, string>::iterator section_iter = cfg_section.begin(); section_iter != end; ++section_iter)
		{
			cout << "key = " << section_iter->first << " : value = " << section_iter->second << endl;
		}
	}

	if(argc < 2)
    {
        cout << "No file parameter." << endl;
        cout << "usage: "  << "lex_tester.cgi " << "[path to template file]" << endl;
        return -1;
    }

	string file_path = project_folder + "/test/templates/" + argv[1];
    filesystem::path file = file_path;
	if(!file_exist(file.string()))
	{
		cout << file.filename() << " : file not found ..." << endl;
        cout << "usage: "  << "lex_tester.cgi " << "[path to template file]" << endl;
		return -1;
	}

	cout << endl << FMT_FG_RED << "{ Begin streamy standard out --> ...}" << FMT_RESET << endl;
    string tmpl(file.filename());
    sm.display(tmpl);
	cout << endl << FMT_FG_RED << "{ End streamy standard out --> ...}" << FMT_RESET << endl;

	std::vector<std::pair<int, std::string>> escapes;
	lex("This is some text with an {escape} and some more text. { $variable } and a number 1234.56 and hex 0x1A3F and operators + - * / ! && || == <= >= != -> <-", /* out */ escapes);
	lex("A string with a {literal} block {literal} this is not parsed { /literal } back to normal. Also a foreach {foreach $citys as $city} City: {$city} {foreachelse} No cities found! { /foreach } The end.", /* out */ escapes);
	lex("A string with a {literal} block {literal} this is not parsed { /literal } back to normal. Also an if {if $version == \"0.1\"} Version is 0.1 {elseif $version == \"0.2\"} Version is 0.2 {else} Version is something else! { /if } The end.", /* out */ escapes);
	lex("A string with a {literal} block {literal} this is not parsed { /literal } back to normal. Also an if {if $version == \"0.1\"} Version is 0.1 {elseif $version == \"0.2\"} Version is 0.2 {else} Version is something else! { /if } The end.", /* out */ escapes);
	lex("A string with a {literal} block {literal} this is not parsed { /literal } back to normal. Also an if {if $version == \"0.1\"} Version is 0.1 {elseif $version == \"0.2\"} Version is 0.2 {else} Version is something else! { /if } The end.", /* out */ escapes);
	lex("A string with a {literal} block {literal} this is not parsed { /literal } back to normal. Also an if {if $version == \"0.1\"} Version is 0.1 {elseif $version == \"0.2\"} Version is 0.2 {else} Version is something else! { /if } The end.", /* out */ escapes);
	lex("A string with a {literal} block {literal} this is not parsed { /literal } back to normal. Also an if {if $version == \"0.1\"} Version is 0.1 {elseif $version == \"0.2\"} Version is 0.2 {else} Version is something else! { /if } The end.", /* out */ escapes);
	lex("A string with a {literal} block {literal} this is not parsed { /literal } back to normal. Also an if {if $version == \"0.1\"} Version is 0.1 {elseif $version == \"0.2\"} Version is 0.2 {}else} Version is something else! { /if } The end.", /* out */ escapes);


	lex("0xFFF", /* out */ escapes);
	lex("{$testing}", /* out */ escapes);
	// lex("0xabcdef", /* out */ escapes);
	// lex("0XABCDEF", /* out */ escapes);
	// lex("123456", /* out */ escapes);
	// lex("123456.789", /* out */ escapes);
	// lex("0.789", /* out */ escapes);
	// lex(".789", /* out */ escapes);
	// lex("1234.", /* out */ escapes);
	// lex("1234.56e10", /* out */ escapes);
	// lex("1234.56E10", /* out */ escapes);
	// lex("1234.56e-10", /* out */ escapes);
	// lex("1234.56E-10", /* out */ escapes);

	for(auto& e : escapes)
	{
		if(e.first == TEXT)
			cout << "TEXT  : \"" << e.second << "\"" << endl;
		else
			cout << "TOKEN : \"" << e.second << "\"" << endl;
	}

    return 0;
}

/**
 * @brief  stdin_ready function
 * @param  int filedes : the file handle
 * @return ready or error code
 */
int stdin_ready (int filedes)
{
        fd_set set;
        // declare/initialize zero timeout
#ifndef CYGWIN
        struct timespec timeout = { .tv_sec = 0 };
#else
        struct timeval timeout = { .tv_sec = 0 };
#endif
        // initialize the file descriptor set
        FD_ZERO(&set);
        FD_SET(filedes, &set);

        // check stdin_ready is ready on filedes
#ifndef CYGWIN
        return pselect(filedes + 1, &set, NULL, NULL, &timeout, NULL);
#else
        return select(filedes + 1, &set, NULL, NULL, &timeout);
#endif
}

/**
 * @brief main function
 * @param argc : param count in argv
 * @param argv : command line parameters
 * @return 0 success : or error
 */
int main(int argc, char* argv[])
{
	try
	{
		char* argv_cpy[sizeof(char*) * (argc+1)];
		if(stdin_ready(STDIN_FILENO))
		{
			std::string buffer;
			std::cin >> buffer;
			memcpy(argv_cpy, argv, sizeof(char*) * argc);
			argv_cpy[argc] = &buffer[0];
			++argc;
			return parse_options(argc, argv_cpy);
		}
		return parse_options(argc, argv);
	}
	catch(std::runtime_error& ex)
	{
	 	std::cout << ex.what() << std::endl;
		std::exit(-1);
	}
	catch(std::logic_error& ex)
	{
		std::cout << ex.what() << std::endl;
		std::exit(-1);
	}
}
