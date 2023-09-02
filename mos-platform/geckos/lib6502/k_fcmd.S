; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 fcmd:
;   On entry: A/Y points to the filename, X is the operation
;   On exit: C=0 on success
;            C=1 on error with error code in A
.global k_fcmd
.section .text.k_fcmd,"ax",@progbits
k_fcmd:
  tax
  lda __rc2
  ldy __rc3
  jsr LIB6502+SYS_fcmd
  bcs .Lfcmd_error
  lda #0
  tax
  rts
.Lfcmd_error:
  ldx #$ff
  rts
