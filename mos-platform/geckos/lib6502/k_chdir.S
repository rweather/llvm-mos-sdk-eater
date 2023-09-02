; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 chdir:
;   On entry: A/Y points to the directory pathname
;   On exit: C=0 on success
;            C=1 on error with error code in A
.global k_chdir
.section .text.k_chdir,"ax",@progbits
k_chdir:
  lda __rc2
  ldy __rc3
  jsr LIB6502+SYS_chdir
  bcs .Lchdir_error
  lda #0
  tax
  rts
.Lchdir_error:
  ldx #$ff
  rts
