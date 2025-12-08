/**
 * @file     fileio.hpp
 * @date:    Tue, Oct 28, 2025  1:47:46 PM
 * @version: 0.0.1
 */

#ifndef _FILEIO_HPP_
#define _FILEIO_HPP_

#include <string>
#include <sstream>
#include <fstream>
#include <vector>

using std::string;
using std::vector;
using std::ifstream;
using std::ofstream;
using std::stringstream;

/**
 * @brief  check if file exist
 * @param  const string& : path to file
 * @return bool: ture file exsit otherwise false
 */
bool file_exist(const string& path);

/**
 * @brief  read a character from a file stream
 * @param  ifstream& stream, file stream to read
 * @param  char& c, character to read
 * @return int, file stream
 */
ifstream& read_char(ifstream& stream, /* out */ char& c);

/**
 * @brief  write a character to a file stream
 * @param  ofstream& stream, file stream to write
 * @param  char& c, character to write
 * @return ofstream&, file stream
 */
ofstream& write_char(ofstream& stream, /* in */ const char& c);

/**
 * @brief  read a file into a buffer
 * @param  const string& file, file to read
 * @param  unsigned char* buf, buffer to store the file contents
 * @param  const int& len, length of the buffer
 * @return int, number of bytes read, or -1 on error
 */
int read_buf(const string& file, /* out */ unsigned char* buf, const int& len);

/**
 * @brief  write a buffer to a file
 * @param  const string& file, file to write
 * @param  const unsigned char* buf, buffer to write
 * @param  const int& len, length of the buffer
 * @return int, number of bytes written, or -1 on error
 */
int write_buf(const string& file, /* in */ const unsigned char* buf, const int& len);

/**
 * @brief  read a file into a string
 * @param  const string& file : file to read
 * @param  string& out, string to store the file contents
 * @return int, number of characters read, or -1 on error
 */
int read_str(const string& file, /* out */ string& out);

/**
 * @brief  write a string to a file
 * @param  const string& file, file to write
 * @param  const string& s, string to write
 * @return int number of characters written, or -1 on error
 */
int write_str(const string& file, /* in */ const string& s);

/**
 * @brief  read a file into a stringstream
 * @param  const string& file, file to read from
 * @param  stringstream& ostrm, stream to store the file contents
 * @return int : number of characters read, or -1 on error
 */
int read_sstream(const string& file, /* out */ stringstream& sstrm);

/**
 * @brief  write a stringstream to a file
 * @param  const string& file, file to write
 * @param  const stringstream& sstrm, stream to write
 * @return int, number of characters written, or -1 on error
 */
int write_sstream(const string& file, /* in */ const stringstream& sstrm);

/**
 * @brief  read lines from a file into a vector of strings
 * @param  const string& file, file to read
 * @param  vector<string>& lines, vector to store the lines
 * @return int, number of lines written, or -1 on errors
 */
int read_lines(const string& file, /* out */ vector<string>& lines);

/**
 * @brief  write lines to a file
 * @param  const string& file, file to write
 * @param  const vector<string>& lines, lines to write
 * @return int, number of lines written, or -1 on error
 */
int write_lines(const string& file, /* in */ const vector<string>& lines);

#endif
