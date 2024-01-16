#include <fcntl.h>
#include <unistd.h>

void fopen(const char*filename, int flags, mode_t mode)
{
    int ret;
    ret = open(filename, flags, mode);
}

ssize_t fread (int filedes, void *buffer, size_t size)
{
    int ret;
    return ret;
}

ssize_t fpread(int filedes, void *buffer, size_t size, off_t offset)
{
    int ret;
    return ret;
}