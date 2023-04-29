
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%define parse.error custom
%locations

%token SELECT UPDATE DELETE INSERT JOIN ON TABLE WHERE SET FROM INTO VALUES
%token NAME EQUAL COMMA OP CP LT GT PLUS MINUS MULTIPLY DIVISION
%token <string_val> VALUE

%start input  /* Add %start statement here */

%union {
    char *string_val;
    double num_val;
}

%%

input: statement_list
     ;

statement_list: statement
          | statement_list ';' statement
          ;

statement: select_statement
          | update_statement
          | delete_statement
          | insert_statement
          ;

select_statement: SELECT column_list FROM table_list optional_join_clause optional_where_clause
                 ;

update_statement: UPDATE table_name SET column_name '=' VALUE optional_where_clause
                 ;

delete_statement: DELETE FROM table_name optional_where_clause
                 ;

insert_statement: INSERT INTO table_name  VALUES  OP value_list CP
                 ;

column_list: column_name
            | column_list ',' column_name
            ;

column_name: NAME
            ;

table_list: table_name
            | table_list ',' table_name
            ;

table_name: NAME
            ;

join_clause: JOIN table_name ON expression
            ;

optional_join_clause: join_clause
                     |
                     ;

value_list: VALUE
            | value_list ',' VALUE
            ;

optional_where_clause: WHERE expression
                      |
                      ;

expression: NAME EQUAL VALUE
           ;

%%

#include <stdio.h> /* printf */

int yyerror(const char *msg){
    printf("Parsing:: syntax error\n");
}

static int yyreport_syntax_error (const yypcontext_t *ctx)
{
  int res = 0;
  //YYLOCATION_PRINT (stderr, *yypcontext_location (ctx));
  fprintf (stderr, ": syntax error");
  // Report the tokens expected at this point.
  {
    enum { TOKENMAX = 5 };
    yysymbol_kind_t expected[TOKENMAX];
    int n = yypcontext_expected_tokens (ctx, expected, TOKENMAX);
    if (n < 0)
      // Forward errors to yyparse.
      res = n;
    else
      for (int i = 0; i < n; ++i)
        fprintf (stderr, "%s %s",
                 i == 0 ? ": expected" : " or", yysymbol_name (expected[i]));
  }
  // Report the unexpected token.
  {
    yysymbol_kind_t lookahead = yypcontext_token (ctx);
    if (lookahead != YYSYMBOL_YYEMPTY)
      fprintf (stderr, " before %s", yysymbol_name (lookahead));
  }
  fprintf (stderr, "\n");
  return res;
}

int yywrap(void){ return 1; } /* stop reading flux yyin */