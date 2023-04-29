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

#ifndef YY_YY_PARSEUR_TAB_H_INCLUDED
# define YY_YY_PARSEUR_TAB_H_INCLUDED
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
    ID = 258,                      /* ID  */
    IF = 259,                      /* IF  */
    THEN = 260,                    /* THEN  */
    ELSE = 261,                    /* ELSE  */
    ELSEIF = 262,                  /* ELSEIF  */
    ENDIF = 263,                   /* ENDIF  */
    AO = 264,                      /* AO  */
    AF = 265,                      /* AF  */
    FOR = 266,                     /* FOR  */
    WHILE = 267,                   /* WHILE  */
    ENTIER = 268,                  /* ENTIER  */
    REEL = 269,                    /* REEL  */
    COSINUS = 270,                 /* COSINUS  */
    SINUS = 271,                   /* SINUS  */
    TANGANTE = 272,                /* TANGANTE  */
    LOGARITHME = 273,              /* LOGARITHME  */
    INT = 274,                     /* INT  */
    FLOAT = 275,                   /* FLOAT  */
    INF = 276,                     /* INF  */
    SUP = 277,                     /* SUP  */
    INFEGAL = 278,                 /* INFEGAL  */
    SUPEGAL = 279,                 /* SUPEGAL  */
    DIFF = 280,                    /* DIFF  */
    AFFECT = 281,                  /* AFFECT  */
    DEGAL = 282,                   /* DEGAL  */
    PLUS = 283,                    /* PLUS  */
    MOINS = 284,                   /* MOINS  */
    MUL = 285,                     /* MUL  */
    DIVISION = 286,                /* DIVISION  */
    PO = 287,                      /* PO  */
    PF = 288,                      /* PF  */
    PT_VIRG = 289,                 /* PT_VIRG  */
    TANGENTE = 290,                /* TANGENTE  */
    MOINSU = 291                   /* MOINSU  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 16 "parseur.y"
double dval;  int ival; char ch;

#line 103 "parseur.tab.h"

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


#endif /* !YY_YY_PARSEUR_TAB_H_INCLUDED  */
