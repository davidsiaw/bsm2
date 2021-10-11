#ifndef ERROR_H
#define ERROR_H

class UnknownCharacterError
{
  int colno;
public:
  UnknownCharacterError(int colno) :
    colno(colno)
  { }

  const int column() const
  {
    return colno;
  }
};

#endif // ERROR_H
