#ifndef ERROR_H
#define ERROR_H

class UnknownCharacterError
{
  int colno;
  int len;

public:
  UnknownCharacterError(int colno, int length) :
    colno(colno),
    len(length)
  { }

  const int column() const
  {
    return colno;
  }

  const int length() const
  {
    return len;
  }
};

#endif // ERROR_H
