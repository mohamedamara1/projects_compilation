/* A Bison parser, made by GNU Bison 3.8.2.  */

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
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

#ifndef YY_YY_SQL_TAB_H_INCLUDED
# define YY_YY_SQL_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
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
    SELECT = 258,                  /* SELECT  */
    UPDATE = 259,                  /* UPDATE  */
    DELETE = 260,                  /* DELETE  */
    INSERT = 261,                  /* INSERT  */
    TABLE = 262,                   /* TABLE  */
    WHERE = 263,                   /* WHERE  */
    SET = 264,                     /* SET  */
    FROM = 265,                    /* FROM  */
    INTO = 266,                    /* INTO  */
    VALUES = 267,                  /* VALUES  */
    NAME = 268,                    /* NAME  */
    EQUAL = 269,                   /* EQUAL  */
    COMMA = 270,                   /* COMMA  */
    PV = 271,                      /* PV  */
    OP = 272,                      /* OP  */
    CP = 273,                      /* CP  */
    LT = 274,                      /* LT  */
    GT = 275,                      /* GT  */
    PLUS = 276,                    /* PLUS  */
    MINUS = 277,                   /* MINUS  */
    MULTIPLY = 278,                /* MULTIPLY  */
    DIVISION = 279,                /* DIVISION  */
    ON = 280,                      /* ON  */
    USING = 281,                   /* USING  */
    INNER = 282,                   /* INNER  */
    CROSS = 283,                   /* CROSS  */
    NATURAL = 284,                 /* NATURAL  */
    JOIN = 285,                    /* JOIN  */
    VALUE = 286,                   /* VALUE  */
    AS = 287,                      /* AS  */
    ANY = 288,                     /* ANY  */
    SOME = 289,                    /* SOME  */
    ALL = 290,                     /* ALL  */
    GROUP = 291,                   /* GROUP  */
    BY = 292,                      /* BY  */
    ORDER = 293,                   /* ORDER  */
    ASC = 294,                     /* ASC  */
    DESC = 295,                    /* DESC  */
    ASSIGN = 296,                  /* ASSIGN  */
    OR = 297,                      /* OR  */
    XOR = 298,                     /* XOR  */
    ANDOP = 299,                   /* ANDOP  */
    IN = 300,                      /* IN  */
    IS = 301,                      /* IS  */
    LIKE = 302,                    /* LIKE  */
    REGEXP = 303,                  /* REGEXP  */
    NOT = 304,                     /* NOT  */
    BETWEEN = 305,                 /* BETWEEN  */
    COMPARISON = 306,              /* COMPARISON  */
    SHIFT = 307,                   /* SHIFT  */
    MOD = 308,                     /* MOD  */
    UMINUS = 309                   /* UMINUS  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 40 "sql.y"

    char *string_val;
    double num_val;

#line 123 "sql.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


extern YYSTYPE yylval;
extern YYLTYPE yylloc;

int yyparse (void);


#endif /* !YY_YY_SQL_TAB_H_INCLUDED  */
