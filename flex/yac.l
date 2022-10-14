%{

#include <stdio.h>
#include "yac.tab.h"

%}

%option noyywrap

%%

[0-9] { return DIGIT; }

%%