#include <iostream>
#include "expr.h"


int main(int argc, char** argv)
{
    ast::urnary_expr<int> exp(42);
    std::cout << *exp.eval() << std::endl;
}
