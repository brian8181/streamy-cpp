#ifndef _UTILITY_H_
#define _UTILITY_H_

#include <cstring>
#include <string>

void replace_all(std::string& s, const std::string& sub_str, const std::string& replace_str);

void reverse(char str[], int length);
char* citoa(int num, char* str, int base);

void int_to_str(int num, std::string& str);
void str_to_int(const std::string& str, int& num);

#endif // _UTILITY_H_
