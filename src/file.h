// File Name:  fileio.cpp
// Build Date: Sat Nov 25 06:03:48 AM CST 2023
// Version:    3.6.7

#ifndef _FILE_HPP
#define _FILE_HPP

void fopen(const char*filename, int flags, mode_t mode);
ssize_t fread(int filedes, void *buffer, size_t size);
ssize_t fpread (int filedes, void *buffer, size_t size, off_t offset);

#endif