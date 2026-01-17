
#ifndef _TOOL_H_
#define _TOOL_H_

#include <stdio.h>
#include <string.h>
#include "lex_parse.yy.h"
#include "parser.tab.h"

// #define MAX_INCLUDE_DEPTH 10
// YY_BUFFER_STATE include_stack[MAX_INCLUDE_DEPTH];
// static int include_stack_ptr = 0;

/* Same as previous macro, but useful when we know that the buffer stack is not
 * NULL or when we need an lvalue. For internal use only.
 */
#define YY_CURRENT_BUFFER (yy_buffer_stack)[(yy_buffer_stack_top)]


void file_include(char* file)
{
    // /* got the include file name */
    // if ( include_stack_ptr >= MAX_INCLUDE_DEPTH )
    // {
    //     fprintf( stderr, "Includes nested too deeply" );
    //     exit( 1 );
    // }
    // include_stack[include_stack_ptr++] = YY_CURRENT_BUFFER;
    // yyin = fopen( file, "r" );
    // if ( ! yyin )
    // {
    //     printf( "could not open file, %s", file );
    // }
    // yy_switch_to_buffer( yy_create_buffer( yyin, YY_BUF_SIZE ) );
}

char* dupstr(char* s)
{
    char* dup = (char*)malloc((strlen(s) * sizeof(char)) + 1);
    strcpy(dup, s);
    return dup;
}


#endif
