%{
#include <stdlib.h>
#include <math.h>
#include <string.h>

// Define a struct for storing symbol table entries
typedef struct {
    char* name;
    int type;  // 0 for int, 1 for float
} symbol;

// Define a hash table to store symbol table entries
#define TABLE_SIZE 100
symbol* symbol_table[TABLE_SIZE];

// Function to hash a string
unsigned long hash(char* str) {
    unsigned long hash = 5381;
    int c;

    while ((c = *str++))
        hash = ((hash << 5) + hash) + c; /* hash * 33 + c */

    return hash % TABLE_SIZE;
}

// Function to insert a symbol into the symbol table
void insert_symbol(char* name, int type) {
    unsigned long h = hash(name);
    symbol* s = malloc(sizeof(symbol));
    s->name = strdup(name);
    s->type = type;
    symbol_table[h] = s;
}

// Function to lookup a symbol in the symbol table
int lookup_symbol(char* name) {
    unsigned long h = hash(name);
    symbol* s = symbol_table[h];
    if (s != NULL && strcmp(s->name, name) == 0) {
        return s->type;
    } else {
        return -1;  // Not found
    }
}

int yylex(void); /* -Wall : avoid implicit call */
int yyerror(const char*); /* same for bison */

%}

%define parse.error custom
%locations

%start program

/* Typage des valeurs de symboles term. ou non-term */
%union {double dval;  int ival; char ch;}
%token <ch>ID
%token IF THEN ELSE ELSEIF ENDIF AO AF
%token FOR WHILE
%token <ival> ENTIER 
%token <dval> REEL
%token COSINUS SINUS TANGANTE LOGARITHME
%token INT FLOAT
%type <dval> expression 
%type <void> instruction
%type <ival>CONDITION

%token INF SUP INFEGAL SUPEGAL DIFF AFFECT DEGAL
%left PLUS MOINS
%left MUL DIVISION
%token PO PF PT_VIRG
%left COSINUS SINUS TANGENTE
%left LOGARITHME
 
%nonassoc MOINSU
%%

program:
    declaration_list instructions
;

declaration_list:
    | declaration_list declaration PT_VIRG
    | declaration PT_VIRG
;

declaration:
    TYPE ID { insert_symbol($2, $1); }
;

TYPE:
    INT { $$ = 0; }
    | FLOAT { $$ = 1; }

instructions:
    | instruction 
    | AO instruction AF
    | AO instructions AF
    | instructions instruction
;


instruction:
    ID AFFECT expression PT_VIRG {
        if (lookup_symbol($1) == -1) {
            fprintf(stderr, "Error: variable 'my_variable' has not been declared\n");
    exit(1);

            printf("Error: Undeclared variable '%s'\n", $1);
            YYERROR;
        }
        else if (lookup_symbol($1) == 0 && $3 != (int)$3) {
            printf("Error: Type mismatch on variable '%s'\n", $1);
            YYERROR;
        }
        else if (lookup_symbol($1) == 1 && $3 == (int)$3) {
            printf("Error: Type mismatch on variable '%s'\n", $1);
            YYERROR;
        }
    }
    | IF PO CONDITION PF THEN instruction ENDIF                   
    | IF PO CONDITION PF THEN instruction ELSE instruction ENDIF
    | block
    | for_loop
    | while_loop

block:
    AO instructions AF
    | AO instruction AF

for_loop:
    FOR PO instruction CONDITION PT_VIRG instruction PF AO instructions AF

while_loop:
    WHILE PO CONDITION PF AO instructions AF


expression:
expression PLUS expression { $$ = $1+$3; }
| expression MOINS expression { $$ = $1-$3; }
| expression MUL expression { $$ = $1*$3; }
| expression DIVISION expression { $$ = $1/$3; }
| PO expression PF { $$ = $2; }
| MOINS expression  %prec MOINSU { $$ = -$2; }
| ENTIER { $$ = $1; }
| REEL { $$ = (float)$1; }
| COSINUS expression { $$=cos($2); }
| SINUS expression { $$=sin($2); }
| TANGENTE expression { $$=tan($2); }
| LOGARITHME expression { $$=log10($2); }
| ID { $$ = $1;}
;


CONDITION :
expression INF expression {$$=0; if($1<$3) $$=1;}
|expression INFEGAL expression {$$=0; if($1<=$3) $$=1;}
|expression SUP expression {$$=0; if($1>$3) $$=1;}
|expression SUPEGAL expression {$$=0; if($1>=$3) $$=1;}
|expression DEGAL expression {$$=0; if($1==$3) $$=1;}
|expression DIFF expression {$$=0; if($1!=$3) $$=1;}
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
