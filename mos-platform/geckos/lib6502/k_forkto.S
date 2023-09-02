; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 forkto:
;   On entry: A/Y is the pointer to the fork control block
;   On exit: C=0 on success, pid in X/Y
;            C=1 on error with error code in A
.global k_forkto
.section .text.k_forkto,"ax",@progbits
k_forkto:
  lda __rc2
  ldy __rc3
  jsr LIB6502+SYS_forkto
  bcs .Lforkto_error
  txa       ; Transfer X/Y to A/X.
  sty __rc4
  ldx __rc4
  rts
.Lforkto_error:
  ldx #$ff
  rts
