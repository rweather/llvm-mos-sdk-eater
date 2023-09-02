; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 exec:
;   On entry: A/Y is the pointer to the command-line arguments
;   On exit: C=0 on success
;            C=1 on error with error code in A
.global k_exec
.section .text.k_exec,"ax",@progbits
k_exec:
  lda __rc2
  ldy __rc3
  jsr LIB6502+SYS_exec
  bcs .Lexec_error
  lda #0
  tax
  rts
.Lexec_error:
  ldx #$ff
  rts
