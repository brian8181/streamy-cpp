// A Bison parser, made by GNU Bison 3.8.2.

// Skeleton implementation for Bison LALR(1) parsers in C++

// Copyright (C) 2002-2015, 2018-2021 Free Software Foundation, Inc.

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

// As a special exception, you may create a larger work that contains
// part or all of the Bison parser skeleton and distribute that work
// under terms of your choice, so long as that work isn't itself a
// parser generator using the skeleton or a modified version thereof
// as a parser skeleton.  Alternatively, if you modify or redistribute
// the parser skeleton itself, you may (at your option) remove this
// special exception, which will cause the skeleton and the resulting
// Bison output files to be licensed under the GNU General Public
// License without this special exception.

// This special exception was added by the Free Software Foundation in
// version 2.2 of Bison.

// DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
// especially those whose name start with YY_ or yy_.  They are
// private implementation details that can be changed or removed.







# include <cstdlib> // std::abort
# include <iostream>
# include <stdexcept>
# include <string>
# include <vector>

#if defined __cplusplus
# define YY_CPLUSPLUS __cplusplus
#else
# define YY_CPLUSPLUS 199711L
#endif

// Support move semantics when possible.
#if 201103L <= YY_CPLUSPLUS
# define YY_MOVE           std::move
# define YY_MOVE_OR_COPY   move
# define YY_MOVE_REF(Type) Type&&
# define YY_RVREF(Type)    Type&&
# define YY_COPY(Type)     Type
#else
# define YY_MOVE
# define YY_MOVE_OR_COPY   copy
# define YY_MOVE_REF(Type) Type&
# define YY_RVREF(Type)    const Type&
# define YY_COPY(Type)     const Type&
#endif

// Support noexcept when possible.
#if 201103L <= YY_CPLUSPLUS
# define YY_NOEXCEPT noexcept
# define YY_NOTHROW
#else
# define YY_NOEXCEPT
# define YY_NOTHROW throw ()
#endif

// Support constexpr when possible.
#if 201703 <= YY_CPLUSPLUS
# define YY_CONSTEXPR constexpr
#else
# define YY_CONSTEXPR
#endif



#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
#if defined __GNUC__ && ! defined __ICC && 406 <= __GNUC__ * 100 + __GNUC_MINOR__
# if __GNUC__ * 100 + __GNUC_MINOR__ < 407
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")
# else
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# endif
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

namespace yy {
#line 176 "parser2.cc"




  /// A Bison parser.
  class parser
  {
  public:
#ifdef YYSTYPE
# ifdef __GNUC__
#  pragma GCC message "bison: do not #define YYSTYPE in C++, use %define api.value.type"
# endif
    typedef YYSTYPE value_type;
#else
  /// A buffer to store and retrieve objects.
  ///
  /// Sort of a variant, but does not keep track of the nature
  /// of the stored data, since that knowledge is available
  /// via the current parser state.
  class value_type
  {
  public:
    /// Type of *this.
    typedef value_type self_type;

    /// Empty construction.
    value_type () YY_NOEXCEPT
      : yyraw_ ()
    {}

    /// Construct and fill.
    template <typename T>
    value_type (YY_RVREF (T) t)
    {
      new (yyas_<T> ()) T (YY_MOVE (t));
    }

#if 201103L <= YY_CPLUSPLUS
    /// Non copyable.
    value_type (const self_type&) = delete;
    /// Non copyable.
    self_type& operator= (const self_type&) = delete;
#endif

    /// Destruction, allowed only if empty.
    ~value_type () YY_NOEXCEPT
    {}

# if 201103L <= YY_CPLUSPLUS
    /// Instantiate a \a T in here from \a t.
    template <typename T, typename... U>
    T&
    emplace (U&&... u)
    {
      return *new (yyas_<T> ()) T (std::forward <U>(u)...);
    }
# else
    /// Instantiate an empty \a T in here.
    template <typename T>
    T&
    emplace ()
    {
      return *new (yyas_<T> ()) T ();
    }

    /// Instantiate a \a T in here from \a t.
    template <typename T>
    T&
    emplace (const T& t)
    {
      return *new (yyas_<T> ()) T (t);
    }
# endif

    /// Instantiate an empty \a T in here.
    /// Obsolete, use emplace.
    template <typename T>
    T&
    build ()
    {
      return emplace<T> ();
    }

    /// Instantiate a \a T in here from \a t.
    /// Obsolete, use emplace.
    template <typename T>
    T&
    build (const T& t)
    {
      return emplace<T> (t);
    }

    /// Accessor to a built \a T.
    template <typename T>
    T&
    as () YY_NOEXCEPT
    {
      return *yyas_<T> ();
    }

    /// Const accessor to a built \a T (for %printer).
    template <typename T>
    const T&
    as () const YY_NOEXCEPT
    {
      return *yyas_<T> ();
    }

    /// Swap the content with \a that, of same type.
    ///
    /// Both variants must be built beforehand, because swapping the actual
    /// data requires reading it (with as()), and this is not possible on
    /// unconstructed variants: it would require some dynamic testing, which
    /// should not be the variant's responsibility.
    /// Swapping between built and (possibly) non-built is done with
    /// self_type::move ().
    template <typename T>
    void
    swap (self_type& that) YY_NOEXCEPT
    {
      std::swap (as<T> (), that.as<T> ());
    }

    /// Move the content of \a that to this.
    ///
    /// Destroys \a that.
    template <typename T>
    void
    move (self_type& that)
    {
# if 201103L <= YY_CPLUSPLUS
      emplace<T> (std::move (that.as<T> ()));
# else
      emplace<T> ();
      swap<T> (that);
# endif
      that.destroy<T> ();
    }

# if 201103L <= YY_CPLUSPLUS
    /// Move the content of \a that to this.
    template <typename T>
    void
    move (self_type&& that)
    {
      emplace<T> (std::move (that.as<T> ()));
      that.destroy<T> ();
    }
#endif

    /// Copy the content of \a that to this.
    template <typename T>
    void
    copy (const self_type& that)
    {
      emplace<T> (that.as<T> ());
    }

    /// Destroy the stored \a T.
    template <typename T>
    void
    destroy ()
    {
      as<T> ().~T ();
    }

  private:
#if YY_CPLUSPLUS < 201103L
    /// Non copyable.
    value_type (const self_type&);
    /// Non copyable.
    self_type& operator= (const self_type&);
#endif

    /// Accessor to raw memory as \a T.
    template <typename T>
    T*
    yyas_ () YY_NOEXCEPT
    {
      void *yyp = yyraw_;
      return static_cast<T*> (yyp);
     }

    /// Const accessor to raw memory as \a T.
    template <typename T>
    const T*
    yyas_ () const YY_NOEXCEPT
    {
      const void *yyp = yyraw_;
      return static_cast<const T*> (yyp);
     }

    /// An auxiliary type to compute the largest semantic type.
    union union_type
    {
      // NUMBER
      char dummy1[sizeof (int)];

      // attrib
      char dummy2[sizeof (std::pair< std::string, std::string >)];

      // TEXT
      // DOLLAR_SIGN
      // DOT
      // INDIRECT_MEMBER
      // COMMA
      // EQUAL
      // VBAR
      // COLON
      // STRING_LITERAL
      // NUMERIC_LITERAL
      // ID
      // SYMBOL
      // CONST_SYMBOL
      // LBRACE
      // RBRACE
      // LBRACKET
      // RBRACKET
      // LPAREN
      // RPAREN
      // CONFIG_LOAD
      // INCLUDE
      // REQUIRE
      // INSERT
      // ASSIGN
      // CAPITALIZE
      // CAT
      // COUNT_CHARACTERS
      // COUNT_SENTENCES
      // COUNT_PARAGRAPHS
      // DATE_FORMAT
      // ESCAPE
      // INDENT
      // LOWER
      // UPPER
      // STRIP
      // REPLACE
      // SPACIFY
      // STRING_FORMAT
      // STRIP_TAGS
      // TRUNCATE
      // WORDWARP
      // VAR_ATTRIB
      // VALUE_ATTRIB
      // FILE_ATTRIB
      // FILE_NAME
      // colon_sep_params
      // colon_sep_param
      // qualafied_id
      // sub_proc
      // array
      // symbol
      // modifier
      // built_in
      // attributes
      char dummy3[sizeof (std::string)];
    };

    /// The size of the largest semantic type.
    enum { size = sizeof (union_type) };

    /// A buffer to store semantic values.
    union
    {
      /// Strongest alignment constraints.
      long double yyalign_me_;
      /// A buffer large enough to store any of the semantic values.
      char yyraw_[size];
    };
  };

#endif
    /// Backward compatibility (Bison 3.8).
    typedef value_type semantic_type;


    /// Syntax errors thrown from user actions.
    struct syntax_error : std::runtime_error
    {
      syntax_error (const std::string& m)
        : std::runtime_error (m)
      {}

      syntax_error (const syntax_error& s)
        : std::runtime_error (s.what ())
      {}

      ~syntax_error () YY_NOEXCEPT YY_NOTHROW;
    };

    /// Token kinds.
    struct token
    {
      enum token_kind_type
      {
        YYEMPTY = -2,
    END = 0,                       // "end of input"
    YYerror = 256,                 // error
    YYUNDEF = 257,                 // "invalid token"
    TEXT = 258,                    // TEXT
    END_OF_FILES = 259,            // END_OF_FILES
    NUMBER = 260,                  // NUMBER
    DOLLAR_SIGN = 261,             // DOLLAR_SIGN
    DOT = 262,                     // DOT
    INDIRECT_MEMBER = 263,         // INDIRECT_MEMBER
    COMMA = 264,                   // COMMA
    EQUAL = 265,                   // EQUAL
    VBAR = 266,                    // VBAR
    COLON = 267,                   // COLON
    STRING_LITERAL = 268,          // STRING_LITERAL
    NUMERIC_LITERAL = 269,         // NUMERIC_LITERAL
    ID = 270,                      // ID
    SYMBOL = 271,                  // SYMBOL
    CONST_SYMBOL = 272,            // CONST_SYMBOL
    LBRACE = 273,                  // LBRACE
    RBRACE = 274,                  // RBRACE
    LBRACKET = 275,                // LBRACKET
    RBRACKET = 276,                // RBRACKET
    LPAREN = 277,                  // LPAREN
    RPAREN = 278,                  // RPAREN
    CONFIG_LOAD = 279,             // CONFIG_LOAD
    INCLUDE = 280,                 // INCLUDE
    REQUIRE = 281,                 // REQUIRE
    INSERT = 282,                  // INSERT
    ASSIGN = 283,                  // ASSIGN
    CAPITALIZE = 284,              // CAPITALIZE
    CAT = 285,                     // CAT
    COUNT_CHARACTERS = 286,        // COUNT_CHARACTERS
    COUNT_SENTENCES = 287,         // COUNT_SENTENCES
    COUNT_PARAGRAPHS = 288,        // COUNT_PARAGRAPHS
    DATE_FORMAT = 289,             // DATE_FORMAT
    ESCAPE = 290,                  // ESCAPE
    INDENT = 291,                  // INDENT
    LOWER = 292,                   // LOWER
    UPPER = 293,                   // UPPER
    STRIP = 294,                   // STRIP
    REPLACE = 295,                 // REPLACE
    SPACIFY = 296,                 // SPACIFY
    STRING_FORMAT = 297,           // STRING_FORMAT
    STRIP_TAGS = 298,              // STRIP_TAGS
    TRUNCATE = 299,                // TRUNCATE
    WORDWARP = 300,                // WORDWARP
    VAR_ATTRIB = 301,              // VAR_ATTRIB
    VALUE_ATTRIB = 302,            // VALUE_ATTRIB
    FILE_ATTRIB = 303,             // FILE_ATTRIB
    FILE_NAME = 304                // FILE_NAME
      };
      /// Backward compatibility alias (Bison 3.6).
      typedef token_kind_type yytokentype;
    };

    /// Token kind, as returned by yylex.
    typedef token::token_kind_type token_kind_type;

    /// Backward compatibility alias (Bison 3.6).
    typedef token_kind_type token_type;

    /// Symbol kinds.
    struct symbol_kind
    {
      enum symbol_kind_type
      {
        YYNTOKENS = 50, ///< Number of tokens.
        S_YYEMPTY = -2,
        S_YYEOF = 0,                             // "end of input"
        S_YYerror = 1,                           // error
        S_YYUNDEF = 2,                           // "invalid token"
        S_TEXT = 3,                              // TEXT
        S_END_OF_FILES = 4,                      // END_OF_FILES
        S_NUMBER = 5,                            // NUMBER
        S_DOLLAR_SIGN = 6,                       // DOLLAR_SIGN
        S_DOT = 7,                               // DOT
        S_INDIRECT_MEMBER = 8,                   // INDIRECT_MEMBER
        S_COMMA = 9,                             // COMMA
        S_EQUAL = 10,                            // EQUAL
        S_VBAR = 11,                             // VBAR
        S_COLON = 12,                            // COLON
        S_STRING_LITERAL = 13,                   // STRING_LITERAL
        S_NUMERIC_LITERAL = 14,                  // NUMERIC_LITERAL
        S_ID = 15,                               // ID
        S_SYMBOL = 16,                           // SYMBOL
        S_CONST_SYMBOL = 17,                     // CONST_SYMBOL
        S_LBRACE = 18,                           // LBRACE
        S_RBRACE = 19,                           // RBRACE
        S_LBRACKET = 20,                         // LBRACKET
        S_RBRACKET = 21,                         // RBRACKET
        S_LPAREN = 22,                           // LPAREN
        S_RPAREN = 23,                           // RPAREN
        S_CONFIG_LOAD = 24,                      // CONFIG_LOAD
        S_INCLUDE = 25,                          // INCLUDE
        S_REQUIRE = 26,                          // REQUIRE
        S_INSERT = 27,                           // INSERT
        S_ASSIGN = 28,                           // ASSIGN
        S_CAPITALIZE = 29,                       // CAPITALIZE
        S_CAT = 30,                              // CAT
        S_COUNT_CHARACTERS = 31,                 // COUNT_CHARACTERS
        S_COUNT_SENTENCES = 32,                  // COUNT_SENTENCES
        S_COUNT_PARAGRAPHS = 33,                 // COUNT_PARAGRAPHS
        S_DATE_FORMAT = 34,                      // DATE_FORMAT
        S_ESCAPE = 35,                           // ESCAPE
        S_INDENT = 36,                           // INDENT
        S_LOWER = 37,                            // LOWER
        S_UPPER = 38,                            // UPPER
        S_STRIP = 39,                            // STRIP
        S_REPLACE = 40,                          // REPLACE
        S_SPACIFY = 41,                          // SPACIFY
        S_STRING_FORMAT = 42,                    // STRING_FORMAT
        S_STRIP_TAGS = 43,                       // STRIP_TAGS
        S_TRUNCATE = 44,                         // TRUNCATE
        S_WORDWARP = 45,                         // WORDWARP
        S_VAR_ATTRIB = 46,                       // VAR_ATTRIB
        S_VALUE_ATTRIB = 47,                     // VALUE_ATTRIB
        S_FILE_ATTRIB = 48,                      // FILE_ATTRIB
        S_FILE_NAME = 49,                        // FILE_NAME
        S_YYACCEPT = 50,                         // $accept
        S_exe = 51,                              // exe
        S_files = 52,                            // files
        S_file = 53,                             // file
        S_blocks = 54,                           // blocks
        S_tag = 55,                              // tag
        S_colon_sep_params = 56,                 // colon_sep_params
        S_colon_sep_param = 57,                  // colon_sep_param
        S_params = 58,                           // params
        S_param = 59,                            // param
        S_qualafied_id = 60,                     // qualafied_id
        S_sub_proc = 61,                         // sub_proc
        S_array = 62,                            // array
        S_symbol = 63,                           // symbol
        S_modifier = 64,                         // modifier
        S_built_in = 65,                         // built_in
        S_attributes = 66,                       // attributes
        S_attrib = 67                            // attrib
      };
    };

