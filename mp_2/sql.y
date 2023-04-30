%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%define parse.error custom
%locations

%token SELECT UPDATE DELETE INSERT   TABLE WHERE SET FROM INTO VALUES
%token NAME EQUAL COMMA PV OP CP LT GT PLUS MINUS MULTIPLY DIVISION
%token ON USING INNER CROSS NATURAL JOIN
%token <string_val> VALUE
%token AS
%token ANY
%token SOME
%token ALL
%token GROUP BY ORDER ASC DESC 
%right ASSIGN
%left OR
%left XOR
%left ANDOP
%nonassoc IN IS LIKE REGEXP
%left NOT '!'
%left BETWEEN
%left <subtok> COMPARISON /* = <> < > <= >= <=> */
%left '|'
%left '&'
%left <subtok> SHIFT /* << >> */
%left '+' '-'
%left '*' '/' '%' MOD
%left '^'
%nonassoc UMINUS




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

select_statement: SELECT select_expr_list FROM table_references opt_where
                 ;

update_statement: UPDATE table_references
                  SET update_asgn_list
                  opt_where
                  opt_orderby
             
                 ;

update_asgn_list:
     NAME EQUAL expr 
   | NAME '.' NAME EQUAL expr 
   ;

   opt_where: /* nil */ 
   | WHERE expr
   ;

opt_groupby: /* nil */ 
   | GROUP BY groupby_list
  ;
opt_orderby: /* nil */ | ORDER BY groupby_list 
   ;

  groupby_list: expr opt_asc_desc              
   | groupby_list ',' expr opt_asc_desc                  
   ;

opt_asc_desc: /* nil */
   | ASC               
   | DESC               
    ;

delete_statement: DELETE FROM table_name opt_where
                 ;

insert_statement: INSERT INTO table_name  VALUES  OP value_list CP
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


table_reference:  table_factor
  | join_table
;

table_factor:
          NAME opt_as_alias  
        | NAME '.' NAME opt_as_alias  
        | table_subquery opt_as NAME 
        | '(' table_references ')'
        ;

table_subquery: '(' select_statement ')' 
   ;

table_name: NAME
            ;

opt_as_alias: AS NAME
  | NAME              
  | /* nil */
  ;

opt_as: AS 
  | /* nil */
  ;

join_table:
    table_reference opt_inner_cross JOIN table_factor opt_join_condition
  ;

opt_inner_cross: /* nil */ 
   | INNER 
   | CROSS 
;

opt_join_condition: join_condition | /* nil */ ;

join_condition:
    ON expr 
    | USING '(' column_list ')' 
    ;

column_list: NAME          
  | column_list ',' NAME   
  ;
value_list: VALUE
            | value_list COMMA VALUE
            ;

   /**** expressions ****/

expr: NAME         
   | NAME '.' NAME 
   ;

expr: expr '+' expr
   | expr '-' expr
   | expr '*' expr
   | expr '/' expr
   | expr '%' expr
   | expr MOD expr
   | '-' expr %prec UMINUS
   | expr ANDOP expr
   | expr OR expr
   | expr COMPARISON expr
   | expr COMPARISON '(' select_statement ')'
   | expr COMPARISON ANY '(' select_statement ')'
   | expr COMPARISON SOME '(' select_statement ')'
   | expr COMPARISON ALL '(' select_statement ')'
   | expr '|' expr
   | expr '&' expr
   | NOT expr
   | '!' expr
   | VALUE
   | expr EQUAL expr


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

