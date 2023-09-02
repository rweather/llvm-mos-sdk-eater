; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 semget:
;   On entry: C=1 for blocking, C=0 for non-blocking
;   On exit: C=0 on success, X is the semaphore number
;            C=1 on error with error code in A
.global k_semget
.section .text.k_semget,"ax",@progbits
k_semget:
  lsr ; Put the blocking flag into C.
  jsr LIB6502+SYS_semget
  bcs .Lsemget_error
  txa
  ldx #0
  rts
.Lsemget_error:
  ldx #$ff
  rts
