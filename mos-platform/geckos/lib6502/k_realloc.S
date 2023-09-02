; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 realloc:
;   On entry: A/Y is the address to be reallocated, X points at a zero page
;             location that contains the new length.
;   On exit: C=0 on success
;            C=1 on error with error code in A
.global k_realloc
.section .text.k_realloc,"ax",@progbits
k_realloc:
  sta __rc4
  stx __rc5
  lda __rc2
  ldy __rc3
  ldx #__rc4 ; Length is in zero page at rc4:rc5.
  jsr LIB6502+SYS_realloc
  bcs .Lrealloc_error
  sta __rc2 ; Transfer A/Y to RC2/RC3.
  sty __rc3
  rts
.Lrealloc_error:
  lda #0 ; Return NULL to the caller.
  sta __rc2
  sta __rc3
  rts