    /// (Internal) symbol kind.
    typedef symbol_kind::symbol_kind_type symbol_kind_type;

    /// The number of tokens.
    static const symbol_kind_type YYNTOKENS = symbol_kind::YYNTOKENS;

    /// A complete symbol.
    ///
    /// Expects its Base type to provide access to the symbol kind
    /// via kind ().
    ///
    /// Provide access to semantic value.
    template <typename Base>
    struct basic_symbol : Base
    {
      /// Alias to Base.
      typedef Base super_type;

      /// Default constructor.
      basic_symbol () YY_NOEXCEPT
        : value ()
      {}

#if 201103L <= YY_CPLUSPLUS
      /// Move constructor.
      basic_symbol (basic_symbol&& that)
        : Base (std::move (that))
        , value ()
      {
        switch (this->kind ())
    {
      case symbol_kind::S_NUMBER: // NUMBER
        value.move< int > (std::move (that.value));
        break;

      case symbol_kind::S_attrib: // attrib
        value.move< std::pair< std::string, std::string > > (std::move (that.value));
        break;

      case symbol_kind::S_TEXT: // TEXT
      case symbol_kind::S_DOLLAR_SIGN: // DOLLAR_SIGN
      case symbol_kind::S_DOT: // DOT
      case symbol_kind::S_INDIRECT_MEMBER: // INDIRECT_MEMBER
      case symbol_kind::S_COMMA: // COMMA
      case symbol_kind::S_EQUAL: // EQUAL
      case symbol_kind::S_VBAR: // VBAR
      case symbol_kind::S_COLON: // COLON
      case symbol_kind::S_STRING_LITERAL: // STRING_LITERAL
      case symbol_kind::S_NUMERIC_LITERAL: // NUMERIC_LITERAL
      case symbol_kind::S_ID: // ID
      case symbol_kind::S_SYMBOL: // SYMBOL
      case symbol_kind::S_CONST_SYMBOL: // CONST_SYMBOL
      case symbol_kind::S_LBRACE: // LBRACE
      case symbol_kind::S_RBRACE: // RBRACE
      case symbol_kind::S_LBRACKET: // LBRACKET
      case symbol_kind::S_RBRACKET: // RBRACKET
      case symbol_kind::S_LPAREN: // LPAREN
      case symbol_kind::S_RPAREN: // RPAREN
      case symbol_kind::S_CONFIG_LOAD: // CONFIG_LOAD
      case symbol_kind::S_INCLUDE: // INCLUDE
      case symbol_kind::S_REQUIRE: // REQUIRE
      case symbol_kind::S_INSERT: // INSERT
      case symbol_kind::S_ASSIGN: // ASSIGN
      case symbol_kind::S_CAPITALIZE: // CAPITALIZE
      case symbol_kind::S_CAT: // CAT
      case symbol_kind::S_COUNT_CHARACTERS: // COUNT_CHARACTERS
      case symbol_kind::S_COUNT_SENTENCES: // COUNT_SENTENCES
      case symbol_kind::S_COUNT_PARAGRAPHS: // COUNT_PARAGRAPHS
      case symbol_kind::S_DATE_FORMAT: // DATE_FORMAT
      case symbol_kind::S_ESCAPE: // ESCAPE
      case symbol_kind::S_INDENT: // INDENT
      case symbol_kind::S_LOWER: // LOWER
      case symbol_kind::S_UPPER: // UPPER
      case symbol_kind::S_STRIP: // STRIP
      case symbol_kind::S_REPLACE: // REPLACE
      case symbol_kind::S_SPACIFY: // SPACIFY
      case symbol_kind::S_STRING_FORMAT: // STRING_FORMAT
      case symbol_kind::S_STRIP_TAGS: // STRIP_TAGS
      case symbol_kind::S_TRUNCATE: // TRUNCATE
      case symbol_kind::S_WORDWARP: // WORDWARP
      case symbol_kind::S_VAR_ATTRIB: // VAR_ATTRIB
      case symbol_kind::S_VALUE_ATTRIB: // VALUE_ATTRIB
      case symbol_kind::S_FILE_ATTRIB: // FILE_ATTRIB
      case symbol_kind::S_FILE_NAME: // FILE_NAME
      case symbol_kind::S_colon_sep_params: // colon_sep_params
      case symbol_kind::S_colon_sep_param: // colon_sep_param
      case symbol_kind::S_qualafied_id: // qualafied_id
      case symbol_kind::S_sub_proc: // sub_proc
      case symbol_kind::S_array: // array
      case symbol_kind::S_symbol: // symbol
      case symbol_kind::S_modifier: // modifier
      case symbol_kind::S_built_in: // built_in
      case symbol_kind::S_attributes: // attributes
        value.move< std::string > (std::move (that.value));
        break;

      default:
        break;
    }

      }
#endif

      /// Copy constructor.
      basic_symbol (const basic_symbol& that);

      /// Constructors for typed symbols.
#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t)
        : Base (t)
      {}
#else
      basic_symbol (typename Base::kind_type t)
        : Base (t)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, int&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const int& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, std::pair< std::string, std::string >&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const std::pair< std::string, std::string >& v)
        : Base (t)
        , value (v)
      {}
#endif

#if 201103L <= YY_CPLUSPLUS
      basic_symbol (typename Base::kind_type t, std::string&& v)
        : Base (t)
        , value (std::move (v))
      {}
#else
      basic_symbol (typename Base::kind_type t, const std::string& v)
        : Base (t)
        , value (v)
      {}
#endif

      /// Destroy the symbol.
      ~basic_symbol ()
      {
        clear ();
      }



      /// Destroy contents, and record that is empty.
      void clear () YY_NOEXCEPT
      {
        // User destructor.
        symbol_kind_type yykind = this->kind ();
        basic_symbol<Base>& yysym = *this;
        (void) yysym;
        switch (yykind)
        {
       default:
          break;
        }

        // Value type destructor.
switch (yykind)
    {
      case symbol_kind::S_NUMBER: // NUMBER
        value.template destroy< int > ();
        break;

      case symbol_kind::S_attrib: // attrib
        value.template destroy< std::pair< std::string, std::string > > ();
        break;

      case symbol_kind::S_TEXT: // TEXT
      case symbol_kind::S_DOLLAR_SIGN: // DOLLAR_SIGN
      case symbol_kind::S_DOT: // DOT
      case symbol_kind::S_INDIRECT_MEMBER: // INDIRECT_MEMBER
      case symbol_kind::S_COMMA: // COMMA
      case symbol_kind::S_EQUAL: // EQUAL
      case symbol_kind::S_VBAR: // VBAR
      case symbol_kind::S_COLON: // COLON
      case symbol_kind::S_STRING_LITERAL: // STRING_LITERAL
      case symbol_kind::S_NUMERIC_LITERAL: // NUMERIC_LITERAL
      case symbol_kind::S_ID: // ID
      case symbol_kind::S_SYMBOL: // SYMBOL
      case symbol_kind::S_CONST_SYMBOL: // CONST_SYMBOL
      case symbol_kind::S_LBRACE: // LBRACE
      case symbol_kind::S_RBRACE: // RBRACE
      case symbol_kind::S_LBRACKET: // LBRACKET
      case symbol_kind::S_RBRACKET: // RBRACKET
      case symbol_kind::S_LPAREN: // LPAREN
      case symbol_kind::S_RPAREN: // RPAREN
      case symbol_kind::S_CONFIG_LOAD: // CONFIG_LOAD
      case symbol_kind::S_INCLUDE: // INCLUDE
      case symbol_kind::S_REQUIRE: // REQUIRE
      case symbol_kind::S_INSERT: // INSERT
      case symbol_kind::S_ASSIGN: // ASSIGN
      case symbol_kind::S_CAPITALIZE: // CAPITALIZE
      case symbol_kind::S_CAT: // CAT
      case symbol_kind::S_COUNT_CHARACTERS: // COUNT_CHARACTERS
      case symbol_kind::S_COUNT_SENTENCES: // COUNT_SENTENCES
      case symbol_kind::S_COUNT_PARAGRAPHS: // COUNT_PARAGRAPHS
      case symbol_kind::S_DATE_FORMAT: // DATE_FORMAT
      case symbol_kind::S_ESCAPE: // ESCAPE
      case symbol_kind::S_INDENT: // INDENT
      case symbol_kind::S_LOWER: // LOWER
      case symbol_kind::S_UPPER: // UPPER
      case symbol_kind::S_STRIP: // STRIP
      case symbol_kind::S_REPLACE: // REPLACE
      case symbol_kind::S_SPACIFY: // SPACIFY
      case symbol_kind::S_STRING_FORMAT: // STRING_FORMAT
      case symbol_kind::S_STRIP_TAGS: // STRIP_TAGS
      case symbol_kind::S_TRUNCATE: // TRUNCATE
      case symbol_kind::S_WORDWARP: // WORDWARP
      case symbol_kind::S_VAR_ATTRIB: // VAR_ATTRIB
      case symbol_kind::S_VALUE_ATTRIB: // VALUE_ATTRIB
      case symbol_kind::S_FILE_ATTRIB: // FILE_ATTRIB
      case symbol_kind::S_FILE_NAME: // FILE_NAME
      case symbol_kind::S_colon_sep_params: // colon_sep_params
      case symbol_kind::S_colon_sep_param: // colon_sep_param
      case symbol_kind::S_qualafied_id: // qualafied_id
      case symbol_kind::S_sub_proc: // sub_proc
      case symbol_kind::S_array: // array
      case symbol_kind::S_symbol: // symbol
      case symbol_kind::S_modifier: // modifier
      case symbol_kind::S_built_in: // built_in
      case symbol_kind::S_attributes: // attributes
        value.template destroy< std::string > ();
        break;

      default:
        break;
    }

        Base::clear ();
      }

#if YYDEBUG || 0
      /// The user-facing name of this symbol.
      const char *name () const YY_NOEXCEPT
      {
        return parser::symbol_name (this->kind ());
      }
#endif // #if YYDEBUG || 0


      /// Backward compatibility (Bison 3.6).
      symbol_kind_type type_get () const YY_NOEXCEPT;

      /// Whether empty.
      bool empty () const YY_NOEXCEPT;

      /// Destructive move, \a s is emptied into this.
      void move (basic_symbol& s);

      /// The semantic value.
      value_type value;

    private:
#if YY_CPLUSPLUS < 201103L
      /// Assignment operator.
      basic_symbol& operator= (const basic_symbol& that);
#endif
    };

    /// Type access provider for token (enum) based symbols.
    struct by_kind
    {
      /// The symbol kind as needed by the constructor.
      typedef token_kind_type kind_type;

      /// Default constructor.
      by_kind () YY_NOEXCEPT;

#if 201103L <= YY_CPLUSPLUS
      /// Move constructor.
      by_kind (by_kind&& that) YY_NOEXCEPT;
#endif

      /// Copy constructor.
      by_kind (const by_kind& that) YY_NOEXCEPT;

      /// Constructor from (external) token numbers.
      by_kind (kind_type t) YY_NOEXCEPT;



      /// Record that this symbol is empty.
      void clear () YY_NOEXCEPT;

      /// Steal the symbol kind from \a that.
      void move (by_kind& that);

      /// The (internal) type number (corresponding to \a type).
      /// \a empty when empty.
      symbol_kind_type kind () const YY_NOEXCEPT;

      /// Backward compatibility (Bison 3.6).
      symbol_kind_type type_get () const YY_NOEXCEPT;

      /// The symbol kind.
      /// \a S_YYEMPTY when empty.
      symbol_kind_type kind_;
    };

    /// Backward compatibility for a private implementation detail (Bison 3.6).
    typedef by_kind by_type;

    /// "External" symbols: returned by the scanner.
    struct symbol_type : basic_symbol<by_kind>
    {
      /// Superclass.
      typedef basic_symbol<by_kind> super_type;

      /// Empty symbol.
      symbol_type () YY_NOEXCEPT {}

      /// Constructor for valueless symbols, and symbols from each type.
#if 201103L <= YY_CPLUSPLUS
      symbol_type (int tok)
        : super_type (token_kind_type (tok))
#else
      symbol_type (int tok)
        : super_type (token_kind_type (tok))
#endif
      {}
#if 201103L <= YY_CPLUSPLUS
      symbol_type (int tok, int v)
        : super_type (token_kind_type (tok), std::move (v))
#else
      symbol_type (int tok, const int& v)
        : super_type (token_kind_type (tok), v)
#endif
      {}
#if 201103L <= YY_CPLUSPLUS
      symbol_type (int tok, std::string v)
        : super_type (token_kind_type (tok), std::move (v))
#else
      symbol_type (int tok, const std::string& v)
        : super_type (token_kind_type (tok), v)
#endif
      {}
    };

    /// Build a parser object.
    parser ();
    virtual ~parser ();

#if 201103L <= YY_CPLUSPLUS
    /// Non copyable.
    parser (const parser&) = delete;
    /// Non copyable.
    parser& operator= (const parser&) = delete;
#endif

    /// Parse.  An alias for parse ().
    /// \returns  0 iff parsing succeeded.
    int operator() ();

    /// Parse.
    /// \returns  0 iff parsing succeeded.
    virtual int parse ();

#if YYDEBUG
    /// The current debugging stream.
    std::ostream& debug_stream () const YY_ATTRIBUTE_PURE;
    /// Set the current debugging stream.
    void set_debug_stream (std::ostream &);

    /// Type for debugging levels.
    typedef int debug_level_type;
    /// The current debugging level.
    debug_level_type debug_level () const YY_ATTRIBUTE_PURE;
    /// Set the current debugging level.
    void set_debug_level (debug_level_type l);
#endif

    /// Report a syntax error.
    /// \param msg    a description of the syntax error.
    virtual void error (const std::string& msg);

    /// Report a syntax error.
    void error (const syntax_error& err);

#if YYDEBUG || 0
    /// The user-facing name of the symbol whose (internal) number is
    /// YYSYMBOL.  No bounds checking.
    static const char *symbol_name (symbol_kind_type yysymbol);
#endif // #if YYDEBUG || 0


