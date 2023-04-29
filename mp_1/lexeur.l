%{
#include <stdio.h> /* printf */
#include "parseur.tab.h" /* token constants def. in parseur.y via #define */
#include <stdlib.h>
%}
%option yylineno

lettre [A-Za-z]
chiffre [0-9]
reel [0-9]+\.[0-9]* | [0-9]*\.[0-9] 
COSINUS     "cos"{reel}
SINUS       "sin"{reel}
TANGANTE    "tan"{reel}
LOGARITHME  "log"{reel}
%%
[0-9]+   {printf("lex::ENTIER %s\n",yytext); yylval.ival=atoi(yytext); return ENTIER; }
[0-9]+\.[0-9]* |
[0-9]*\.[0-9]   {printf("lex::REEL %s\n",yytext); yylval.dval=atof(yytext); return REEL; }
\;         {printf("lex::PT_VIRG %s\n",yytext); return PT_VIRG;  }
\+         {printf("lex::PLUS %s\n",yytext); return PLUS;  }
\-         {printf("lex::MOINS %s\n",yytext); return MOINS;  }
\*         {printf("lex::MUL %s\n",yytext); return MUL;  }
\/         {printf("lex::DIVISION %s\n",yytext); return DIVISION;  }
\(         {printf("lex::PO %s\n",yytext); return PO;  }
\)         {printf("lex::PF %s\n",yytext); return PF;  }
\{         {printf("lex::AO %s\n",yytext); return AO;  }
\}         {printf("lex::Af %s\n",yytext); return AF;  }
[ \t\n] { ; } /* ignore space, tab, and line return */
"if"       {printf("lex::IF) %s\n",yytext);return IF; }
"then"       {printf("lex::THEN) %s\n",yytext);return THEN; }
"endif"       {printf("lex::ENDIF) %s\n",yytext);return ENDIF; }
"else"   {printf("lex::ELSE) %s\n",yytext);return ELSE; }
"elseif"     {printf("lex::ELSEIF) %s\n",yytext);return ELSEIF; }
"for"     {printf("lex::FOR) %s\n",yytext);return FOR; }
"while"     {printf("lex::WHILE) %s\n",yytext);return WHILE; }
"cos"        {printf("lex::cosinus %s\n",yytext); return COSINUS; }
"sin"        {printf("lex::sinus %s\n",yytext); return SINUS; }
"tan"        {printf("lex::tangente %s\n",yytext); return TANGANTE; }
"log"        {printf("lex::logarithme %s\n",yytext); return LOGARITHME; }
"int"     {printf("lex::INT) %s\n",yytext);return INT; }
"float"     {printf("lex::FLOAT) %s\n",yytext);return FLOAT; }

{lettre}({lettre}|{chiffre})* {printf("lex::ID= %s\n" ,yytext); yylval.ch=yytext; return ID;}
"<"          {printf("lex::INF %s\n",yytext);return INF; }
">"          {printf("lex::SUP %s\n",yytext);return SUP; }
"<="       {printf("lex::INFEGAL %s\n",yytext);return INFEGAL; }
">="         {printf("lex::SUPEGAL %s\n",yytext);return SUPEGAL; }
"!="         {printf("lex::DIFF) %s\n",yytext);return DIFF; }
"="          {printf("lex::AFFECT) %s\n",yytext);return AFFECT; }
"=="         {printf("lex::DEGAL) %s\n",yytext);return DEGAL; }
.   { printf("lex::char %s\n",yytext); return yytext[0]; }

%%
