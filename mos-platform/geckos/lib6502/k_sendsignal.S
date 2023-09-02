; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 sendsignal:
;   On entry: X is the signal number, A/Y is the process identifier
;   On exit: C=0 on success
;            C=1 on error with error code in A
.global k_sendsignal
.section .text.k_sendsignal,"ax",@progbits
k_sendsignal:
  stx __rc4
  ldy __rc4
  ldx __rc2
  jsr LIB6502+SYS_sendsignal
  bcs .Lsendsignal_error
  lda #0
  tax
  rts
.Lsendsignal_error:
  ldx #$ff
  rts
