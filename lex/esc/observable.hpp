#ifndef _observable_HPP
#define _observable_HPP

#include <list>
#include "observer.hpp"

using namespace std;

class observable
{

public:
    virtual void subscribe(const observer& obs);

private:
    list<observer> observers;

};

#endif