; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 fclose:
;   On entry: X is the file descriptor
;   On exit: C=0 on success
;            C=1 on error with error code in A
.global k_fclose
.section .text.k_fclose,"ax",@progbits
k_fclose:
  tax
  jsr LIB6502+SYS_fclose
  bcs .Lfclose_error
  lda #0
  tax
  rts
.Lfclose_error:
  ldx #$ff
  rts
