#include "smarty.h"

smarty::smarty(string template_dir, string compile_dir, string config_dir, string cache_dir) 
{
    this->template_dir = template_dir;
    this->compile_dir = compile_dir;
    this->config_dir = config_dir;
    this->cache_dir = cache_dir;
}

smarty::~smarty()
{

}

bool smarty::assign(string name, string val)
{
    pair<string, string> p(name, val);
    symbols.insert(p);
    return true;
}

bool smarty::display(string tmpl)
{
    return true;
}