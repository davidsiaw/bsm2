#ifndef CONVERTER_H
#define CONVERTER_H

#include <string>

class Converter
{
public:
  Converter() {}
  ~Converter() {}

  char convert_hexpair(const std::string& yytext)
  {
    int chr = stoi(std::string(yytext), nullptr, 16);
    return static_cast<char>(chr);
  }

  char convert_quotechar(const std::string& yytext)
  {
    return yytext[1];
  }
};

#endif // CONVERTER_H
