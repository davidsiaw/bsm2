%{
#include "error.h"
#include <string>

%}

HEXCHAR         [a-f0-9]
WHITESPACE      [ \r\n\t]+

%%

{WHITESPACE}    /* skip blanks and tabs */

{HEXCHAR}{HEXCHAR}  std::cout << static_cast<char>(stoi(std::string(YYText()), nullptr, 16));

. throw UnknownCharacterError();

%%

int yyFlexLexer::yywrap() { return 1; }
