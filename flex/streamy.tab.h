/* A Bison parser, made by GNU Bison 3.7.5.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_STREAMY_TAB_H_INCLUDED
# define YY_YY_STREAMY_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    T_INT = 258,                   /* T_INT  */
    STRING_LITERAL = 259,          /* STRING_LITERAL  */
    INT_LITERAL = 260,             /* INT_LITERAL  */
    T_FLOAT = 261,                 /* T_FLOAT  */
    TEXT = 262,                    /* TEXT  */
    ESCAPE = 263,                  /* ESCAPE  */
    T_CLOSE_BRACE = 264,           /* T_CLOSE_BRACE  */
    T_OPEN_BRACE = 265,            /* T_OPEN_BRACE  */
    T_CLOSE_CURLY = 266,           /* T_CLOSE_CURLY  */
    T_OPEN_CURLY = 267,            /* T_OPEN_CURLY  */
    IF_STATEMENT = 268,            /* IF_STATEMENT  */
    ELSE_STATEMENT = 269,          /* ELSE_STATEMENT  */
    test = 270,                    /* test  */
    T_EQUAL = 271,                 /* T_EQUAL  */
    VARIABLE = 272,                /* VARIABLE  */
    FOREACH_STATEMENT = 273,       /* FOREACH_STATEMENT  */
    T_POUND = 274,                 /* T_POUND  */
    T_ASTREIK = 275,               /* T_ASTREIK  */
    VBAR = 276,                    /* VBAR  */
    AMPERSAND = 277,               /* AMPERSAND  */
    AT_SIGN = 278,                 /* AT_SIGN  */
    DASH = 279,                    /* DASH  */
    UNDERSCORE = 280,              /* UNDERSCORE  */
    DOT = 281,                     /* DOT  */
    LESS_THAN = 282,               /* LESS_THAN  */
    GREATER_THAN = 283,            /* GREATER_THAN  */
    PERCENT = 284,                 /* PERCENT  */
    CARROT = 285,                  /* CARROT  */
    TILDE = 286,                   /* TILDE  */
    QUESTION_MARK = 287,           /* QUESTION_MARK  */
    EXCLAMATION = 288,             /* EXCLAMATION  */
    ENDIF_STATEMENT = 289,         /* ENDIF_STATEMENT  */
    ELSEIF_STATEMENT = 290,        /* ELSEIF_STATEMENT  */
    KEYWORD = 291,                 /* KEYWORD  */
    SINGLE_QUOTE = 292,            /* SINGLE_QUOTE  */
    DOUBLE_QUOTE = 293,            /* DOUBLE_QUOTE  */
    DOLLAR_SIGN = 294,             /* DOLLAR_SIGN  */
    TICK_MARK = 295,               /* TICK_MARK  */
    BACK_SLASH = 296,              /* BACK_SLASH  */
    COLON = 297,                   /* COLON  */
    SEMI_COLON = 298,              /* SEMI_COLON  */
    COMMA = 299,                   /* COMMA  */
    T_PLUS = 300,                  /* T_PLUS  */
    T_MINUS = 301,                 /* T_MINUS  */
    T_MULTIPLY = 302,              /* T_MULTIPLY  */
    T_DIVIDE = 303,                /* T_DIVIDE  */
    T_LEFT = 304,                  /* T_LEFT  */
    T_RIGHT = 305,                 /* T_RIGHT  */
    T_NEWLINE = 306,               /* T_NEWLINE  */
    T_QUIT = 307                   /* T_QUIT  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 13 "streamy.y"

	int ival;
	float fval;
	char* strval;

#line 122 "streamy.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_STREAMY_TAB_H_INCLUDED  */
