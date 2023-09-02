/* Copyright (c) 2023 Rhys Weatherley
 *
 * Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
 * See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
 * information.
 */

#include <lib6502.h>

/* lib6502 is passed a structure containing the address and length */
struct k_fwrite_s
{
  const void *data;
  size_t len;
};

__attribute__((leaf)) int _k_fwrite(struct k_fwrite_s *s, uint8_t fd, uint8_t blocking);

int k_fwrite(int fd, const void *data, size_t len, uint8_t blocking)
{
  struct k_fwrite_s s;
  s.data = data;
  s.len = len;
  return _k_fwrite(&s, fd, blocking);
}
