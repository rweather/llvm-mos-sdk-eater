/* Copyright (c) 2023 Rhys Weatherley
 *
 * Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
 * See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
 * information.
 */

#include <string.h>

extern int main(int argc, char **argv);

/*
 * On entry from GeckOS/A65, "args" points to an array of argv values,
 * separated by NUL's, and terminated with a final NUL.
 *
 * This function builds a traditional argv array and calls the actual main.
 */
int _main(char *args)
{
  /* Count the arguments */
  char *ptr = args;
  int argc = 0;
  while (*ptr != '\0') {
      ptr = strchr(ptr, '\0') + 1;
      ++argc;
  }

  /* Build the argv array on the stack */
  char *argv[argc + 1];
  ptr = args;
  argc = 0;
  while (*ptr != '\0') {
      argv[argc++] = ptr;
      ptr = strchr(ptr, '\0') + 1;
  }
  argv[argc] = 0; /* Terminate with a NULL */

  /* Call the actual main function */
  return main(argc, argv);
}
