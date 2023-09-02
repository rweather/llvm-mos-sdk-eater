; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 getenv:
;   On entry: A/Y is the name of the environment variable
;   On exit: A/Y is the value of the environment variable, or NULL
.global k_getenv
.section .text.k_getenv,"ax",@progbits
k_getenv:
  lda __rc2
  ldy __rc3
  jsr LIB6502+SYS_getenv
  sta __rc2
  sty __rc3
  rts
