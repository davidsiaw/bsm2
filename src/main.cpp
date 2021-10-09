#include <iostream>
#include <memory>
#include "FlexLexer.h"
#include <sstream>
#include "error.h"

class Processor
{
public:
  Processor()
  {

  }

  ~Processor()
  {

  }

  std::string process(const std::string& input)
  {
    if (input.length() == 0 || input[0] != ';')
    {
      return ""; 
    }

    std::istringstream input_stream(input);
    std::ostringstream output_stream;

    input_stream.get();
    std::unique_ptr<FlexLexer> parser = std::make_unique<yyFlexLexer>(input_stream, output_stream);

    try
    {
      // std::cout << "A" << std::endl;
      for(uint i = 0; i < input.length() && parser->yylex() != 0; i++) { }  
    }
    catch (UnknownCharacterError e)
    {
      error(e);
    }
    
    return output_stream.str();
  }

private:
  void error(const UnknownCharacterError& e)
  {
    std::cerr << "Stahp!" << std::endl;
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
