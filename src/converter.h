#ifndef CONVERTER_H
#define CONVERTER_H

#include <iostream>
#include <string>
#include <sstream>

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

  std::string convert_doublequote(const std::string& yytext)
  {
    std::stringstream result;
    for (uint i = 1; i < yytext.length() - 1; i++)
    {
      result << yytext[i];
    }

    return result.str();
  }

  unsigned char convert_bindigits(const std::string& yytext)
  {
    unsigned char c = 0;
    for (uint i = 1; i < yytext.length() - 1; i++)
    {
      if (yytext[i] == '1')
      {
        c += 1 << (8-i);
      }
    }

    return c;
  }
};

#endif // CONVERTER_H
