; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 fread:
;   On entry: X is the file descriptor, A/Y points at the control structure,
;             C=1 for blocking, C=0 for non-blocking
;   On exit: C=0 on success with length read in A/Y
;            C=1 on error with error code in A
.global _k_fread
.section .text._k_fread,"ax",@progbits
_k_fread:
  stx __rc4
  tax
  lda __rc2
  ldy __rc3
  lsr __rc4 ; carry flag selects blocking (1) or non-blocking mode (0).
  jsr LIB6502+SYS_fread
  bcs .Lfread_error
  sty __rc4 ; transfer A/Y to A/X
  ldx __rc4
  rts
.Lfread_error:
  ldx #$ff
  rts
