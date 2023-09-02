#include <lib6502.h>
#include <chrin.h>

int __chrin(void)
{
  return k_fgetc(K_STDIN, K_BLOCKING);
}
