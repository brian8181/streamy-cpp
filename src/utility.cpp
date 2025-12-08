#include <string>
#include <sstream>
#include <cstring>
#include "utility.hpp"

using std::string;
using std::stringstream;

void replace_all(string& s, const string& sub_str, const string& replace_str)
{
    size_t pos = 0;
    size_t len = s.length();

    pos = s.find(sub_str, pos);
    while(pos < len)
    {
        s.replace(pos, sub_str.length(), replace_str);
        pos += replace_str.length();
        pos = s.find(sub_str, pos);
    }
}

void reverse(char str[], int length)
{
    int start = 0;
    int end = length - 1;
    while (start < end) {
        char temp = str[start];
        str[start] = str[end];
        str[end] = temp;
        end--;
        start++;
    }
}

// void to_str<T>(T num, std::string& str)
// {

// }

void long_to_str(long num, std::string& str)
{
    stringstream ss;
    ss << num;
    str = ss.str();
}

void int_to_str(int num, std::string& str)
{
    stringstream ss;
    ss << num;
    str = ss.str();
}

void str_to_int(const std::string& str, int& num)
{
   stringstream ss(str);
   ss >> num;
   if (ss.fail()) {
       throw std::invalid_argument("Invalid input string: " + str);
   }
}

char* citoa(int num, char* str, int base)
{
    int i = 0;
    bool isNegative = false;

    /* Handle 0 explicitly, otherwise empty string is
        * printed for 0 */
    if (num == 0) {
        str[i++] = '0';
        str[i] = '\0';
        return str;
    }

    // In standard itoa(), negative numbers are handled
    // only with base 10. Otherwise numbers are
    // considered unsigned.
    if (num < 0 && base == 10) {
        isNegative = true;
        num = -num;
    }

    // Process individual digits
    while (num != 0) {
        int rem = num % base;
        str[i++] = (rem > 9) ? (rem - 10) + 'a' : rem + '0';
        num = num / base;
    }

    // If number is negative, append '-'
    if (isNegative)
        str[i++] = '-';

    str[i] = '\0'; // Append string terminator

    // Reverse the string
    reverse(str, i);

    return str;
}

int stoi(const string& s, int& n)
{
    n = std::stoi(s);
    return n;
}
