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
TABLE        { return TABLE; }
WHERE        { return WHERE; }
SET          { return SET; }
FROM         { return FROM; }
INTO         { return INTO; }
VALUES       { return VALUES; }
ANY          { return ANY; }
SOME         { return SOME; }
ALL          { return ALL; }
AS           { return AS;}
ON          { return ON; }
USING       { return USING; }
INNER       { return INNER; }
CROSS       { return CROSS; }
NATURAL     { return NATURAL; }
GROUP       { return GROUP; }
BY          { return BY; }
ASC         { return ASC; }
DESC        { return DESC; }
ORDER       { return ORDER; }
\=          { return EQUAL; }
\,          { return COMMA; }
\;          { return PV; }
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
