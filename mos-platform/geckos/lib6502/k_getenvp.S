; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 getenvp:
;   On entry: Nothing
;   On exit: A/Y points to the environment variable list
.global k_getenvp
.section .text.k_getenvp,"ax",@progbits
k_getenvp:
  jsr LIB6502+SYS_getenvp
  sta __rc2
  sty __rc3
  rts
