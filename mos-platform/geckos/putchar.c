#include <chrout.h>

void __putchar(char c)
{
  if (c == '\n')
    __chrout('\r');
  __chrout(c);
}
