Here's the modified code without the print statements:

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
[0-9]+   {yylval.ival=atoi(yytext); return ENTIER; }
[0-9]+\.[0-9]* |
[0-9]*\.[0-9]   {yylval.dval=atof(yytext); return REEL; }
\;         {return PT_VIRG;  }
\+         {return PLUS;  }
\-         {return MOINS;  }
\*         {return MUL;  }
\/         {return DIVISION;  }
\(         {return PO;  }
\)         {return PF;  }
\{         {return AO;  }
\}         {return AF;  }
[ \t\n] { ; } /* ignore space, tab, and line return */
"if"       {return IF; }
"then"       {return THEN; }
"endif"       {return ENDIF; }
"else"   {return ELSE; }
"elseif"     {return ELSEIF; }
"for"     {return FOR; }
"while"     {return WHILE; }
"cos"        {return COSINUS; }
"sin"        {return SINUS; }
"tan"        {return TANGANTE; }
"log"        {return LOGARITHME; }
"int"     {return INT; }
"float"     {return FLOAT; }

{lettre}({lettre}|{chiffre})* {yylval.ch=strdup(yytext); return ID;}
"<"          {return INF; }
">"          {return SUP; }
"<="       {return INFEGAL; }
">="         {return SUPEGAL; }
"!="         {return DIFF; }
"="          {return AFFECT; }
"=="         {return DEGAL; }
.   { return yytext[0]; }

%%