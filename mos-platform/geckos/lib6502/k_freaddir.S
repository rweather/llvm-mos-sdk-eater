; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 freaddir:
;   On entry: X is the fd, A/Y points to the directory entry buffer
;   On exit: C=0 on success
;            C=1 on error with error code in A
.global k_freaddir
.section .text.k_freaddir,"ax",@progbits
k_freaddir:
  tax
  lda __rc2
  ldy __rc3
  jsr LIB6502+SYS_freaddir
  bcs .Lfreaddir_error
  lda #0
  tax
  rts
.Lfreaddir_error:
  ldx #$ff
  rts
