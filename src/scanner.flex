%{
#include "error.h"
#include <string>

%}

HEXCHAR         [A-Fa-f0-9]
WHITESPACE      [ \r\n\t]+
QUOTE           [']
QUOTABLECHAR    [A-Za-z0-9]

%%

{WHITESPACE}                   /* skip blanks and tabs */

{HEXCHAR}{HEXCHAR}             std::cout << static_cast<char>(stoi(std::string(YYText()), nullptr, 16));

{QUOTE}{QUOTABLECHAR}{QUOTE}   std::cout << YYText()[1];

. throw UnknownCharacterError();

%%

int yyFlexLexer::yywrap() { return 1; }
