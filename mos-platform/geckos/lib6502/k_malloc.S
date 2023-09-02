; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 malloc:
;   On entry: A/Y is the allocation length
;   On exit: C=0 on success, with address in A/Y
;            C=1 on error with error code in A
.global k_malloc
.section .text.k_malloc,"ax",@progbits
k_malloc:
  stx __rc4 ; Transfer A/X to A/Y.
  ldy __rc4
  jsr LIB6502+SYS_malloc
  bcs .Lmalloc_error
  sta __rc2 ; Transfer A/Y to RC2/RC3.
  sty __rc3
  rts
.Lmalloc_error:
  lda #0 ; Return NULL to the caller.
  sta __rc2
  sta __rc3
  rts
