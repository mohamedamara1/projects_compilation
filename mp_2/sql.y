%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%define parse.error custom
%locations

%token SELECT UPDATE DELETE INSERT JOIN ON TABLE WHERE SET FROM INTO VALUES
%token NAME EQUAL COMMA PV OP CP LT GT PLUS MINUS MULTIPLY DIVISION
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
          | statement_list PV statement
          ;

statement: select_statement
          | update_statement
          | delete_statement
          | insert_statement
          ;

select_statement: SELECT select_expr_list FROM table_references optional_join_clause optional_where_clause
                 ;

update_statement: UPDATE table_name SET column_name EQUAL VALUE optional_where_clause
                 {
                   /* Semantic error: a WHERE clause is required when using the "UPDATE" statement */
                   if (!yypcontext_find_symbol("WHERE")) {
                       printf("Parsing:: semantic error: a WHERE clause is required when using the \"UPDATE\" statement\n");
                   }
                 }
                 ;

delete_statement: DELETE FROM table_name optional_where_clause
                 ;

insert_statement: INSERT INTO table_name  VALUES  OP value_list CP
                 ;

column_list: column_name
            | column_list COMMA column_name
            ;

select_expr_list:
            select_expr
            | select_expr_list ',' select_expr
            | '*'
            ;

select_expr: expr opt_as_alias ;

table_references: table_reference 
    | table_references ',' table_reference 
    ;   

table_list: table_name
            | table_list COMMA table_name
            ;
table_reference:  table_factor
  | join_table
;

table_factor:
          NAME opt_as_alias  
        | NAME '.' NAME opt_as_alias  
        | table_subquery opt_as NAME 
        | '(' table_references ')'
        ;

table_subquery: '(' select_stmt ')' 
   ;

table_name: NAME
            ;

join_clause: JOIN table_name ON expression
            ;

optional_join_clause: join_clause
                     |
                     ;

value_list: VALUE
            | value_list COMMA VALUE
            ;

optional_where_clause: WHERE expression
                      |
                      ;

expression: NAME EQUAL VALUE
           {
               /* Semantic error: a WHERE clause is required when using the "UPDATE" statement */
               if (strcmp($1, "UPDATE") == 0 && !yypcontext_find_symbol("WHERE")) {
                   printf("Parsing:: semantic error: a WHERE clause is required when using the \"UPDATE\" statement\n");
               }

               /* Semantic error: values for NAME and VALUE should not be the same */
               if (strcmp($1, $3) == 0) {
                   printf("Parsing:: semantic error: NAME and VALUE cannot be the same\n");
               }
           }
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

