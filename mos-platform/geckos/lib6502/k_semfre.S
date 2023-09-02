; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 semfre:
;   On entry: X is the semaphore number
;   On exit: C=0 on success
;            C=1 on error with error code in A
.global k_semfre
.section .text.k_semfre,"ax",@progbits
k_semfre:
  tax
  jsr LIB6502+SYS_semfre
  bcs .Lsemfre_error
  lda #0
  tax
  rts
.Lsemfre_error:
  ldx #$ff
  rts
