#include <iostream>
#include "expr.h"


int main(int argc, char** argv)
{
    ast::urnary_expr<int> exp(42);
    ast::literal_expr<int> exp2(55);
    ast::add_expr<int> add_expr(2, 3);
    std::cout << *exp.eval() << std::endl;


}
