%{
#include "converter.h"
#include "error.h"

/* Save the position for error messages */
#define YY_USER_ACTION                                                   \
  start_column = yycolumn;                                               \
  length = yyleng;                                                       \
  yycolumn += yyleng;

%}

HEXCHAR         [[:xdigit:]]
WHITESPACE      [ \r\n\t]+
DOUBLEQUOTE     ["]
QUOTE           [']
QUOTABLECHAR    [[:print:]]
STRINGCHAR      [^\x00-\x1F\x22\x7f-\xff]
BINDIGIT        [01\.]

%%
  int yycolumn = 1, length = 0;
  int start_column;

{WHITESPACE}                             /* skip blanks and tabs */

{HEXCHAR}{HEXCHAR}                       std::cout << Converter().convert_hexpair(YYText());

{QUOTE}{QUOTABLECHAR}{QUOTE}             std::cout << Converter().convert_quotechar(YYText());

{DOUBLEQUOTE}{STRINGCHAR}+{DOUBLEQUOTE}  std::cout << Converter().convert_doublequote(YYText());

[<]{BINDIGIT}{8}[>]                      std::cout << Converter().convert_bindigits(YYText());

. throw UnknownCharacterError(start_column, length);

%%

int yyFlexLexer::yywrap() {
  return 1;
}
