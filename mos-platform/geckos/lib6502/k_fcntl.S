; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 fcntl:
;   On entry: X is the file descriptor, A is the operation
;   On exit: C=0 on success
;            C=1 on error with error code in A
.global k_fcntl
.section .text.k_fcntl,"ax",@progbits
k_fcntl:
  tax
  lda __rc2
  jsr LIB6502+SYS_fcntl
  bcs .Lfcntl_error
  lda #0
  tax
  rts
.Lfcntl_error:
  ldx #$ff
  rts
