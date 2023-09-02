; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 getos:
;   On entry: Nothing
;   On exit: A/Y points to the operating system string
.global k_getos
.section .text.k_getos,"ax",@progbits
k_getos:
  jsr LIB6502+SYS_getos
  sta __rc2
  sty __rc3
  rts
