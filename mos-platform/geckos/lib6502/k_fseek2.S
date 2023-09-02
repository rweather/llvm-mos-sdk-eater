; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 fseek:
;   On entry: X is the file descriptor, A/Y points at the control structure
;   On exit: C=0 on success
;            C=1 on error with error code in A
.global _k_fseek
.section .text._k_fseek,"ax",@progbits
_k_fseek:
  stx __rc4 ; transfer A/X to A/Y
  ldy __rc4
  ldx __rc2 ; transfer the file descriptor to X
  jsr LIB6502+SYS_fseek
  bcs .Lfseek_error
  lda #0
  tax
  rts
.Lfseek_error:
  ldx #$ff
  rts
