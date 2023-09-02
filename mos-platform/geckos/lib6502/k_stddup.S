; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 stddup:
;   On entry: X is the old fd, Y is the new fd
;   On exit: C=0 on success, X is the old fd
;            C=1 on error with error code in A
.global k_stddup
.section .text.k_stddup,"ax",@progbits
k_stddup:
  tax
  ldy __rc2
  jsr LIB6502+SYS_stddup
  bcs .Lstddup_error
  txa
  ldx #0
  rts
.Lstddup_error:
  ldx #$ff
  rts
