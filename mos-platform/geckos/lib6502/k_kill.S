; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 kill:
;   On entry: A is the exit status, X/Y is the pid
;   On exit: C=0 on success
;            C=1 on error with error code in A
.global k_kill
.section .text.k_kill,"ax",@progbits
k_kill:
  stx __rc4 ; Transfer A/X to X/Y.
  ldy __rc4
  tax
  lda __rc2 ; Get the exit status.
  jsr LIB6502+SYS_kill
  bcs .Lkill_error
  lda #0
  tax
  rts
.Lkill_error:
  ldx #$ff
  rts
