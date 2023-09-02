#include <lib6502.h>
#include <chrin.h>

int __chrin_no_wait(void)
{
  return k_fgetc(K_STDIN, K_NONBLOCKING);
}
