 sexpr       << "(" 
                << EXPR_ARRAY 
                << ")|("
                << EXPR_ACTION_FILE 
                << ")|("  
                << EXPR_VARIABLE
                << ")|(" 
                << EXPR_STATIC_VARIABLE 
                << ")|("
                  << EXPR_ARRAY
                << ")|("
                << EXPR_COMMENT 
                << ")";



// add  pattern .. .

<< @name@
<< ")|(";