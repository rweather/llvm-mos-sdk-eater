; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 free:
;   On entry: A/Y is the pointer to be freed
;   On exit: C=0 on success
;            C=1 on error with error code in A
.global k_free
.section .text.k_free,"ax",@progbits
k_free:
  lda __rc2
  ldy __rc3
  jsr LIB6502+SYS_mfree
  bcs .Lfree_error
  lda #0
  tax
  rts
.Lfree_error:
  ldx #$ff
  rts
