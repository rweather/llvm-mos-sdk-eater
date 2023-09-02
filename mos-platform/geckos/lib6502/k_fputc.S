; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 fputc:
;   On entry: X is the file descriptor, A is the byte to put,
;             C=1 for blocking, C=0 for non-blocking.
;   On exit: C=0 on success
;            C=1 on error with error code in A
.global k_fputc
.section .text.k_fputc,"ax",@progbits
k_fputc:
  tax
  lda __rc2
  lsr __rc3 ; carry flag selects blocking (1) or non-blocking mode (0).
  jsr LIB6502+SYS_fputc
  bcs .Lfputc_error
  lda #0
  tax
  rts
.Lfputc_error:
  ldx #$ff
  rts
