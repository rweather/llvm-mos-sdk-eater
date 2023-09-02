; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 pipe:
;   On entry: nothing
;   On exit: C=0 on success with file descriptors in X (read) and Y (write)
;            C=1 on error with error code in A
.global k_pipe
.section .text.k_pipe,"ax",@progbits
k_pipe:
  jsr LIB6502+SYS_pipe
  bcs .Lpipe_error
  tya
  ldy #2
  sta (__rc2),y
  ldy #0
  txa
  sta (__rc2),y
  lda #0
  iny
  sta (__rc2),y
  ldy #3
  sta (__rc2),y
  tax
  rts
.Lpipe_error:
  ldx #$ff
  rts