    // Implementation of make_symbol for each token kind.
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_END ()
      {
        return symbol_type (token::END);
      }
#else
      static
      symbol_type
      make_END ()
      {
        return symbol_type (token::END);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_YYerror ()
      {
        return symbol_type (token::YYerror);
      }
#else
      static
      symbol_type
      make_YYerror ()
      {
        return symbol_type (token::YYerror);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_YYUNDEF ()
      {
        return symbol_type (token::YYUNDEF);
      }
#else
      static
      symbol_type
      make_YYUNDEF ()
      {
        return symbol_type (token::YYUNDEF);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_TEXT (std::string v)
      {
        return symbol_type (token::TEXT, std::move (v));
      }
#else
      static
      symbol_type
      make_TEXT (const std::string& v)
      {
        return symbol_type (token::TEXT, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_END_OF_FILES ()
      {
        return symbol_type (token::END_OF_FILES);
      }
#else
      static
      symbol_type
      make_END_OF_FILES ()
      {
        return symbol_type (token::END_OF_FILES);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_NUMBER (int v)
      {
        return symbol_type (token::NUMBER, std::move (v));
      }
#else
      static
      symbol_type
      make_NUMBER (const int& v)
      {
        return symbol_type (token::NUMBER, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_DOLLAR_SIGN (std::string v)
      {
        return symbol_type (token::DOLLAR_SIGN, std::move (v));
      }
#else
      static
      symbol_type
      make_DOLLAR_SIGN (const std::string& v)
      {
        return symbol_type (token::DOLLAR_SIGN, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_DOT (std::string v)
      {
        return symbol_type (token::DOT, std::move (v));
      }
#else
      static
      symbol_type
      make_DOT (const std::string& v)
      {
        return symbol_type (token::DOT, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_INDIRECT_MEMBER (std::string v)
      {
        return symbol_type (token::INDIRECT_MEMBER, std::move (v));
      }
#else
      static
      symbol_type
      make_INDIRECT_MEMBER (const std::string& v)
      {
        return symbol_type (token::INDIRECT_MEMBER, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_COMMA (std::string v)
      {
        return symbol_type (token::COMMA, std::move (v));
      }
#else
      static
      symbol_type
      make_COMMA (const std::string& v)
      {
        return symbol_type (token::COMMA, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_EQUAL (std::string v)
      {
        return symbol_type (token::EQUAL, std::move (v));
      }
#else
      static
      symbol_type
      make_EQUAL (const std::string& v)
      {
        return symbol_type (token::EQUAL, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_VBAR (std::string v)
      {
        return symbol_type (token::VBAR, std::move (v));
      }
#else
      static
      symbol_type
      make_VBAR (const std::string& v)
      {
        return symbol_type (token::VBAR, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_COLON (std::string v)
      {
        return symbol_type (token::COLON, std::move (v));
      }
#else
      static
      symbol_type
      make_COLON (const std::string& v)
      {
        return symbol_type (token::COLON, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_STRING_LITERAL (std::string v)
      {
        return symbol_type (token::STRING_LITERAL, std::move (v));
      }
#else
      static
      symbol_type
      make_STRING_LITERAL (const std::string& v)
      {
        return symbol_type (token::STRING_LITERAL, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_NUMERIC_LITERAL (std::string v)
      {
        return symbol_type (token::NUMERIC_LITERAL, std::move (v));
      }
#else
      static
      symbol_type
      make_NUMERIC_LITERAL (const std::string& v)
      {
        return symbol_type (token::NUMERIC_LITERAL, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_ID (std::string v)
      {
        return symbol_type (token::ID, std::move (v));
      }
#else
      static
      symbol_type
      make_ID (const std::string& v)
      {
        return symbol_type (token::ID, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_SYMBOL (std::string v)
      {
        return symbol_type (token::SYMBOL, std::move (v));
      }
#else
      static
      symbol_type
      make_SYMBOL (const std::string& v)
      {
        return symbol_type (token::SYMBOL, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_CONST_SYMBOL (std::string v)
      {
        return symbol_type (token::CONST_SYMBOL, std::move (v));
      }
#else
      static
      symbol_type
      make_CONST_SYMBOL (const std::string& v)
      {
        return symbol_type (token::CONST_SYMBOL, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_LBRACE (std::string v)
      {
        return symbol_type (token::LBRACE, std::move (v));
      }
#else
      static
      symbol_type
      make_LBRACE (const std::string& v)
      {
        return symbol_type (token::LBRACE, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_RBRACE (std::string v)
      {
        return symbol_type (token::RBRACE, std::move (v));
      }
#else
      static
      symbol_type
      make_RBRACE (const std::string& v)
      {
        return symbol_type (token::RBRACE, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_LBRACKET (std::string v)
      {
        return symbol_type (token::LBRACKET, std::move (v));
      }
#else
      static
      symbol_type
      make_LBRACKET (const std::string& v)
      {
        return symbol_type (token::LBRACKET, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_RBRACKET (std::string v)
      {
        return symbol_type (token::RBRACKET, std::move (v));
      }
#else
      static
      symbol_type
      make_RBRACKET (const std::string& v)
      {
        return symbol_type (token::RBRACKET, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_LPAREN (std::string v)
      {
        return symbol_type (token::LPAREN, std::move (v));
      }
#else
      static
      symbol_type
      make_LPAREN (const std::string& v)
      {
        return symbol_type (token::LPAREN, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_RPAREN (std::string v)
      {
        return symbol_type (token::RPAREN, std::move (v));
      }
#else
      static
      symbol_type
      make_RPAREN (const std::string& v)
      {
        return symbol_type (token::RPAREN, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_CONFIG_LOAD (std::string v)
      {
        return symbol_type (token::CONFIG_LOAD, std::move (v));
      }
#else
      static
      symbol_type
      make_CONFIG_LOAD (const std::string& v)
      {
        return symbol_type (token::CONFIG_LOAD, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_INCLUDE (std::string v)
      {
        return symbol_type (token::INCLUDE, std::move (v));
      }
#else
      static
      symbol_type
      make_INCLUDE (const std::string& v)
      {
        return symbol_type (token::INCLUDE, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_REQUIRE (std::string v)
      {
        return symbol_type (token::REQUIRE, std::move (v));
      }
#else
      static
      symbol_type
      make_REQUIRE (const std::string& v)
      {
        return symbol_type (token::REQUIRE, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_INSERT (std::string v)
      {
        return symbol_type (token::INSERT, std::move (v));
      }
#else
      static
      symbol_type
      make_INSERT (const std::string& v)
      {
        return symbol_type (token::INSERT, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_ASSIGN (std::string v)
      {
        return symbol_type (token::ASSIGN, std::move (v));
      }
#else
      static
      symbol_type
      make_ASSIGN (const std::string& v)
      {
        return symbol_type (token::ASSIGN, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_CAPITALIZE (std::string v)
      {
        return symbol_type (token::CAPITALIZE, std::move (v));
      }
#else
      static
      symbol_type
      make_CAPITALIZE (const std::string& v)
      {
        return symbol_type (token::CAPITALIZE, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_CAT (std::string v)
      {
        return symbol_type (token::CAT, std::move (v));
      }
#else
      static
      symbol_type
      make_CAT (const std::string& v)
      {
        return symbol_type (token::CAT, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_COUNT_CHARACTERS (std::string v)
      {
        return symbol_type (token::COUNT_CHARACTERS, std::move (v));
      }
#else
      static
      symbol_type
      make_COUNT_CHARACTERS (const std::string& v)
      {
        return symbol_type (token::COUNT_CHARACTERS, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_COUNT_SENTENCES (std::string v)
      {
        return symbol_type (token::COUNT_SENTENCES, std::move (v));
      }
#else
      static
      symbol_type
      make_COUNT_SENTENCES (const std::string& v)
      {
        return symbol_type (token::COUNT_SENTENCES, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_COUNT_PARAGRAPHS (std::string v)
      {
        return symbol_type (token::COUNT_PARAGRAPHS, std::move (v));
      }
#else
      static
      symbol_type
      make_COUNT_PARAGRAPHS (const std::string& v)
      {
        return symbol_type (token::COUNT_PARAGRAPHS, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_DATE_FORMAT (std::string v)
      {
        return symbol_type (token::DATE_FORMAT, std::move (v));
      }
#else
      static
      symbol_type
      make_DATE_FORMAT (const std::string& v)
      {
        return symbol_type (token::DATE_FORMAT, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_ESCAPE (std::string v)
      {
        return symbol_type (token::ESCAPE, std::move (v));
      }
#else
      static
      symbol_type
      make_ESCAPE (const std::string& v)
      {
        return symbol_type (token::ESCAPE, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_INDENT (std::string v)
      {
        return symbol_type (token::INDENT, std::move (v));
      }
#else
      static
      symbol_type
      make_INDENT (const std::string& v)
      {
        return symbol_type (token::INDENT, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_LOWER (std::string v)
      {
        return symbol_type (token::LOWER, std::move (v));
      }
#else
      static
      symbol_type
      make_LOWER (const std::string& v)
      {
        return symbol_type (token::LOWER, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_UPPER (std::string v)
      {
        return symbol_type (token::UPPER, std::move (v));
      }
#else
      static
      symbol_type
      make_UPPER (const std::string& v)
      {
        return symbol_type (token::UPPER, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_STRIP (std::string v)
      {
        return symbol_type (token::STRIP, std::move (v));
      }
#else
      static
      symbol_type
      make_STRIP (const std::string& v)
      {
        return symbol_type (token::STRIP, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_REPLACE (std::string v)
      {
        return symbol_type (token::REPLACE, std::move (v));
      }
#else
      static
      symbol_type
      make_REPLACE (const std::string& v)
      {
        return symbol_type (token::REPLACE, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_SPACIFY (std::string v)
      {
        return symbol_type (token::SPACIFY, std::move (v));
      }
#else
      static
      symbol_type
      make_SPACIFY (const std::string& v)
      {
        return symbol_type (token::SPACIFY, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_STRING_FORMAT (std::string v)
      {
        return symbol_type (token::STRING_FORMAT, std::move (v));
      }
#else
      static
      symbol_type
      make_STRING_FORMAT (const std::string& v)
      {
        return symbol_type (token::STRING_FORMAT, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_STRIP_TAGS (std::string v)
      {
        return symbol_type (token::STRIP_TAGS, std::move (v));
      }
#else
      static
      symbol_type
      make_STRIP_TAGS (const std::string& v)
      {
        return symbol_type (token::STRIP_TAGS, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_TRUNCATE (std::string v)
      {
        return symbol_type (token::TRUNCATE, std::move (v));
      }
#else
      static
      symbol_type
      make_TRUNCATE (const std::string& v)
      {
        return symbol_type (token::TRUNCATE, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_WORDWARP (std::string v)
      {
        return symbol_type (token::WORDWARP, std::move (v));
      }
#else
      static
      symbol_type
      make_WORDWARP (const std::string& v)
      {
        return symbol_type (token::WORDWARP, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_VAR_ATTRIB (std::string v)
      {
        return symbol_type (token::VAR_ATTRIB, std::move (v));
      }
#else
      static
      symbol_type
      make_VAR_ATTRIB (const std::string& v)
      {
        return symbol_type (token::VAR_ATTRIB, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_VALUE_ATTRIB (std::string v)
      {
        return symbol_type (token::VALUE_ATTRIB, std::move (v));
      }
#else
      static
      symbol_type
      make_VALUE_ATTRIB (const std::string& v)
      {
        return symbol_type (token::VALUE_ATTRIB, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_FILE_ATTRIB (std::string v)
      {
        return symbol_type (token::FILE_ATTRIB, std::move (v));
      }
#else
      static
      symbol_type
      make_FILE_ATTRIB (const std::string& v)
      {
        return symbol_type (token::FILE_ATTRIB, v);
      }
#endif
#if 201103L <= YY_CPLUSPLUS
      static
      symbol_type
      make_FILE_NAME (std::string v)
      {
        return symbol_type (token::FILE_NAME, std::move (v));
      }
#else
      static
      symbol_type
      make_FILE_NAME (const std::string& v)
      {
        return symbol_type (token::FILE_NAME, v);
      }
#endif


  private:
#if YY_CPLUSPLUS < 201103L
    /// Non copyable.
    parser (const parser&);
    /// Non copyable.
    parser& operator= (const parser&);
#endif


    /// Stored state numbers (used for stacks).
    typedef signed char state_type;

    /// Compute post-reduction state.
    /// \param yystate   the current state
    /// \param yysym     the nonterminal to push on the stack
    static state_type yy_lr_goto_state_ (state_type yystate, int yysym);

    /// Whether the given \c yypact_ value indicates a defaulted state.
    /// \param yyvalue   the value to check
    static bool yy_pact_value_is_default_ (int yyvalue) YY_NOEXCEPT;

    /// Whether the given \c yytable_ value indicates a syntax error.
    /// \param yyvalue   the value to check
    static bool yy_table_value_is_error_ (int yyvalue) YY_NOEXCEPT;

    static const signed char yypact_ninf_;
    static const signed char yytable_ninf_;

    /// Convert a scanner token kind \a t to a symbol kind.
    /// In theory \a t should be a token_kind_type, but character literals
    /// are valid, yet not members of the token_kind_type enum.
    static symbol_kind_type yytranslate_ (int t) YY_NOEXCEPT;

#if YYDEBUG || 0
    /// For a symbol, its name in clear.
    static const char* const yytname_[];
#endif // #if YYDEBUG || 0


    // Tables.
    // YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
    // STATE-NUM.
    static const signed char yypact_[];

    // YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
    // Performed when YYTABLE does not specify something else to do.  Zero
    // means the default is an error.
    static const signed char yydefact_[];

    // YYPGOTO[NTERM-NUM].
    static const signed char yypgoto_[];

    // YYDEFGOTO[NTERM-NUM].
    static const signed char yydefgoto_[];

    // YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
    // positive, shift that token.  If negative, reduce the rule whose
    // number is the opposite.  If YYTABLE_NINF, syntax error.
    static const signed char yytable_[];

    static const signed char yycheck_[];

    // YYSTOS[STATE-NUM] -- The symbol kind of the accessing symbol of
    // state STATE-NUM.
    static const signed char yystos_[];

    // YYR1[RULE-NUM] -- Symbol kind of the left-hand side of rule RULE-NUM.
    static const signed char yyr1_[];

    // YYR2[RULE-NUM] -- Number of symbols on the right-hand side of rule RULE-NUM.
    static const signed char yyr2_[];


#if YYDEBUG
    // YYRLINE[YYN] -- Source line where rule number YYN was defined.
    static const short yyrline_[];
    /// Report on the debug stream that the rule \a r is going to be reduced.
    virtual void yy_reduce_print_ (int r) const;
    /// Print the state stack on the debug stream.
    virtual void yy_stack_print_ () const;

    /// Debugging level.
    int yydebug_;
    /// Debug stream.
    std::ostream* yycdebug_;

    /// \brief Display a symbol kind, value and location.
    /// \param yyo    The output stream.
    /// \param yysym  The symbol.
    template <typename Base>
    void yy_print_ (std::ostream& yyo, const basic_symbol<Base>& yysym) const;
#endif

    /// \brief Reclaim the memory associated to a symbol.
    /// \param yymsg     Why this token is reclaimed.
    ///                  If null, print nothing.
    /// \param yysym     The symbol.
    template <typename Base>
    void yy_destroy_ (const char* yymsg, basic_symbol<Base>& yysym) const;

  private:
    /// Type access provider for state based symbols.
    struct by_state
    {
      /// Default constructor.
      by_state () YY_NOEXCEPT;

      /// The symbol kind as needed by the constructor.
      typedef state_type kind_type;

      /// Constructor.
      by_state (kind_type s) YY_NOEXCEPT;

      /// Copy constructor.
      by_state (const by_state& that) YY_NOEXCEPT;

      /// Record that this symbol is empty.
      void clear () YY_NOEXCEPT;

      /// Steal the symbol kind from \a that.
      void move (by_state& that);

      /// The symbol kind (corresponding to \a state).
      /// \a symbol_kind::S_YYEMPTY when empty.
      symbol_kind_type kind () const YY_NOEXCEPT;

      /// The state number used to denote an empty symbol.
      /// We use the initial state, as it does not have a value.
      enum { empty_state = 0 };

      /// The state.
      /// \a empty when empty.
      state_type state;
    };

    /// "Internal" symbol: element of the stack.
    struct stack_symbol_type : basic_symbol<by_state>
    {
      /// Superclass.
      typedef basic_symbol<by_state> super_type;
      /// Construct an empty symbol.
      stack_symbol_type ();
      /// Move or copy construction.
      stack_symbol_type (YY_RVREF (stack_symbol_type) that);
      /// Steal the contents from \a sym to build this.
      stack_symbol_type (state_type s, YY_MOVE_REF (symbol_type) sym);
#if YY_CPLUSPLUS < 201103L
      /// Assignment, needed by push_back by some old implementations.
      /// Moves the contents of that.
      stack_symbol_type& operator= (stack_symbol_type& that);

      /// Assignment, needed by push_back by other implementations.
      /// Needed by some other old implementations.
      stack_symbol_type& operator= (const stack_symbol_type& that);
#endif
    };

    /// A stack with random access from its top.
    template <typename T, typename S = std::vector<T> >
    class stack
    {
    public:
      // Hide our reversed order.
      typedef typename S::iterator iterator;
      typedef typename S::const_iterator const_iterator;
      typedef typename S::size_type size_type;
      typedef typename std::ptrdiff_t index_type;

      stack (size_type n = 200) YY_NOEXCEPT
        : seq_ (n)
      {}

#if 201103L <= YY_CPLUSPLUS
      /// Non copyable.
      stack (const stack&) = delete;
      /// Non copyable.
      stack& operator= (const stack&) = delete;
#endif

      /// Random access.
      ///
      /// Index 0 returns the topmost element.
      const T&
      operator[] (index_type i) const
      {
        return seq_[size_type (size () - 1 - i)];
      }

      /// Random access.
      ///
      /// Index 0 returns the topmost element.
      T&
      operator[] (index_type i)
      {
        return seq_[size_type (size () - 1 - i)];
      }

      /// Steal the contents of \a t.
      ///
      /// Close to move-semantics.
      void
      push (YY_MOVE_REF (T) t)
      {
        seq_.push_back (T ());
        operator[] (0).move (t);
      }

      /// Pop elements from the stack.
      void
      pop (std::ptrdiff_t n = 1) YY_NOEXCEPT
      {
        for (; 0 < n; --n)
          seq_.pop_back ();
      }

      /// Pop all elements from the stack.
      void
      clear () YY_NOEXCEPT
      {
        seq_.clear ();
      }

      /// Number of elements on the stack.
      index_type
      size () const YY_NOEXCEPT
      {
        return index_type (seq_.size ());
      }

      /// Iterator on top of the stack (going downwards).
      const_iterator
      begin () const YY_NOEXCEPT
      {
        return seq_.begin ();
      }

      /// Bottom of the stack.
      const_iterator
      end () const YY_NOEXCEPT
      {
        return seq_.end ();
      }

      /// Present a slice of the top of a stack.
      class slice
      {
      public:
        slice (const stack& stack, index_type range) YY_NOEXCEPT
          : stack_ (stack)
          , range_ (range)
        {}

        const T&
        operator[] (index_type i) const
        {
          return stack_[range_ - i];
        }

      private:
        const stack& stack_;
        index_type range_;
      };

    private:
#if YY_CPLUSPLUS < 201103L
      /// Non copyable.
      stack (const stack&);
      /// Non copyable.
      stack& operator= (const stack&);
#endif
      /// The wrapped container.
      S seq_;
    };


    /// Stack type.
    typedef stack<stack_symbol_type> stack_type;

    /// The stack.
    stack_type yystack_;

    /// Push a new state on the stack.
    /// \param m    a debug message to display
    ///             if null, no trace is output.
    /// \param sym  the symbol
    /// \warning the contents of \a s.value is stolen.
    void yypush_ (const char* m, YY_MOVE_REF (stack_symbol_type) sym);

    /// Push a new look ahead token on the state on the stack.
    /// \param m    a debug message to display
    ///             if null, no trace is output.
    /// \param s    the state
    /// \param sym  the symbol (for its value and location).
    /// \warning the contents of \a sym.value is stolen.
    void yypush_ (const char* m, state_type s, YY_MOVE_REF (symbol_type) sym);

    /// Pop \a n symbols from the stack.
    void yypop_ (int n = 1) YY_NOEXCEPT;

    /// Constants.
    enum
    {
      yylast_ = 92,     ///< Last index in yytable_.
      yynnts_ = 18,  ///< Number of nonterminal symbols.
      yyfinal_ = 20 ///< Termination state number.
    };



  };

  parser::symbol_kind_type
  parser::yytranslate_ (int t) YY_NOEXCEPT
  {
    // YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to
    // TOKEN-NUM as returned by yylex.
    static
    const signed char
    translate_table[] =
    {
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49
    };
    // Last valid token kind.
    const int code_max = 304;

    if (t <= 0)
      return symbol_kind::S_YYEOF;
    else if (t <= code_max)
      return static_cast <symbol_kind_type> (translate_table[t]);
    else
      return symbol_kind::S_YYUNDEF;
  }

  // basic_symbol.
  template <typename Base>
  parser::basic_symbol<Base>::basic_symbol (const basic_symbol& that)
    : Base (that)
    , value ()
  {
    switch (this->kind ())
    {
      case symbol_kind::S_NUMBER: // NUMBER
        value.copy< int > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_attrib: // attrib
        value.copy< std::pair< std::string, std::string > > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_TEXT: // TEXT
      case symbol_kind::S_DOLLAR_SIGN: // DOLLAR_SIGN
      case symbol_kind::S_DOT: // DOT
      case symbol_kind::S_INDIRECT_MEMBER: // INDIRECT_MEMBER
      case symbol_kind::S_COMMA: // COMMA
      case symbol_kind::S_EQUAL: // EQUAL
      case symbol_kind::S_VBAR: // VBAR
      case symbol_kind::S_COLON: // COLON
      case symbol_kind::S_STRING_LITERAL: // STRING_LITERAL
      case symbol_kind::S_NUMERIC_LITERAL: // NUMERIC_LITERAL
      case symbol_kind::S_ID: // ID
      case symbol_kind::S_SYMBOL: // SYMBOL
      case symbol_kind::S_CONST_SYMBOL: // CONST_SYMBOL
      case symbol_kind::S_LBRACE: // LBRACE
      case symbol_kind::S_RBRACE: // RBRACE
      case symbol_kind::S_LBRACKET: // LBRACKET
      case symbol_kind::S_RBRACKET: // RBRACKET
      case symbol_kind::S_LPAREN: // LPAREN
      case symbol_kind::S_RPAREN: // RPAREN
      case symbol_kind::S_CONFIG_LOAD: // CONFIG_LOAD
      case symbol_kind::S_INCLUDE: // INCLUDE
      case symbol_kind::S_REQUIRE: // REQUIRE
      case symbol_kind::S_INSERT: // INSERT
      case symbol_kind::S_ASSIGN: // ASSIGN
      case symbol_kind::S_CAPITALIZE: // CAPITALIZE
      case symbol_kind::S_CAT: // CAT
      case symbol_kind::S_COUNT_CHARACTERS: // COUNT_CHARACTERS
      case symbol_kind::S_COUNT_SENTENCES: // COUNT_SENTENCES
      case symbol_kind::S_COUNT_PARAGRAPHS: // COUNT_PARAGRAPHS
      case symbol_kind::S_DATE_FORMAT: // DATE_FORMAT
      case symbol_kind::S_ESCAPE: // ESCAPE
      case symbol_kind::S_INDENT: // INDENT
      case symbol_kind::S_LOWER: // LOWER
      case symbol_kind::S_UPPER: // UPPER
      case symbol_kind::S_STRIP: // STRIP
      case symbol_kind::S_REPLACE: // REPLACE
      case symbol_kind::S_SPACIFY: // SPACIFY
      case symbol_kind::S_STRING_FORMAT: // STRING_FORMAT
      case symbol_kind::S_STRIP_TAGS: // STRIP_TAGS
      case symbol_kind::S_TRUNCATE: // TRUNCATE
      case symbol_kind::S_WORDWARP: // WORDWARP
      case symbol_kind::S_VAR_ATTRIB: // VAR_ATTRIB
      case symbol_kind::S_VALUE_ATTRIB: // VALUE_ATTRIB
      case symbol_kind::S_FILE_ATTRIB: // FILE_ATTRIB
      case symbol_kind::S_FILE_NAME: // FILE_NAME
      case symbol_kind::S_colon_sep_params: // colon_sep_params
      case symbol_kind::S_colon_sep_param: // colon_sep_param
      case symbol_kind::S_qualafied_id: // qualafied_id
      case symbol_kind::S_sub_proc: // sub_proc
      case symbol_kind::S_array: // array
      case symbol_kind::S_symbol: // symbol
      case symbol_kind::S_modifier: // modifier
      case symbol_kind::S_built_in: // built_in
      case symbol_kind::S_attributes: // attributes
        value.copy< std::string > (YY_MOVE (that.value));
        break;

      default:
        break;
    }

  }




  template <typename Base>
  parser::symbol_kind_type
  parser::basic_symbol<Base>::type_get () const YY_NOEXCEPT
  {
    return this->kind ();
  }


  template <typename Base>
  bool
  parser::basic_symbol<Base>::empty () const YY_NOEXCEPT
  {
    return this->kind () == symbol_kind::S_YYEMPTY;
  }

  template <typename Base>
  void
  parser::basic_symbol<Base>::move (basic_symbol& s)
  {
    super_type::move (s);
    switch (this->kind ())
    {
      case symbol_kind::S_NUMBER: // NUMBER
        value.move< int > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_attrib: // attrib
        value.move< std::pair< std::string, std::string > > (YY_MOVE (s.value));
        break;

      case symbol_kind::S_TEXT: // TEXT
      case symbol_kind::S_DOLLAR_SIGN: // DOLLAR_SIGN
      case symbol_kind::S_DOT: // DOT
      case symbol_kind::S_INDIRECT_MEMBER: // INDIRECT_MEMBER
      case symbol_kind::S_COMMA: // COMMA
      case symbol_kind::S_EQUAL: // EQUAL
      case symbol_kind::S_VBAR: // VBAR
      case symbol_kind::S_COLON: // COLON
      case symbol_kind::S_STRING_LITERAL: // STRING_LITERAL
      case symbol_kind::S_NUMERIC_LITERAL: // NUMERIC_LITERAL
      case symbol_kind::S_ID: // ID
      case symbol_kind::S_SYMBOL: // SYMBOL
      case symbol_kind::S_CONST_SYMBOL: // CONST_SYMBOL
      case symbol_kind::S_LBRACE: // LBRACE
      case symbol_kind::S_RBRACE: // RBRACE
      case symbol_kind::S_LBRACKET: // LBRACKET
      case symbol_kind::S_RBRACKET: // RBRACKET
      case symbol_kind::S_LPAREN: // LPAREN
      case symbol_kind::S_RPAREN: // RPAREN
      case symbol_kind::S_CONFIG_LOAD: // CONFIG_LOAD
      case symbol_kind::S_INCLUDE: // INCLUDE
      case symbol_kind::S_REQUIRE: // REQUIRE
      case symbol_kind::S_INSERT: // INSERT
      case symbol_kind::S_ASSIGN: // ASSIGN
      case symbol_kind::S_CAPITALIZE: // CAPITALIZE
      case symbol_kind::S_CAT: // CAT
      case symbol_kind::S_COUNT_CHARACTERS: // COUNT_CHARACTERS
      case symbol_kind::S_COUNT_SENTENCES: // COUNT_SENTENCES
      case symbol_kind::S_COUNT_PARAGRAPHS: // COUNT_PARAGRAPHS
      case symbol_kind::S_DATE_FORMAT: // DATE_FORMAT
      case symbol_kind::S_ESCAPE: // ESCAPE
      case symbol_kind::S_INDENT: // INDENT
      case symbol_kind::S_LOWER: // LOWER
      case symbol_kind::S_UPPER: // UPPER
      case symbol_kind::S_STRIP: // STRIP
      case symbol_kind::S_REPLACE: // REPLACE
      case symbol_kind::S_SPACIFY: // SPACIFY
      case symbol_kind::S_STRING_FORMAT: // STRING_FORMAT
      case symbol_kind::S_STRIP_TAGS: // STRIP_TAGS
      case symbol_kind::S_TRUNCATE: // TRUNCATE
      case symbol_kind::S_WORDWARP: // WORDWARP
      case symbol_kind::S_VAR_ATTRIB: // VAR_ATTRIB
      case symbol_kind::S_VALUE_ATTRIB: // VALUE_ATTRIB
      case symbol_kind::S_FILE_ATTRIB: // FILE_ATTRIB
      case symbol_kind::S_FILE_NAME: // FILE_NAME
      case symbol_kind::S_colon_sep_params: // colon_sep_params
      case symbol_kind::S_colon_sep_param: // colon_sep_param
      case symbol_kind::S_qualafied_id: // qualafied_id
      case symbol_kind::S_sub_proc: // sub_proc
      case symbol_kind::S_array: // array
      case symbol_kind::S_symbol: // symbol
      case symbol_kind::S_modifier: // modifier
      case symbol_kind::S_built_in: // built_in
      case symbol_kind::S_attributes: // attributes
        value.move< std::string > (YY_MOVE (s.value));
        break;

      default:
        break;
    }

  }

  // by_kind.
  parser::by_kind::by_kind () YY_NOEXCEPT
    : kind_ (symbol_kind::S_YYEMPTY)
  {}

#if 201103L <= YY_CPLUSPLUS
  parser::by_kind::by_kind (by_kind&& that) YY_NOEXCEPT
    : kind_ (that.kind_)
  {
    that.clear ();
  }
#endif

  parser::by_kind::by_kind (const by_kind& that) YY_NOEXCEPT
    : kind_ (that.kind_)
  {}

  parser::by_kind::by_kind (token_kind_type t) YY_NOEXCEPT
    : kind_ (yytranslate_ (t))
  {}



  void
  parser::by_kind::clear () YY_NOEXCEPT
  {
    kind_ = symbol_kind::S_YYEMPTY;
  }

  void
  parser::by_kind::move (by_kind& that)
  {
    kind_ = that.kind_;
    that.clear ();
  }

  parser::symbol_kind_type
  parser::by_kind::kind () const YY_NOEXCEPT
  {
    return kind_;
  }


  parser::symbol_kind_type
  parser::by_kind::type_get () const YY_NOEXCEPT
  {
    return this->kind ();
  }


} // yy
#line 2357 "parser2.cc"






// Unqualified %code blocks.
#line 24 "parser2.yy"

     #include <iostream>
    #include <string>
    #include <iomanip>
    #include <list>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "bash_color.h"
    #include "symtab.h"

    using std::string;
    using std::cout;
    using std::endl;
    using std::pair;

    #define VERBOSE

    typedef std::pair< std::string, std::string > attribute;


    // print a list of strings
    auto operator<<(std::ostream& o, const std::vector<std::string>& ss) -> std::ostream&
    {
        o << '{';
        const char *sep = "";
        for(const auto& s: ss)
        {
            o << sep << s;
            sep = ", ";
        }
        return o << '}';
    }
#line 61 "parser2.yy"

    int yylex(void);
    int yyerror(char * s);
    char* STRDUP(char* s);
    /* string literal buffer */
    char buf[100];
    char *s;

    typedef struct nvalue
    {
        char* name;
        char* value;
        struct nvalue* next;
    } nvalue;

    static nvalue* pnv_head = 0;
    nvalue* alloc_nvalue(char* name, char* value);
    void free_nvalue(nvalue* nv);
    void free_all_nvalues();
    typedef std::pair< std::string, std::string > attribute;

    namespace yy
    {
        // return the next token
        auto yylex() -> parser::symbol_type
        {
            static int count = 0;
            switch(int stage = count++)
            {
            case 0:
                return parser::make_TEXT("I have three numbers for you.");
            case 1: case 2: case 3:
                return parser::make_NUMBER(stage);
            case 4:
                return parser::make_TEXT("And that's all!");
            default:
                return parser::make_YYEOF();
            }
        }
    }

#line 2441 "parser2.cc"


#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> // FIXME: INFRINGES ON USER NAME SPACE.
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

#ifndef N_
# define N_(Msgid) Msgid
#endif


// Whether we are compiled with exception support.
#ifndef YY_EXCEPTIONS
# if defined __GNUC__ && !defined __EXCEPTIONS
#  define YY_EXCEPTIONS 0
# else
#  define YY_EXCEPTIONS 1
# endif
#endif



// Enable debugging if requested.
#if YYDEBUG

// A pseudo ostream that takes yydebug_ into account.
# define YYCDEBUG if (yydebug_) (*yycdebug_)

# define YY_SYMBOL_PRINT(Title, Symbol)         \
  do {                                          \
    if (yydebug_)                               \
    {                                           \
      *yycdebug_ << Title << ' ';               \
      yy_print_ (*yycdebug_, Symbol);           \
      *yycdebug_ << '\n';                       \
    }                                           \
  } while (false)

# define YY_REDUCE_PRINT(Rule)          \
  do {                                  \
    if (yydebug_)                       \
      yy_reduce_print_ (Rule);          \
  } while (false)

# define YY_STACK_PRINT()               \
  do {                                  \
    if (yydebug_)                       \
      yy_stack_print_ ();                \
  } while (false)

#else // !YYDEBUG

# define YYCDEBUG if (false) std::cerr
# define YY_SYMBOL_PRINT(Title, Symbol)  YY_USE (Symbol)
# define YY_REDUCE_PRINT(Rule)           static_cast<void> (0)
# define YY_STACK_PRINT()                static_cast<void> (0)

#endif // !YYDEBUG

#define yyerrok         (yyerrstatus_ = 0)
#define yyclearin       (yyla.clear ())

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab
#define YYRECOVERING()  (!!yyerrstatus_)

namespace yy {
#line 2518 "parser2.cc"

  /// Build a parser object.
  parser::parser ()
#if YYDEBUG
    : yydebug_ (false),
      yycdebug_ (&std::cerr)
#else

#endif
  {}

  parser::~parser ()
  {}

  parser::syntax_error::~syntax_error () YY_NOEXCEPT YY_NOTHROW
  {}

  /*---------.
  | symbol.  |
  `---------*/



  // by_state.
  parser::by_state::by_state () YY_NOEXCEPT
    : state (empty_state)
  {}

  parser::by_state::by_state (const by_state& that) YY_NOEXCEPT
    : state (that.state)
  {}

  void
  parser::by_state::clear () YY_NOEXCEPT
  {
    state = empty_state;
  }

  void
  parser::by_state::move (by_state& that)
  {
    state = that.state;
    that.clear ();
  }

  parser::by_state::by_state (state_type s) YY_NOEXCEPT
    : state (s)
  {}

  parser::symbol_kind_type
  parser::by_state::kind () const YY_NOEXCEPT
  {
    if (state == empty_state)
      return symbol_kind::S_YYEMPTY;
    else
      return YY_CAST (symbol_kind_type, yystos_[+state]);
  }

  parser::stack_symbol_type::stack_symbol_type ()
  {}

  parser::stack_symbol_type::stack_symbol_type (YY_RVREF (stack_symbol_type) that)
    : super_type (YY_MOVE (that.state))
  {
    switch (that.kind ())
    {
      case symbol_kind::S_NUMBER: // NUMBER
        value.YY_MOVE_OR_COPY< int > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_attrib: // attrib
        value.YY_MOVE_OR_COPY< std::pair< std::string, std::string > > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_TEXT: // TEXT
      case symbol_kind::S_DOLLAR_SIGN: // DOLLAR_SIGN
      case symbol_kind::S_DOT: // DOT
      case symbol_kind::S_INDIRECT_MEMBER: // INDIRECT_MEMBER
      case symbol_kind::S_COMMA: // COMMA
      case symbol_kind::S_EQUAL: // EQUAL
      case symbol_kind::S_VBAR: // VBAR
      case symbol_kind::S_COLON: // COLON
      case symbol_kind::S_STRING_LITERAL: // STRING_LITERAL
      case symbol_kind::S_NUMERIC_LITERAL: // NUMERIC_LITERAL
      case symbol_kind::S_ID: // ID
      case symbol_kind::S_SYMBOL: // SYMBOL
      case symbol_kind::S_CONST_SYMBOL: // CONST_SYMBOL
      case symbol_kind::S_LBRACE: // LBRACE
      case symbol_kind::S_RBRACE: // RBRACE
      case symbol_kind::S_LBRACKET: // LBRACKET
      case symbol_kind::S_RBRACKET: // RBRACKET
      case symbol_kind::S_LPAREN: // LPAREN
      case symbol_kind::S_RPAREN: // RPAREN
      case symbol_kind::S_CONFIG_LOAD: // CONFIG_LOAD
      case symbol_kind::S_INCLUDE: // INCLUDE
      case symbol_kind::S_REQUIRE: // REQUIRE
      case symbol_kind::S_INSERT: // INSERT
      case symbol_kind::S_ASSIGN: // ASSIGN
      case symbol_kind::S_CAPITALIZE: // CAPITALIZE
      case symbol_kind::S_CAT: // CAT
      case symbol_kind::S_COUNT_CHARACTERS: // COUNT_CHARACTERS
      case symbol_kind::S_COUNT_SENTENCES: // COUNT_SENTENCES
      case symbol_kind::S_COUNT_PARAGRAPHS: // COUNT_PARAGRAPHS
      case symbol_kind::S_DATE_FORMAT: // DATE_FORMAT
      case symbol_kind::S_ESCAPE: // ESCAPE
      case symbol_kind::S_INDENT: // INDENT
      case symbol_kind::S_LOWER: // LOWER
      case symbol_kind::S_UPPER: // UPPER
      case symbol_kind::S_STRIP: // STRIP
      case symbol_kind::S_REPLACE: // REPLACE
      case symbol_kind::S_SPACIFY: // SPACIFY
      case symbol_kind::S_STRING_FORMAT: // STRING_FORMAT
      case symbol_kind::S_STRIP_TAGS: // STRIP_TAGS
      case symbol_kind::S_TRUNCATE: // TRUNCATE
      case symbol_kind::S_WORDWARP: // WORDWARP
      case symbol_kind::S_VAR_ATTRIB: // VAR_ATTRIB
      case symbol_kind::S_VALUE_ATTRIB: // VALUE_ATTRIB
      case symbol_kind::S_FILE_ATTRIB: // FILE_ATTRIB
      case symbol_kind::S_FILE_NAME: // FILE_NAME
      case symbol_kind::S_colon_sep_params: // colon_sep_params
      case symbol_kind::S_colon_sep_param: // colon_sep_param
      case symbol_kind::S_qualafied_id: // qualafied_id
      case symbol_kind::S_sub_proc: // sub_proc
      case symbol_kind::S_array: // array
      case symbol_kind::S_symbol: // symbol
      case symbol_kind::S_modifier: // modifier
      case symbol_kind::S_built_in: // built_in
      case symbol_kind::S_attributes: // attributes
        value.YY_MOVE_OR_COPY< std::string > (YY_MOVE (that.value));
        break;

      default:
        break;
    }

#if 201103L <= YY_CPLUSPLUS
    // that is emptied.
    that.state = empty_state;
#endif
  }

  parser::stack_symbol_type::stack_symbol_type (state_type s, YY_MOVE_REF (symbol_type) that)
    : super_type (s)
  {
    switch (that.kind ())
    {
      case symbol_kind::S_NUMBER: // NUMBER
        value.move< int > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_attrib: // attrib
        value.move< std::pair< std::string, std::string > > (YY_MOVE (that.value));
        break;

      case symbol_kind::S_TEXT: // TEXT
      case symbol_kind::S_DOLLAR_SIGN: // DOLLAR_SIGN
      case symbol_kind::S_DOT: // DOT
      case symbol_kind::S_INDIRECT_MEMBER: // INDIRECT_MEMBER
      case symbol_kind::S_COMMA: // COMMA
      case symbol_kind::S_EQUAL: // EQUAL
      case symbol_kind::S_VBAR: // VBAR
      case symbol_kind::S_COLON: // COLON
      case symbol_kind::S_STRING_LITERAL: // STRING_LITERAL
      case symbol_kind::S_NUMERIC_LITERAL: // NUMERIC_LITERAL
      case symbol_kind::S_ID: // ID
      case symbol_kind::S_SYMBOL: // SYMBOL
      case symbol_kind::S_CONST_SYMBOL: // CONST_SYMBOL
      case symbol_kind::S_LBRACE: // LBRACE
      case symbol_kind::S_RBRACE: // RBRACE
      case symbol_kind::S_LBRACKET: // LBRACKET
      case symbol_kind::S_RBRACKET: // RBRACKET
      case symbol_kind::S_LPAREN: // LPAREN
      case symbol_kind::S_RPAREN: // RPAREN
      case symbol_kind::S_CONFIG_LOAD: // CONFIG_LOAD
      case symbol_kind::S_INCLUDE: // INCLUDE
      case symbol_kind::S_REQUIRE: // REQUIRE
      case symbol_kind::S_INSERT: // INSERT
      case symbol_kind::S_ASSIGN: // ASSIGN
      case symbol_kind::S_CAPITALIZE: // CAPITALIZE
      case symbol_kind::S_CAT: // CAT
      case symbol_kind::S_COUNT_CHARACTERS: // COUNT_CHARACTERS
      case symbol_kind::S_COUNT_SENTENCES: // COUNT_SENTENCES
      case symbol_kind::S_COUNT_PARAGRAPHS: // COUNT_PARAGRAPHS
      case symbol_kind::S_DATE_FORMAT: // DATE_FORMAT
      case symbol_kind::S_ESCAPE: // ESCAPE
      case symbol_kind::S_INDENT: // INDENT
      case symbol_kind::S_LOWER: // LOWER
      case symbol_kind::S_UPPER: // UPPER
      case symbol_kind::S_STRIP: // STRIP
      case symbol_kind::S_REPLACE: // REPLACE
      case symbol_kind::S_SPACIFY: // SPACIFY
      case symbol_kind::S_STRING_FORMAT: // STRING_FORMAT
      case symbol_kind::S_STRIP_TAGS: // STRIP_TAGS
      case symbol_kind::S_TRUNCATE: // TRUNCATE
      case symbol_kind::S_WORDWARP: // WORDWARP
      case symbol_kind::S_VAR_ATTRIB: // VAR_ATTRIB
      case symbol_kind::S_VALUE_ATTRIB: // VALUE_ATTRIB
      case symbol_kind::S_FILE_ATTRIB: // FILE_ATTRIB
      case symbol_kind::S_FILE_NAME: // FILE_NAME
      case symbol_kind::S_colon_sep_params: // colon_sep_params
      case symbol_kind::S_colon_sep_param: // colon_sep_param
      case symbol_kind::S_qualafied_id: // qualafied_id
      case symbol_kind::S_sub_proc: // sub_proc
      case symbol_kind::S_array: // array
      case symbol_kind::S_symbol: // symbol
      case symbol_kind::S_modifier: // modifier
      case symbol_kind::S_built_in: // built_in
      case symbol_kind::S_attributes: // attributes
        value.move< std::string > (YY_MOVE (that.value));
        break;

      default:
        break;
    }

    // that is emptied.
    that.kind_ = symbol_kind::S_YYEMPTY;
  }

#if YY_CPLUSPLUS < 201103L
  parser::stack_symbol_type&
  parser::stack_symbol_type::operator= (const stack_symbol_type& that)
  {
    state = that.state;
    switch (that.kind ())
    {
      case symbol_kind::S_NUMBER: // NUMBER
        value.copy< int > (that.value);
        break;

      case symbol_kind::S_attrib: // attrib
        value.copy< std::pair< std::string, std::string > > (that.value);
        break;

      case symbol_kind::S_TEXT: // TEXT
      case symbol_kind::S_DOLLAR_SIGN: // DOLLAR_SIGN
      case symbol_kind::S_DOT: // DOT
      case symbol_kind::S_INDIRECT_MEMBER: // INDIRECT_MEMBER
      case symbol_kind::S_COMMA: // COMMA
      case symbol_kind::S_EQUAL: // EQUAL
      case symbol_kind::S_VBAR: // VBAR
      case symbol_kind::S_COLON: // COLON
      case symbol_kind::S_STRING_LITERAL: // STRING_LITERAL
      case symbol_kind::S_NUMERIC_LITERAL: // NUMERIC_LITERAL
      case symbol_kind::S_ID: // ID
      case symbol_kind::S_SYMBOL: // SYMBOL
      case symbol_kind::S_CONST_SYMBOL: // CONST_SYMBOL
      case symbol_kind::S_LBRACE: // LBRACE
      case symbol_kind::S_RBRACE: // RBRACE
      case symbol_kind::S_LBRACKET: // LBRACKET
      case symbol_kind::S_RBRACKET: // RBRACKET
      case symbol_kind::S_LPAREN: // LPAREN
      case symbol_kind::S_RPAREN: // RPAREN
      case symbol_kind::S_CONFIG_LOAD: // CONFIG_LOAD
      case symbol_kind::S_INCLUDE: // INCLUDE
      case symbol_kind::S_REQUIRE: // REQUIRE
      case symbol_kind::S_INSERT: // INSERT
      case symbol_kind::S_ASSIGN: // ASSIGN
      case symbol_kind::S_CAPITALIZE: // CAPITALIZE
      case symbol_kind::S_CAT: // CAT
      case symbol_kind::S_COUNT_CHARACTERS: // COUNT_CHARACTERS
      case symbol_kind::S_COUNT_SENTENCES: // COUNT_SENTENCES
      case symbol_kind::S_COUNT_PARAGRAPHS: // COUNT_PARAGRAPHS
      case symbol_kind::S_DATE_FORMAT: // DATE_FORMAT
      case symbol_kind::S_ESCAPE: // ESCAPE
      case symbol_kind::S_INDENT: // INDENT
      case symbol_kind::S_LOWER: // LOWER
      case symbol_kind::S_UPPER: // UPPER
      case symbol_kind::S_STRIP: // STRIP
      case symbol_kind::S_REPLACE: // REPLACE
      case symbol_kind::S_SPACIFY: // SPACIFY
      case symbol_kind::S_STRING_FORMAT: // STRING_FORMAT
      case symbol_kind::S_STRIP_TAGS: // STRIP_TAGS
      case symbol_kind::S_TRUNCATE: // TRUNCATE
      case symbol_kind::S_WORDWARP: // WORDWARP
      case symbol_kind::S_VAR_ATTRIB: // VAR_ATTRIB
      case symbol_kind::S_VALUE_ATTRIB: // VALUE_ATTRIB
      case symbol_kind::S_FILE_ATTRIB: // FILE_ATTRIB
      case symbol_kind::S_FILE_NAME: // FILE_NAME
      case symbol_kind::S_colon_sep_params: // colon_sep_params
      case symbol_kind::S_colon_sep_param: // colon_sep_param
      case symbol_kind::S_qualafied_id: // qualafied_id
      case symbol_kind::S_sub_proc: // sub_proc
      case symbol_kind::S_array: // array
      case symbol_kind::S_symbol: // symbol
      case symbol_kind::S_modifier: // modifier
      case symbol_kind::S_built_in: // built_in
      case symbol_kind::S_attributes: // attributes
        value.copy< std::string > (that.value);
        break;

      default:
        break;
    }

    return *this;
  }

  parser::stack_symbol_type&
  parser::stack_symbol_type::operator= (stack_symbol_type& that)
  {
    state = that.state;
    switch (that.kind ())
    {
      case symbol_kind::S_NUMBER: // NUMBER
        value.move< int > (that.value);
        break;

      case symbol_kind::S_attrib: // attrib
        value.move< std::pair< std::string, std::string > > (that.value);
        break;

      case symbol_kind::S_TEXT: // TEXT
      case symbol_kind::S_DOLLAR_SIGN: // DOLLAR_SIGN
      case symbol_kind::S_DOT: // DOT
      case symbol_kind::S_INDIRECT_MEMBER: // INDIRECT_MEMBER
      case symbol_kind::S_COMMA: // COMMA
      case symbol_kind::S_EQUAL: // EQUAL
      case symbol_kind::S_VBAR: // VBAR
      case symbol_kind::S_COLON: // COLON
      case symbol_kind::S_STRING_LITERAL: // STRING_LITERAL
      case symbol_kind::S_NUMERIC_LITERAL: // NUMERIC_LITERAL
      case symbol_kind::S_ID: // ID
      case symbol_kind::S_SYMBOL: // SYMBOL
      case symbol_kind::S_CONST_SYMBOL: // CONST_SYMBOL
      case symbol_kind::S_LBRACE: // LBRACE
      case symbol_kind::S_RBRACE: // RBRACE
      case symbol_kind::S_LBRACKET: // LBRACKET
      case symbol_kind::S_RBRACKET: // RBRACKET
      case symbol_kind::S_LPAREN: // LPAREN
      case symbol_kind::S_RPAREN: // RPAREN
      case symbol_kind::S_CONFIG_LOAD: // CONFIG_LOAD
      case symbol_kind::S_INCLUDE: // INCLUDE
      case symbol_kind::S_REQUIRE: // REQUIRE
      case symbol_kind::S_INSERT: // INSERT
      case symbol_kind::S_ASSIGN: // ASSIGN
      case symbol_kind::S_CAPITALIZE: // CAPITALIZE
      case symbol_kind::S_CAT: // CAT
      case symbol_kind::S_COUNT_CHARACTERS: // COUNT_CHARACTERS
      case symbol_kind::S_COUNT_SENTENCES: // COUNT_SENTENCES
      case symbol_kind::S_COUNT_PARAGRAPHS: // COUNT_PARAGRAPHS
      case symbol_kind::S_DATE_FORMAT: // DATE_FORMAT
      case symbol_kind::S_ESCAPE: // ESCAPE
      case symbol_kind::S_INDENT: // INDENT
      case symbol_kind::S_LOWER: // LOWER
      case symbol_kind::S_UPPER: // UPPER
      case symbol_kind::S_STRIP: // STRIP
      case symbol_kind::S_REPLACE: // REPLACE
      case symbol_kind::S_SPACIFY: // SPACIFY
      case symbol_kind::S_STRING_FORMAT: // STRING_FORMAT
      case symbol_kind::S_STRIP_TAGS: // STRIP_TAGS
      case symbol_kind::S_TRUNCATE: // TRUNCATE
      case symbol_kind::S_WORDWARP: // WORDWARP
      case symbol_kind::S_VAR_ATTRIB: // VAR_ATTRIB
      case symbol_kind::S_VALUE_ATTRIB: // VALUE_ATTRIB
      case symbol_kind::S_FILE_ATTRIB: // FILE_ATTRIB
      case symbol_kind::S_FILE_NAME: // FILE_NAME
      case symbol_kind::S_colon_sep_params: // colon_sep_params
      case symbol_kind::S_colon_sep_param: // colon_sep_param
      case symbol_kind::S_qualafied_id: // qualafied_id
      case symbol_kind::S_sub_proc: // sub_proc
      case symbol_kind::S_array: // array
      case symbol_kind::S_symbol: // symbol
      case symbol_kind::S_modifier: // modifier
      case symbol_kind::S_built_in: // built_in
      case symbol_kind::S_attributes: // attributes
        value.move< std::string > (that.value);
        break;

      default:
        break;
    }

    // that is emptied.
    that.state = empty_state;
    return *this;
  }
#endif

  template <typename Base>
  void
  parser::yy_destroy_ (const char* yymsg, basic_symbol<Base>& yysym) const
  {
    if (yymsg)
      YY_SYMBOL_PRINT (yymsg, yysym);
  }

#if YYDEBUG
  template <typename Base>
  void
  parser::yy_print_ (std::ostream& yyo, const basic_symbol<Base>& yysym) const
  {
    std::ostream& yyoutput = yyo;
    YY_USE (yyoutput);
    if (yysym.empty ())
      yyo << "empty symbol";
    else
      {
        symbol_kind_type yykind = yysym.kind ();
        yyo << (yykind < YYNTOKENS ? "token" : "nterm")
            << ' ' << yysym.name () << " (";
        YY_USE (yykind);
        yyo << ')';
      }
  }
#endif

  void
  parser::yypush_ (const char* m, YY_MOVE_REF (stack_symbol_type) sym)
  {
    if (m)
      YY_SYMBOL_PRINT (m, sym);
    yystack_.push (YY_MOVE (sym));
  }

  void
  parser::yypush_ (const char* m, state_type s, YY_MOVE_REF (symbol_type) sym)
  {
#if 201103L <= YY_CPLUSPLUS
    yypush_ (m, stack_symbol_type (s, std::move (sym)));
#else
    stack_symbol_type ss (s, sym);
    yypush_ (m, ss);
#endif
  }

  void
  parser::yypop_ (int n) YY_NOEXCEPT
  {
    yystack_.pop (n);
  }

#if YYDEBUG
  std::ostream&
  parser::debug_stream () const
  {
    return *yycdebug_;
  }

  void
  parser::set_debug_stream (std::ostream& o)
  {
    yycdebug_ = &o;
  }


  parser::debug_level_type
  parser::debug_level () const
  {
    return yydebug_;
  }

  void
  parser::set_debug_level (debug_level_type l)
  {
    yydebug_ = l;
  }
#endif // YYDEBUG

  parser::state_type
  parser::yy_lr_goto_state_ (state_type yystate, int yysym)
  {
    int yyr = yypgoto_[yysym - YYNTOKENS] + yystate;
    if (0 <= yyr && yyr <= yylast_ && yycheck_[yyr] == yystate)
      return yytable_[yyr];
    else
      return yydefgoto_[yysym - YYNTOKENS];
  }

  bool
  parser::yy_pact_value_is_default_ (int yyvalue) YY_NOEXCEPT
  {
    return yyvalue == yypact_ninf_;
  }

  bool
  parser::yy_table_value_is_error_ (int yyvalue) YY_NOEXCEPT
  {
    return yyvalue == yytable_ninf_;
  }

  int
  parser::operator() ()
  {
    return parse ();
  }

  int
  parser::parse ()
  {
    int yyn;
    /// Length of the RHS of the rule being reduced.
    int yylen = 0;

    // Error handling.
    int yynerrs_ = 0;
    int yyerrstatus_ = 0;

    /// The lookahead symbol.
    symbol_type yyla;

    /// The return value of parse ().
    int yyresult;

#if YY_EXCEPTIONS
    try
#endif // YY_EXCEPTIONS
      {
    YYCDEBUG << "Starting parse\n";


    /* Initialize the stack.  The initial state will be set in
       yynewstate, since the latter expects the semantical and the
       location values to have been already stored, initialize these
       stacks with a primary value.  */
    yystack_.clear ();
    yypush_ (YY_NULLPTR, 0, YY_MOVE (yyla));

  /*-----------------------------------------------.
  | yynewstate -- push a new symbol on the stack.  |
  `-----------------------------------------------*/
  yynewstate:
    YYCDEBUG << "Entering state " << int (yystack_[0].state) << '\n';
    YY_STACK_PRINT ();

    // Accept?
    if (yystack_[0].state == yyfinal_)
      YYACCEPT;

    goto yybackup;


  /*-----------.
  | yybackup.  |
  `-----------*/
  yybackup:
    // Try to take a decision without lookahead.
    yyn = yypact_[+yystack_[0].state];
    if (yy_pact_value_is_default_ (yyn))
      goto yydefault;

    // Read a lookahead token.
    if (yyla.empty ())
      {
        YYCDEBUG << "Reading a token\n";
#if YY_EXCEPTIONS
        try
#endif // YY_EXCEPTIONS
          {
            symbol_type yylookahead (yylex ());
            yyla.move (yylookahead);
          }
#if YY_EXCEPTIONS
        catch (const syntax_error& yyexc)
          {
            YYCDEBUG << "Caught exception: " << yyexc.what() << '\n';
            error (yyexc);
            goto yyerrlab1;
          }
#endif // YY_EXCEPTIONS
      }
    YY_SYMBOL_PRINT ("Next token is", yyla);

    if (yyla.kind () == symbol_kind::S_YYerror)
    {
      // The scanner already issued an error message, process directly
      // to error recovery.  But do not keep the error token as
      // lookahead, it is too special and may lead us to an endless
      // loop in error recovery. */
      yyla.kind_ = symbol_kind::S_YYUNDEF;
      goto yyerrlab1;
    }

    /* If the proper action on seeing token YYLA.TYPE is to reduce or
       to detect an error, take that action.  */
    yyn += yyla.kind ();
    if (yyn < 0 || yylast_ < yyn || yycheck_[yyn] != yyla.kind ())
      {
        goto yydefault;
      }

    // Reduce or error.
    yyn = yytable_[yyn];
    if (yyn <= 0)
      {
        if (yy_table_value_is_error_ (yyn))
          goto yyerrlab;
        yyn = -yyn;
        goto yyreduce;
      }

    // Count tokens shifted since error; after three, turn off error status.
    if (yyerrstatus_)
      --yyerrstatus_;

    // Shift the lookahead token.
    yypush_ ("Shifting", state_type (yyn), YY_MOVE (yyla));
    goto yynewstate;


  /*-----------------------------------------------------------.
  | yydefault -- do the default action for the current state.  |
  `-----------------------------------------------------------*/
  yydefault:
    yyn = yydefact_[+yystack_[0].state];
    if (yyn == 0)
      goto yyerrlab;
    goto yyreduce;


  /*-----------------------------.
  | yyreduce -- do a reduction.  |
  `-----------------------------*/
  yyreduce:
    yylen = yyr2_[yyn];
    {
      stack_symbol_type yylhs;
      yylhs.state = yy_lr_goto_state_ (yystack_[yylen].state, yyr1_[yyn]);
      /* Variants are always initialized to an empty instance of the
         correct type. The default '$$ = $1' action is NOT applied
         when using variants.  */
      switch (yyr1_[yyn])
    {
      case symbol_kind::S_NUMBER: // NUMBER
        yylhs.value.emplace< int > ();
        break;

      case symbol_kind::S_attrib: // attrib
        yylhs.value.emplace< std::pair< std::string, std::string > > ();
        break;

      case symbol_kind::S_TEXT: // TEXT
      case symbol_kind::S_DOLLAR_SIGN: // DOLLAR_SIGN
      case symbol_kind::S_DOT: // DOT
      case symbol_kind::S_INDIRECT_MEMBER: // INDIRECT_MEMBER
      case symbol_kind::S_COMMA: // COMMA
      case symbol_kind::S_EQUAL: // EQUAL
      case symbol_kind::S_VBAR: // VBAR
      case symbol_kind::S_COLON: // COLON
      case symbol_kind::S_STRING_LITERAL: // STRING_LITERAL
      case symbol_kind::S_NUMERIC_LITERAL: // NUMERIC_LITERAL
      case symbol_kind::S_ID: // ID
      case symbol_kind::S_SYMBOL: // SYMBOL
      case symbol_kind::S_CONST_SYMBOL: // CONST_SYMBOL
      case symbol_kind::S_LBRACE: // LBRACE
      case symbol_kind::S_RBRACE: // RBRACE
      case symbol_kind::S_LBRACKET: // LBRACKET
      case symbol_kind::S_RBRACKET: // RBRACKET
      case symbol_kind::S_LPAREN: // LPAREN
      case symbol_kind::S_RPAREN: // RPAREN
      case symbol_kind::S_CONFIG_LOAD: // CONFIG_LOAD
      case symbol_kind::S_INCLUDE: // INCLUDE
      case symbol_kind::S_REQUIRE: // REQUIRE
      case symbol_kind::S_INSERT: // INSERT
      case symbol_kind::S_ASSIGN: // ASSIGN
      case symbol_kind::S_CAPITALIZE: // CAPITALIZE
      case symbol_kind::S_CAT: // CAT
      case symbol_kind::S_COUNT_CHARACTERS: // COUNT_CHARACTERS
      case symbol_kind::S_COUNT_SENTENCES: // COUNT_SENTENCES
      case symbol_kind::S_COUNT_PARAGRAPHS: // COUNT_PARAGRAPHS
      case symbol_kind::S_DATE_FORMAT: // DATE_FORMAT
      case symbol_kind::S_ESCAPE: // ESCAPE
      case symbol_kind::S_INDENT: // INDENT
      case symbol_kind::S_LOWER: // LOWER
      case symbol_kind::S_UPPER: // UPPER
      case symbol_kind::S_STRIP: // STRIP
      case symbol_kind::S_REPLACE: // REPLACE
      case symbol_kind::S_SPACIFY: // SPACIFY
      case symbol_kind::S_STRING_FORMAT: // STRING_FORMAT
      case symbol_kind::S_STRIP_TAGS: // STRIP_TAGS
      case symbol_kind::S_TRUNCATE: // TRUNCATE
      case symbol_kind::S_WORDWARP: // WORDWARP
      case symbol_kind::S_VAR_ATTRIB: // VAR_ATTRIB
      case symbol_kind::S_VALUE_ATTRIB: // VALUE_ATTRIB
      case symbol_kind::S_FILE_ATTRIB: // FILE_ATTRIB
      case symbol_kind::S_FILE_NAME: // FILE_NAME
      case symbol_kind::S_colon_sep_params: // colon_sep_params
      case symbol_kind::S_colon_sep_param: // colon_sep_param
      case symbol_kind::S_qualafied_id: // qualafied_id
      case symbol_kind::S_sub_proc: // sub_proc
      case symbol_kind::S_array: // array
      case symbol_kind::S_symbol: // symbol
      case symbol_kind::S_modifier: // modifier
      case symbol_kind::S_built_in: // built_in
      case symbol_kind::S_attributes: // attributes
        yylhs.value.emplace< std::string > ();
        break;

      default:
        break;
    }



      // Perform the reduction.
      YY_REDUCE_PRINT (yyn);
#if YY_EXCEPTIONS
      try
#endif // YY_EXCEPTIONS
        {
          switch (yyn)
            {
  case 2: // exe: files
#line 128 "parser2.yy"
                                                                {
                                                                    std::cout <<  FMT_FG_GREEN << "PARSER exe: | files" << FMT_RESET << endl;
                                                                    cout << FMT_FG_YELLOW << "*********************** STOPPING **********************" << FMT_REVERSE << FMT_RESET << endl;
                                                                    cout << FMT_FG_YELLOW << "*                     Terminating.                    *" << FMT_REVERSE << FMT_RESET << endl;
                                                                    cout << FMT_FG_YELLOW << "************************* Done ************************" << FMT_REVERSE << FMT_RESET << endl;
                                                                }
#line 3229 "parser2.cc"
    break;

  case 3: // exe: files END_OF_FILES
#line 134 "parser2.yy"
                                                                {
                                                                    cout << FMT_FG_YELLOW
                                                                            << "PARSER exe: | files END_OF_FILES"
                                                                         << FMT_RESET << endl;
                                                                }
#line 3239 "parser2.cc"
    break;

  case 4: // files: file
#line 142 "parser2.yy"
                                                                { cout << FMT_FG_YELLOW << "PARSER files: | file" << FMT_RESET << endl; }
#line 3245 "parser2.cc"
    break;

  case 5: // files: files file
#line 143 "parser2.yy"
                                                                { cout << FMT_FG_YELLOW << "PARSER files: | files file" << FMT_RESET << endl; }
#line 3251 "parser2.cc"
    break;

  case 6: // file: blocks "end of input"
#line 147 "parser2.yy"
                                                                {
                                                                    cout << FMT_FG_YELLOW << "PARSER file: | blocks END_OF_FILE" << FMT_RESET << endl;
                                                                    cout << FMT_FG_YELLOW << "*******************************************************" << FMT_REVERSE << FMT_RESET << endl;
                                                                    cout << FMT_FG_YELLOW << "*                      End Of File                    *" << FMT_REVERSE << FMT_RESET << endl;
                                                                    cout << FMT_FG_YELLOW << "*******************************************************" << FMT_REVERSE << FMT_RESET << endl;
                                                                }
#line 3262 "parser2.cc"
    break;

  case 7: // blocks: tag
#line 156 "parser2.yy"
                                                              {
                                                                    cout << FMT_FG_YELLOW
                                                                            << "PARSER blocks: | block"
                                                                         << FMT_RESET << endl;
                                                                }
#line 3272 "parser2.cc"
    break;

  case 8: // blocks: blocks tag
#line 161 "parser2.yy"
                                                              {
                                                                    cout << FMT_FG_YELLOW
                                                                            << "PARSER blocks: | blocks block"
                                                                         << FMT_RESET << endl;
                                                                }
#line 3282 "parser2.cc"
    break;

  case 9: // tag: LBRACE sub_proc RBRACE
#line 169 "parser2.yy"
                                                                {
                                                                    cout << FMT_FG_YELLOW
                                                                            << "PARSER block: | LBRACE sub_porc RBRACE"
                                                                         << FMT_RESET << endl;
                                                                }
#line 3292 "parser2.cc"
    break;

  case 10: // tag: LBRACE array RBRACE
#line 174 "parser2.yy"
                                                                {
                                                                    cout << FMT_FG_YELLOW
                                                                            << "PARSER block: | LBRACE array RBRACE"
                                                                         << FMT_RESET << endl;
                                                                }
#line 3302 "parser2.cc"
    break;

  case 11: // tag: LBRACE symbol VBAR modifier RBRACE
#line 179 "parser2.yy"
                                                                {
                                                                    #ifdef VERBOSE
                                                                    cout << "PARSER tag: | LBRACE symbol=%s VBAR modifier=%s RBRACE%s, FMT_FG_BLUE,  $2, $4, FMT_RESET" << endl;;
                                                                    #endif
                                                                }
#line 3312 "parser2.cc"
    break;

  case 12: // tag: LBRACE symbol VBAR modifier colon_sep_params RBRACE
#line 184 "parser2.yy"
                                                                {
                                                                    #ifdef VERBOSE
                                                                    couit "%sPARSER tag: | LBRACE symbol=%s VBAR modifier=%s colon_sep_param RBRACE%s\n" << "FMT_FG_BLUE, $2, $4, FMT_RESET" <<  endl;
                                                                    #endif
                                                                }
#line 3322 "parser2.cc"
    break;

  case 13: // tag: LBRACE symbol RBRACE
#line 189 "parser2.yy"
                                                                {
                                                                    cout << FMT_FG_YELLOW
                                                                            << "PARSER block: | LBRACE symbol RBRACE"
                                                                         << FMT_RESET << endl;
                                                                }
#line 3332 "parser2.cc"
    break;

  case 14: // tag: LBRACE qualafied_id RBRACE
#line 194 "parser2.yy"
                                                                {
                                                                    cout << FMT_FG_YELLOW
                                                                            << "PARSER block: | LBRACE qualafied_id RBRACE"
                                                                         << FMT_RESET << endl;
                                                                }
#line 3342 "parser2.cc"
    break;

  case 15: // tag: LBRACE built_in RBRACE
#line 199 "parser2.yy"
                                                                {
                                                                    cout << FMT_FG_YELLOW
                                                                            << "PARSER block: | LBRACE built_in RBRACE"
                                                                         << FMT_RESET << endl;

                                                                    //free_all_nvalues();
                                                                }
#line 3354 "parser2.cc"
    break;

  case 16: // tag: NUMBER
#line 206 "parser2.yy"
                                                                {
                                                                    cout << FMT_FG_RED
                                                                            << "block: NUMBER"
                                                                        << FMT_RESET << endl;   }
#line 3363 "parser2.cc"
    break;

  case 17: // colon_sep_params: colon_sep_param
#line 213 "parser2.yy"
                                                                {
                                                                    #ifdef VERBOSE
                                                                    GREEN("colon_sep_params: | colon_sep_param\n");
                                                                    #endif
                                                                }
#line 3373 "parser2.cc"
    break;

  case 18: // colon_sep_params: colon_sep_params colon_sep_param
#line 218 "parser2.yy"
                                                                {}
#line 3379 "parser2.cc"
    break;

  case 19: // colon_sep_param: COLON NUMERIC_LITERAL
#line 222 "parser2.yy"
                                                                {
                                                                    #ifdef VERBOSE
                                                                    GREEN("colon_sep_param: | COLON NUMERIC_LITERAL\n");
                                                                    #endif
                                                                }
#line 3389 "parser2.cc"
    break;

  case 20: // params: param
#line 229 "parser2.yy"
                                                            { cout << FMT_FG_YELLOW << "PARSER params: | param" << FMT_RESET << endl; }
#line 3395 "parser2.cc"
    break;

  case 21: // params: params symbol
#line 230 "parser2.yy"
                                                            { cout << FMT_FG_YELLOW << "PARSER qualafied_id: | params COMMA symbol" << FMT_RESET << endl; }
#line 3401 "parser2.cc"
    break;

  case 22: // param: symbol COMMA
#line 234 "parser2.yy"
                                                            { cout << FMT_FG_YELLOW << "PARSER param: | symbol COMMA" << FMT_RESET << endl; }
#line 3407 "parser2.cc"
    break;

  case 23: // qualafied_id: symbol DOT ID
#line 239 "parser2.yy"
                                                                {
                                                                    cout << FMT_FG_YELLOW
                                                                            << "PARSER qualafied_id: | symbol DOT ID"
                                                                         << FMT_RESET << endl;
                                                                }
#line 3417 "parser2.cc"
    break;

  case 24: // qualafied_id: symbol DOT symbol
#line 244 "parser2.yy"
                                                                {
                                                                    cout << FMT_FG_YELLOW
                                                                            << "PARSER qualafied_id: | symbol DOT symbol"
                                                                         << FMT_RESET << endl;
                                                                }
#line 3427 "parser2.cc"
    break;

  case 25: // qualafied_id: symbol INDIRECT_MEMBER ID
#line 249 "parser2.yy"
                                                                { cout << FMT_FG_YELLOW << "PARSER qualafied_id: | symbol INDIRECT_MEMBER ID" << FMT_RESET << endl; }
#line 3433 "parser2.cc"
    break;

  case 26: // qualafied_id: qualafied_id DOT ID
#line 250 "parser2.yy"
                                                                { cout << FMT_FG_YELLOW << "PARSER qualafied_id: | qualafied_id DOT ID" << FMT_RESET << endl; }
#line 3439 "parser2.cc"
    break;

  case 27: // qualafied_id: qualafied_id INDIRECT_MEMBER ID
#line 251 "parser2.yy"
                                                                { cout << FMT_FG_YELLOW << "PARSER qualafied_id: | qualafied_id INDIRECT_MEMBER ID" << FMT_RESET << endl; }
#line 3445 "parser2.cc"
    break;

  case 28: // sub_proc: symbol LPAREN RPAREN
#line 255 "parser2.yy"
                                                                { cout << endl; }
#line 3451 "parser2.cc"
    break;

  case 29: // sub_proc: symbol LPAREN params RPAREN
#line 256 "parser2.yy"
                                                                  {
                                                                    cout << FMT_FG_YELLOW
                                                                            << "PARSER sub_proc: | symbol LPAREN params RPAREN"
                                                                         << FMT_RESET << endl;
                                                                    yylhs.value.as < std::string > ()=yystack_[3].value.as < std::string > ();
                                                                }
#line 3462 "parser2.cc"
    break;

  case 30: // array: symbol LBRACKET NUMERIC_LITERAL RBRACKET
#line 265 "parser2.yy"
                                                                {
                                                                    cout << FMT_FG_YELLOW
                                                                            << "PARSER array: | symbol=\"" << yystack_[3].value.as < std::string > () << "\" LBRACKET NUMERIC_LITERAL=\"" << yystack_[1].value.as < std::string > () << "\" RBRACKET"
                                                                         << FMT_RESET << endl;;
                                                                    yylhs.value.as < std::string > ()=yystack_[3].value.as < std::string > ();
                                                                }
#line 3473 "parser2.cc"
    break;

  case 31: // symbol: SYMBOL
#line 275 "parser2.yy"
                                                            {
                                                                cout << FMT_FG_YELLOW
                                                                     << "PARSER symbol: | SYMBOL"
                                                                     << FMT_RESET << endl;
                                                                yylhs.value.as < std::string > ()=yystack_[0].value.as < std::string > ();
                                                            }
#line 3484 "parser2.cc"
    break;

  case 32: // symbol: CONST_SYMBOL
#line 281 "parser2.yy"
                                                            {
                                                                cout << FMT_FG_YELLOW
                                                                     << "PARSER symbol: | CONST_SYMBOL"
                                                                     << FMT_RESET << endl;
                                                                yylhs.value.as < std::string > ()=yystack_[0].value.as < std::string > ();
                                                            }
#line 3495 "parser2.cc"
    break;

  case 33: // modifier: CAPITALIZE
#line 291 "parser2.yy"
                                                                {
                                                                    cout << FMT_FG_YELLOW
                                                                            << "PARSER modifier: | CAPITALIZE"
                                                                         << FMT_RESET << endl;
                                                                }
#line 3505 "parser2.cc"
    break;

  case 34: // modifier: CAT
#line 296 "parser2.yy"
      { yylhs.value.as < std::string > () = yystack_[0].value.as < std::string > (); }
#line 3511 "parser2.cc"
    break;

  case 35: // modifier: COUNT_CHARACTERS
#line 297 "parser2.yy"
      { yylhs.value.as < std::string > () = yystack_[0].value.as < std::string > (); }
#line 3517 "parser2.cc"
    break;

  case 36: // modifier: COUNT_SENTENCES
#line 298 "parser2.yy"
      { yylhs.value.as < std::string > () = yystack_[0].value.as < std::string > (); }
#line 3523 "parser2.cc"
    break;

  case 37: // modifier: COUNT_PARAGRAPHS
#line 299 "parser2.yy"
      { yylhs.value.as < std::string > () = yystack_[0].value.as < std::string > (); }
#line 3529 "parser2.cc"
    break;

  case 38: // modifier: DATE_FORMAT
#line 300 "parser2.yy"
      { yylhs.value.as < std::string > () = yystack_[0].value.as < std::string > (); }
#line 3535 "parser2.cc"
    break;

  case 39: // modifier: ESCAPE
#line 301 "parser2.yy"
      { yylhs.value.as < std::string > () = yystack_[0].value.as < std::string > (); }
#line 3541 "parser2.cc"
    break;

  case 40: // modifier: INDENT
#line 302 "parser2.yy"
      { yylhs.value.as < std::string > () = yystack_[0].value.as < std::string > (); }
#line 3547 "parser2.cc"
    break;

  case 41: // modifier: LOWER
#line 303 "parser2.yy"
      { yylhs.value.as < std::string > () = yystack_[0].value.as < std::string > (); }
#line 3553 "parser2.cc"
    break;

  case 42: // modifier: UPPER
#line 304 "parser2.yy"
      { yylhs.value.as < std::string > () = yystack_[0].value.as < std::string > (); }
#line 3559 "parser2.cc"
    break;

  case 43: // modifier: STRIP
#line 305 "parser2.yy"
      { yylhs.value.as < std::string > () = yystack_[0].value.as < std::string > (); }
#line 3565 "parser2.cc"
    break;

  case 44: // modifier: REPLACE
#line 306 "parser2.yy"
      { yylhs.value.as < std::string > () = yystack_[0].value.as < std::string > (); }
#line 3571 "parser2.cc"
    break;

  case 45: // modifier: SPACIFY
#line 307 "parser2.yy"
      { yylhs.value.as < std::string > () = yystack_[0].value.as < std::string > (); }
#line 3577 "parser2.cc"
    break;

  case 46: // modifier: STRING_FORMAT
#line 308 "parser2.yy"
      { yylhs.value.as < std::string > () = yystack_[0].value.as < std::string > (); }
#line 3583 "parser2.cc"
    break;

  case 47: // modifier: STRIP_TAGS
#line 309 "parser2.yy"
      { yylhs.value.as < std::string > () = yystack_[0].value.as < std::string > (); }
#line 3589 "parser2.cc"
    break;

  case 48: // modifier: TRUNCATE
#line 310 "parser2.yy"
      { yylhs.value.as < std::string > () = yystack_[0].value.as < std::string > (); }
#line 3595 "parser2.cc"
    break;

  case 49: // modifier: WORDWARP
#line 311 "parser2.yy"
      { yylhs.value.as < std::string > () = yystack_[0].value.as < std::string > (); }
#line 3601 "parser2.cc"
    break;

  case 50: // built_in: CONFIG_LOAD attributes
#line 316 "parser2.yy"
                                                                {
                                                                    cout << FMT_FG_YELLOW << "PARSER built_in: | CONFIG_LOAD FILE_ATTRIB=\""
                                                                         << yystack_[1].value.as < std::string > () << "\" EQUAL STRING_LITERAL=\"$2\""
                                                                         << FMT_RESET << endl;
                                                                }
#line 3611 "parser2.cc"
    break;

  case 51: // built_in: INCLUDE attributes
#line 321 "parser2.yy"
                                                                {
                                                                    cout << FMT_FG_YELLOW
                                                                            << "PARSER built_in: | INCLUDE FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"\""
                                                                         << FMT_RESET << endl;
                                                                }
#line 3621 "parser2.cc"
    break;

  case 52: // built_in: REQUIRE attributes
#line 326 "parser2.yy"
                                                                {
                                                                    cout << FMT_FG_YELLOW
                                                                         << "PARSER built_in: | REQUIRE FILE_ATTRIB=\"%s\" EQUAL STRING_LITERAL=\"\""
                                                                         << FMT_RESET << endl;

                                                                }
#line 3632 "parser2.cc"
    break;

  case 53: // built_in: INSERT attributes
#line 332 "parser2.yy"
                                                                {
                                                                    cout << FMT_FG_YELLOW
                                                                         << "PARSER built_in: | INSERT FILE_ATTRIB=\"\" EQUAL STRING_LITERAL=\"\""
                                                                         << FMT_RESET << endl;

                                                                }
#line 3643 "parser2.cc"
    break;

  case 54: // built_in: ASSIGN attributes
#line 338 "parser2.yy"
                                                                {
                                                                    cout << FMT_FG_YELLOW
                                                                            << "PARSER built_in: | INSERT FILE_ATTRIB=\"\" EQUAL STRING_LITERAL=\"\""
                                                                         << FMT_RESET << endl;
                                                                }
#line 3653 "parser2.cc"
    break;

  case 55: // attributes: attrib
#line 345 "parser2.yy"
                                                               {
                                                                    cout << FMT_FG_YELLOW
                                                                            << "PARSER attribute: | attribute={name=\"\"; value=\"\"\n"
                                                                         << FMT_RESET << endl;
                                                               }
#line 3663 "parser2.cc"
    break;

  case 56: // attributes: attributes attrib
#line 350 "parser2.yy"
                                                               {
                                                                    cout << FMT_FG_YELLOW
                                                                            << "PARSER attributes: | attribute={name=\"\"; value=\"\"\n"
                                                                         << FMT_RESET << endl;
                                                               }
#line 3673 "parser2.cc"
    break;

  case 57: // attrib: VALUE_ATTRIB EQUAL STRING_LITERAL
#line 358 "parser2.yy"
                                                               {
                                                                    cout << FMT_FG_YELLOW << "PARSER name_value: | VALUE_ATTRIB=\""
                                                                            << yystack_[2].value.as < std::string > () << "\" EQUAL STRING_LITERAL=\""
                                                                            << buf << "\""
                                                                         << FMT_RESET << endl;

                                                                    std::pair<std::string, std::string>  pair(yystack_[2].value.as < std::string > (), yystack_[1].value.as < std::string > ());
                                                                    yylhs.value.as < std::pair< std::string, std::string > > () = pair;
                                                               }
#line 3687 "parser2.cc"
    break;

  case 58: // attrib: VAR_ATTRIB EQUAL STRING_LITERAL
#line 367 "parser2.yy"
                                                               {
                                                                    cout << FMT_FG_YELLOW
                                                                            << "PARSER name_value: | VAR_ATTRIB=\"\" EQUAL STRING_LITERAL=\"\""
                                                                         << FMT_FG_GREEN << FMT_RESET << endl;

                                                                    std::pair<std::string, std::string>  pair(yystack_[2].value.as < std::string > (), yystack_[1].value.as < std::string > ());
                                                                    yylhs.value.as < std::pair< std::string, std::string > > () = pair;
                                                                }
#line 3700 "parser2.cc"
    break;

  case 59: // attrib: FILE_ATTRIB EQUAL STRING_LITERAL
#line 375 "parser2.yy"
                                                                {
                                                                    cout << FMT_FG_YELLOW
                                                                            << "PARSER name_value: | FILE_ATTRIB=\""
                                                                            << yystack_[2].value.as < std::string > () << "\" EQUAL STRING_LITERAL=\""
                                                                            << yystack_[1].value.as < std::string > () << "\""
                                                                         << FMT_RESET << endl;

                                                                    std::pair<std::string, std::string>  pair(yystack_[2].value.as < std::string > (), yystack_[1].value.as < std::string > ());
                                                                    yylhs.value.as < std::pair< std::string, std::string > > () = pair;
                                                               }
#line 3715 "parser2.cc"
    break;


#line 3719 "parser2.cc"

            default:
              break;
            }
        }
#if YY_EXCEPTIONS
      catch (const syntax_error& yyexc)
        {
          YYCDEBUG << "Caught exception: " << yyexc.what() << '\n';
          error (yyexc);
          YYERROR;
        }
#endif // YY_EXCEPTIONS
      YY_SYMBOL_PRINT ("-> $$ =", yylhs);
      yypop_ (yylen);
      yylen = 0;

      // Shift the result of the reduction.
      yypush_ (YY_NULLPTR, YY_MOVE (yylhs));
    }
    goto yynewstate;


  /*--------------------------------------.
  | yyerrlab -- here on detecting error.  |
  `--------------------------------------*/
  yyerrlab:
    // If not already recovering from an error, report this error.
    if (!yyerrstatus_)
      {
        ++yynerrs_;
        std::string msg = YY_("syntax error");
        error (YY_MOVE (msg));
      }


    if (yyerrstatus_ == 3)
      {
        /* If just tried and failed to reuse lookahead token after an
           error, discard it.  */

        // Return failure if at end of input.
        if (yyla.kind () == symbol_kind::S_YYEOF)
          YYABORT;
        else if (!yyla.empty ())
          {
            yy_destroy_ ("Error: discarding", yyla);
            yyla.clear ();
          }
      }

    // Else will try to reuse lookahead token after shifting the error token.
    goto yyerrlab1;


  /*---------------------------------------------------.
  | yyerrorlab -- error raised explicitly by YYERROR.  |
  `---------------------------------------------------*/
  yyerrorlab:
    /* Pacify compilers when the user code never invokes YYERROR and
       the label yyerrorlab therefore never appears in user code.  */
    if (false)
      YYERROR;

    /* Do not reclaim the symbols of the rule whose action triggered
       this YYERROR.  */
    yypop_ (yylen);
    yylen = 0;
    YY_STACK_PRINT ();
    goto yyerrlab1;


  /*-------------------------------------------------------------.
  | yyerrlab1 -- common code for both syntax error and YYERROR.  |
  `-------------------------------------------------------------*/
  yyerrlab1:
    yyerrstatus_ = 3;   // Each real token shifted decrements this.
    // Pop stack until we find a state that shifts the error token.
    for (;;)
      {
        yyn = yypact_[+yystack_[0].state];
        if (!yy_pact_value_is_default_ (yyn))
          {
            yyn += symbol_kind::S_YYerror;
            if (0 <= yyn && yyn <= yylast_
                && yycheck_[yyn] == symbol_kind::S_YYerror)
              {
                yyn = yytable_[yyn];
                if (0 < yyn)
                  break;
              }
          }

        // Pop the current state because it cannot handle the error token.
        if (yystack_.size () == 1)
          YYABORT;

        yy_destroy_ ("Error: popping", yystack_[0]);
        yypop_ ();
        YY_STACK_PRINT ();
      }
    {
      stack_symbol_type error_token;


      // Shift the error token.
      error_token.state = state_type (yyn);
      yypush_ ("Shifting", YY_MOVE (error_token));
    }
    goto yynewstate;


  /*-------------------------------------.
  | yyacceptlab -- YYACCEPT comes here.  |
  `-------------------------------------*/
  yyacceptlab:
    yyresult = 0;
    goto yyreturn;


  /*-----------------------------------.
  | yyabortlab -- YYABORT comes here.  |
  `-----------------------------------*/
  yyabortlab:
    yyresult = 1;
    goto yyreturn;


  /*-----------------------------------------------------.
  | yyreturn -- parsing is finished, return the result.  |
  `-----------------------------------------------------*/
  yyreturn:
    if (!yyla.empty ())
      yy_destroy_ ("Cleanup: discarding lookahead", yyla);

    /* Do not reclaim the symbols of the rule whose action triggered
       this YYABORT or YYACCEPT.  */
    yypop_ (yylen);
    YY_STACK_PRINT ();
    while (1 < yystack_.size ())
      {
        yy_destroy_ ("Cleanup: popping", yystack_[0]);
        yypop_ ();
      }

    return yyresult;
  }
#if YY_EXCEPTIONS
    catch (...)
      {
        YYCDEBUG << "Exception caught: cleaning lookahead and stack\n";
        // Do not try to display the values of the reclaimed symbols,
        // as their printers might throw an exception.
        if (!yyla.empty ())
          yy_destroy_ (YY_NULLPTR, yyla);

        while (1 < yystack_.size ())
          {
            yy_destroy_ (YY_NULLPTR, yystack_[0]);
            yypop_ ();
          }
        throw;
      }
#endif // YY_EXCEPTIONS
  }

  void
  parser::error (const syntax_error& yyexc)
  {
    error (yyexc.what ());
  }

#if YYDEBUG || 0
  const char *
  parser::symbol_name (symbol_kind_type yysymbol)
  {
    return yytname_[yysymbol];
  }
#endif // #if YYDEBUG || 0









  const signed char parser::yypact_ninf_ = -40;

  const signed char parser::yytable_ninf_ = -1;

  const signed char
  parser::yypact_[] =
  {
       5,   -40,    38,     2,     4,   -40,     1,   -40,   -40,   -40,
     -16,   -16,   -16,   -16,   -16,     6,    -8,    -7,    -4,    -2,
     -40,   -40,   -40,   -40,   -40,    11,    14,    24,   -16,   -40,
     -16,   -16,   -16,   -16,    55,    63,   -40,   -40,   -40,    60,
      64,     8,   -40,    66,    10,   -40,     7,    68,    69,   -40,
     -40,   -40,   -40,   -40,   -40,   -40,   -40,   -40,   -40,   -40,
     -40,   -40,   -40,   -40,   -40,   -40,   -40,   -40,   -40,   -40,
     -40,   -40,    48,    62,   -40,    12,   -40,    75,   -40,   -40,
     -40,    71,   -40,    49,   -40,   -40,   -40,   -40,   -40,   -40,
     -40,   -40
  };

  const signed char
  parser::yydefact_[] =
  {
       0,    16,     0,     0,     2,     4,     0,     7,    31,    32,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       1,     3,     5,     6,     8,     0,     0,     0,    50,    55,
      51,    52,    53,    54,     0,     0,    14,     9,    10,     0,
       0,     0,    13,     0,     0,    15,     0,     0,     0,    56,
      26,    27,    23,    24,    25,    33,    34,    35,    36,    37,
      38,    39,    40,    41,    42,    43,    44,    45,    46,    47,
      48,    49,     0,     0,    28,     0,    20,     0,    58,    57,
      59,     0,    11,     0,    17,    30,    29,    21,    22,    19,
      12,    18
  };

  const signed char
  parser::yypgoto_[] =
  {
     -40,   -40,   -40,    82,   -40,    81,   -40,     9,   -40,   -40,
     -40,   -40,   -40,   -39,   -40,   -40,    45,    41
  };

  const signed char
  parser::yydefgoto_[] =
  {
       0,     3,     4,     5,     6,     7,    83,    84,    75,    76,
      15,    16,    17,    18,    72,    19,    28,    29
  };

  const signed char
  parser::yytable_[] =
  {
      53,    23,    20,    39,    40,    77,     1,    41,    21,     1,
       1,    37,    38,    34,    35,    42,    43,    45,    44,     2,
      78,    46,     2,     2,    47,    36,     8,     9,     8,     9,
      25,    26,    27,    74,    48,    86,    87,    55,    56,    57,
      58,    59,    60,    61,    62,    63,    64,    65,    66,    67,
      68,    69,    70,    71,     8,     9,    30,    31,    32,    33,
      81,    81,    10,    11,    12,    13,    14,    82,    90,    49,
      50,    49,    49,    49,    49,    52,     8,     9,    51,    54,
      73,    79,    80,    85,    88,    89,    22,    24,     0,     0,
       0,     0,    91
  };

  const signed char
  parser::yycheck_[] =
  {
      39,     0,     0,     7,     8,    44,     5,    11,     4,     5,
       5,    19,    19,     7,     8,    19,    20,    19,    22,    18,
      13,    10,    18,    18,    10,    19,    16,    17,    16,    17,
      46,    47,    48,    23,    10,    23,    75,    29,    30,    31,
      32,    33,    34,    35,    36,    37,    38,    39,    40,    41,
      42,    43,    44,    45,    16,    17,    11,    12,    13,    14,
      12,    12,    24,    25,    26,    27,    28,    19,    19,    28,
      15,    30,    31,    32,    33,    15,    16,    17,    15,    15,
      14,    13,    13,    21,     9,    14,     4,     6,    -1,    -1,
      -1,    -1,    83
  };

  const signed char
  parser::yystos_[] =
  {
       0,     5,    18,    51,    52,    53,    54,    55,    16,    17,
      24,    25,    26,    27,    28,    60,    61,    62,    63,    65,
       0,     4,    53,     0,    55,    46,    47,    48,    66,    67,
      66,    66,    66,    66,     7,     8,    19,    19,    19,     7,
       8,    11,    19,    20,    22,    19,    10,    10,    10,    67,
      15,    15,    15,    63,    15,    29,    30,    31,    32,    33,
      34,    35,    36,    37,    38,    39,    40,    41,    42,    43,
      44,    45,    64,    14,    23,    58,    59,    63,    13,    13,
      13,    12,    19,    56,    57,    21,    23,    63,     9,    14,
      19,    57
  };

  const signed char
  parser::yyr1_[] =
  {
       0,    50,    51,    51,    52,    52,    53,    54,    54,    55,
      55,    55,    55,    55,    55,    55,    55,    56,    56,    57,
      58,    58,    59,    60,    60,    60,    60,    60,    61,    61,
      62,    63,    63,    64,    64,    64,    64,    64,    64,    64,
      64,    64,    64,    64,    64,    64,    64,    64,    64,    64,
      65,    65,    65,    65,    65,    66,    66,    67,    67,    67
  };

  const signed char
  parser::yyr2_[] =
  {
       0,     2,     1,     2,     1,     2,     2,     1,     2,     3,
       3,     5,     6,     3,     3,     3,     1,     1,     2,     2,
       1,     2,     2,     3,     3,     3,     3,     3,     3,     4,
       4,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       2,     2,     2,     2,     2,     1,     2,     3,     3,     3
  };


#if YYDEBUG
  // YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
  // First, the terminals, then, starting at \a YYNTOKENS, nonterminals.
  const char*
  const parser::yytname_[] =
  {
  "\"end of input\"", "error", "\"invalid token\"", "TEXT",
  "END_OF_FILES", "NUMBER", "DOLLAR_SIGN", "DOT", "INDIRECT_MEMBER",
  "COMMA", "EQUAL", "VBAR", "COLON", "STRING_LITERAL", "NUMERIC_LITERAL",
  "ID", "SYMBOL", "CONST_SYMBOL", "LBRACE", "RBRACE", "LBRACKET",
  "RBRACKET", "LPAREN", "RPAREN", "CONFIG_LOAD", "INCLUDE", "REQUIRE",
  "INSERT", "ASSIGN", "CAPITALIZE", "CAT", "COUNT_CHARACTERS",
  "COUNT_SENTENCES", "COUNT_PARAGRAPHS", "DATE_FORMAT", "ESCAPE", "INDENT",
  "LOWER", "UPPER", "STRIP", "REPLACE", "SPACIFY", "STRING_FORMAT",
  "STRIP_TAGS", "TRUNCATE", "WORDWARP", "VAR_ATTRIB", "VALUE_ATTRIB",
  "FILE_ATTRIB", "FILE_NAME", "$accept", "exe", "files", "file", "blocks",
  "tag", "colon_sep_params", "colon_sep_param", "params", "param",
  "qualafied_id", "sub_proc", "array", "symbol", "modifier", "built_in",
  "attributes", "attrib", YY_NULLPTR
  };
#endif


#if YYDEBUG
  const short
  parser::yyrline_[] =
  {
       0,   128,   128,   134,   142,   143,   147,   156,   161,   169,
     174,   179,   184,   189,   194,   199,   206,   213,   218,   222,
     229,   230,   234,   239,   244,   249,   250,   251,   255,   256,
     265,   275,   281,   291,   296,   297,   298,   299,   300,   301,
     302,   303,   304,   305,   306,   307,   308,   309,   310,   311,
     316,   321,   326,   332,   338,   345,   350,   358,   367,   375
  };

  void
  parser::yy_stack_print_ () const
  {
    *yycdebug_ << "Stack now";
    for (stack_type::const_iterator
           i = yystack_.begin (),
           i_end = yystack_.end ();
         i != i_end; ++i)
      *yycdebug_ << ' ' << int (i->state);
    *yycdebug_ << '\n';
  }

  void
  parser::yy_reduce_print_ (int yyrule) const
  {
    int yylno = yyrline_[yyrule];
    int yynrhs = yyr2_[yyrule];
    // Print the symbols being reduced, and their result.
    *yycdebug_ << "Reducing stack by rule " << yyrule - 1
               << " (line " << yylno << "):\n";
    // The symbols being reduced.
    for (int yyi = 0; yyi < yynrhs; yyi++)
      YY_SYMBOL_PRINT ("   $" << yyi + 1 << " =",
                       yystack_[(yynrhs) - (yyi + 1)]);
  }
#endif // YYDEBUG


} // yy
#line 4088 "parser2.cc"

#line 387 "parser2.yy"


namespace yy
{
    // report an error to the user
    auto parser::error(const std::string& msg) -> void
    {
        std::cerr << msg << '\n';
    }
}

int main()
{
    yy::parser parse;
    return parse();
}
