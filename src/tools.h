#ifndef _LEX_H
#define _LEX_H

void lex(char* s);

int find(const char* s, const char c);
int find_any(const char* s, const char* chars);
int str_len(const char* s);


//
int char_find(const char* s, const char c);
int _find(const char* s, const char c);
int _str_len(const char* s);

#endif