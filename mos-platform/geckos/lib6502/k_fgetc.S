; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 fgetc:
;   On entry: X is the file descriptor, C=1 for blocking, C=0 for non-blocking
;   On exit: C=0 on success with byte in A
;            C=1 on error with error code in A
.global k_fgetc
.section .text.k_fgetc,"ax",@progbits
k_fgetc:
  tax
  lsr __rc2 ; carry flag selects blocking (1) or non-blocking mode (0).
  jsr LIB6502+SYS_fgetc
  bcs .Lfgetc_error
  txa
  ldx #0
  rts
.Lfgetc_error:
  ldx #$ff
  rts
