; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 listen in open mode:
;   On entry: A/Y points to port information, X is the protocol number, C=0
;   On exit: C=0 on success with fd in X
;            C=1 on error with error code in A
.global k_listen_open
.section .text.k_listen_open,"ax",@progbits
k_listen_open:
  tax
  lda __rc2
  ldy __rc3
  clc ; open mode
  jsr LIB6502+SYS_listen
  bcs .Llisten_open_error
  txa
  ldx #0
  rts
.Llisten_open_error:
  ldx #$ff
  rts

; lib6502 listen in close mode:
;   On entry: X is the listen fd, C=1
;   On exit: C=0 on success
;            C=1 on error with error code in A
.global k_listen_close
.section .text.k_listen_close,"ax",@progbits
k_listen_close:
  tax
  sec ; close mode
  jsr LIB6502+SYS_listen
  bcs .Llisten_close_error
  lda #0
  tax
  rts
.Llisten_close_error:
  ldx #$ff
  rts
