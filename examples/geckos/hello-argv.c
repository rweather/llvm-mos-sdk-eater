#include <stdio.h>

int main(int argc, char *argv[]) {
  int arg;
  putchar('0' + argc);
  putchar('\n');
  for (arg = 0; arg < argc; ++arg)
      puts(argv[arg]);
  return 0;
}
