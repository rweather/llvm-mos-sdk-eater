; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 getpid:
;   On entry: Nothing
;   On exit: Process identifier in X/Y
.global k_getpid
.section .text.k_getpid,"ax",@progbits
k_getpid:
  jsr LIB6502+SYS_getpid
  txa       ; Transfer X/Y to A/X.
  sty __rc4
  ldx __rc4
  rts
