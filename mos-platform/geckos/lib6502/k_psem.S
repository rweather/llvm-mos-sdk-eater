; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 psem:
;   On entry: X is the semaphore number, C=1 for blocking, C=0 for non-blocking.
;   On exit: C=0 on success
;            C=1 on error with error code in A
.global k_psem
.section .text.k_psem,"ax",@progbits
k_psem:
  tax
  lsr __rc2 ; carry flag selects blocking (1) or non-blocking mode (0).
  jsr LIB6502+SYS_psem
  bcs .Lpsem_error
  lda #0
  tax
  rts
.Lpsem_error:
  ldx #$ff
  rts
