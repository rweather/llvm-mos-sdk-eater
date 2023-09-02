; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 fopendir:
;   On entry: A/Y points to the directory pathname
;   On exit: C=0 on success with fd in X
;            C=1 on error with error code in A
.global k_fopendir
.section .text.k_fopendir,"ax",@progbits
k_fopendir:
  lda __rc2
  ldy __rc3
  jsr LIB6502+SYS_fopendir
  bcs .Lfopendir_error
  txa
  ldx #0
  rts
.Lfopendir_error:
  ldx #$ff
  rts
