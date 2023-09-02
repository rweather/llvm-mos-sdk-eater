; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 dup:
;   On entry: X is the old fd
;   On exit: C=0 on success, X is the new fd
;            C=1 on error with error code in A
.global k_dup
.section .text.k_dup,"ax",@progbits
k_dup:
  tax
  jsr LIB6502+SYS_dup
  bcs .Ldup_error
  txa
  ldx #0
  rts
.Ldup_error:
  ldx #$ff
  rts
