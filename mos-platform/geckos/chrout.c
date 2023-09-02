#include <lib6502.h>
#include <chrout.h>

void __chrout(char c)
{
  k_fputc(K_STDIN, c, K_BLOCKING);
}
