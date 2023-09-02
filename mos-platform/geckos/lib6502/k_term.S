; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 term:
;   On entry: A is the exit status for the thread
;   On exit: Never exits
.global k_term
.section .text.k_term,"ax",@progbits
k_term:
  jmp LIB6502+SYS_term
