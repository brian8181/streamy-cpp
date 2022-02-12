#include "smarty.h"

smarty::smarty() : smarty("temaplate_dir", "complie_dir", "config_dir", "cache_dir")
{

}

smarty::smarty(string template_dir, string complie_dir, string config_dir, string cache_dir) 
{
    template_dir = this->template_dir;
    complie_dir = this->compile_dir;
    config_dir = this->config_dir;
    cache_dir = this->cache_dir;
}

smarty::~smarty()
{

}

bool smarty::assign(string name, string val)
{
    return true;
}

bool smarty::display(string tmpl)
{
    return true;
}