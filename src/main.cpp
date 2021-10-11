#include <iostream>
#include <memory>
#include "FlexLexer.h"
#include <sstream>
#include "error.h"

class Processor
{
  uint curline;

public:
  Processor() : curline(0)
  {

  }

  ~Processor()
  {

  }

  std::string process(const std::string& input)
  {
    curline++;

    if (input.length() == 0 || input[0] != ';')
    {
      return ""; 
    }

    std::istringstream input_stream(input);
    std::ostringstream output_stream;

    input_stream.get();
    std::unique_ptr<FlexLexer> parser = std::make_unique<yyFlexLexer>(input_stream, output_stream);

    uint curchar = 0;
    try
    {
      // std::cout << "A" << std::endl;
      for(curchar = 0; curchar < input.length(); curchar++)
      {
        if (parser->yylex() != 0)
        {
          break;
        }
      }  
    }
    catch (UnknownCharacterError e)
    {
      error(e, input);
    }
    
    return output_stream.str();
  }

private:
  void error(const UnknownCharacterError& e, const std::string& input)
  {
    std::cerr << "BSM: Error at line " << curline << " and column " << e.column() << std::endl << "---" << std::endl;
    std::cerr << input << std::endl;

    for (int i = 0; i < e.column(); i++)
    {
      std::cerr << " "; 
    }

    std::cerr << "^~here" << std::endl;

    exit(EXIT_FAILURE);
  }
};

int main()
{
  std::unique_ptr<Processor> p = std::make_unique<Processor>();
  while(std::cin)
  {
    std::string input_line;
    std::getline(std::cin, input_line);
    std::cout << p->process(input_line);
  }
  return EXIT_SUCCESS;
}
