%option case-insensitive

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sql.tab.h"
%}

%%

SELECT       { return SELECT; }
UPDATE       { return UPDATE; }
DELETE       { return DELETE; }
INSERT       { return INSERT; }
JOIN         { return JOIN; }
ON           { return ON; }
TABLE        { return TABLE; }
WHERE        { return WHERE; }
SET          { return SET; }
FROM         { return FROM; }
INTO         { return INTO; }
VALUES       { return VALUES; }
\=          { return EQUAL; }
\,          { return COMMA; }
\;          {return PV;}
\(          { return OP; }
\)          { return CP; }
\<          { return LT; }
\>          { return GT; }
\+          { return PLUS; }
\-          { return MINUS; }
\*          { return MULTIPLY; }
\\          { return DIVISION; }
[A-Za-z][A-Za-z0-9_]*         { yylval.string_val = strdup(yytext); return NAME; }
[0-9]+       { yylval.num_val = atof(yytext); return VALUE; }
[0-9]+\.[0-9]+       { yylval.num_val = atof(yytext); return VALUE; }
[ \t\n]+     { /* ignore whitespace */ }
\\.          { return '\\'; }

%%
