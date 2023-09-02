; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 accept:
;   On entry: A/Y points to the socket address, X is the listen fd,
;             C=1 for blocking, C=0 for non-blocking
;   On exit: C=0 on success with fd in X
;            C=1 on error with error code in A
.global k_accept
.section .text.k_accept,"ax",@progbits
k_accept:
  stx __rc4
  tax
  lda __rc2
  ldy __rc3
  lsr __rc4 ; carry flag selects blocking (1) or non-blocking mode (0).
  jsr LIB6502+SYS_accept
  bcs .Laccept_error
  txa
  ldx #0
  rts
.Laccept_error:
  ldx #$ff
  rts
