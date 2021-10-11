%{
#include "converter.h"
#include "error.h"

/* Save the position for error messages */
#define YY_USER_ACTION                                                   \
  start_column = yycolumn;                                               \
  yycolumn += yyleng;

%}

HEXCHAR         [A-Fa-f0-9]
WHITESPACE      [ \r\n\t]+
QUOTE           [']
QUOTABLECHAR    [A-Za-z0-9]

%%
  int yycolumn = 1;
  int start_column;

{WHITESPACE}                   /* skip blanks and tabs */

{HEXCHAR}{HEXCHAR}             std::cout << Converter().convert_hexpair(YYText());

{QUOTE}{QUOTABLECHAR}{QUOTE}   std::cout << Converter().convert_quotechar(YYText());

. throw UnknownCharacterError(start_column);

%%

int yyFlexLexer::yywrap() {
  return 1;
}
