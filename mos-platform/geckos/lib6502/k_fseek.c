/* Copyright (c) 2023 Rhys Weatherley
 *
 * Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
 * See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
 * information.
 */

#include <lib6502.h>

/* lib6502 is passed a structure containing whence and offset */
struct k_fseek_s
{
  uint8_t whence;
  int32_t offset;
} __attribute__((packed));

__attribute__((leaf)) int _k_fseek(struct k_fseek_s *s, uint8_t fd);

int k_fseek(int fd, int32_t offset, uint8_t whence)
{
  struct k_fseek_s s;
  s.whence = whence;
  s.offset = offset;
  return _k_fseek(&s, fd);
}
