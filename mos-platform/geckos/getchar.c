#include <chrin.h>

__attribute__((noinline)) int getchar(void)
{
  int c = __chrin();
  if (c < 0)
    return -1;
  else if (c == '\r')
    return '\n';
  else
    return c;
}
