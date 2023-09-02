; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 cwd:
;   On entry: A/Y points to the buffer to return the current directory,
;             X is the length of the buffer
;   On exit: C=0 on success
;            C=1 on error with error code in A
.global k_cwd
.section .text.k_cwd,"ax",@progbits
k_cwd:
  tax
  lda __rc2
  ldy __rc3
  jsr LIB6502+SYS_cwd
  bcs .Lcwd_error
  lda #0
  tax
  rts
.Lcwd_error:
  ldx #$ff
  rts
