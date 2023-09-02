; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 forkthread:
;   On entry: A/Y is the pointer to the start function for the new thread
;   On exit: C=0 on success, thread number in X
;            C=1 on error with error code in A
.global k_forkthread
.section .text.k_forkthread,"ax",@progbits
k_forkthread:
  lda __rc2
  ldy __rc3
  jsr LIB6502+SYS_forkthread
  bcs .Lforkthread_error
  txa
  ldx #0
  rts
.Lforkthread_error:
  ldx #$ff
  rts
