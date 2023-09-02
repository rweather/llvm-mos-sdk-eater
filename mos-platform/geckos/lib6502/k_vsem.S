; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 vsem:
;   On entry: X is the semaphore number
;   On exit: C=0 on success
;            C=1 on error with error code in A
.global k_vsem
.section .text.k_vsem,"ax",@progbits
k_vsem:
  tax
  jsr LIB6502+SYS_vsem
  bcs .Lvsem_error
  lda #0
  tax
  rts
.Lvsem_error:
  ldx #$ff
  rts
