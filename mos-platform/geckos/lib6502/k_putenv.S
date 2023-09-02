; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 putenv:
;   On entry: A/Y is the pointer to the "name=value" string.
;   On exit: C=0 on success
;            C=1 on error with error code in A
.global k_putenv
.section .text.k_putenv,"ax",@progbits
k_putenv:
  lda __rc2
  ldy __rc3
  jsr LIB6502+SYS_putenv
  bcs .Lputenv_error
  lda #0
  tax
  rts
.Lputenv_error:
  ldx #$ff
  rts
