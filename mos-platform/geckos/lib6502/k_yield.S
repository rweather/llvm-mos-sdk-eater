; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 yield:
;   On entry: Nothing
;   On exit: Nothing
.global k_yield
.section .text.k_yield,"ax",@progbits
k_yield:
  jmp LIB6502+SYS_yield
