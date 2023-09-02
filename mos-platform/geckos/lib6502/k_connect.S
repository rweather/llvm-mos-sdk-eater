; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 connect:
;   On entry: A/Y points to the socket address, X is the protocol number
;   On exit: C=0 on success with fd in X
;            C=1 on error with error code in A
.global k_connect
.section .text.k_connect,"ax",@progbits
k_connect:
  tax
  lda __rc2
  ldy __rc3
  jsr LIB6502+SYS_connect
  bcs .Lconnect_error
  txa
  ldx #0
  rts
.Lconnect_error:
  ldx #$ff
  rts
