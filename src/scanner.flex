%{
#include "converter.h"
#include "error.h"
%}

HEXCHAR         [A-Fa-f0-9]
WHITESPACE      [ \r\n\t]+
QUOTE           [']
QUOTABLECHAR    [A-Za-z0-9]

%%

{WHITESPACE}                   /* skip blanks and tabs */

{HEXCHAR}{HEXCHAR}             std::cout << Converter().convert_hexpair(YYText());

{QUOTE}{QUOTABLECHAR}{QUOTE}   std::cout << Converter().convert_quotechar(YYText());

. throw UnknownCharacterError();

%%

int yyFlexLexer::yywrap() { return 1; }
