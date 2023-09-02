; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

#include "syscalls.inc"

; lib6502 signal
;   On entry: A/Y points to the signal handler and X is the signal number
;   On exit: C=0 on success
;            C=1 on error with error code in A
; In our case, k_signal only takes the signal number as an argument and
; we deal with the signal handler internally.
.global k_signal
.section .text.k_signal,"ax",@progbits
k_signal:
  tax
  lda #mos16lo(_k_signal_catcher)
  ldy #mos16hi(_k_signal_catcher)
  jsr LIB6502+SYS_signal
  bcs .Lsignal_error
  lda #0
  tax
  rts
.Lsignal_error:
  ldx #$ff
  rts

; Remove the handler for a signal.
;   On entry: A/Y is NULL X is the signal number
;   On exit: C=0 on success
;            C=1 on error with error code in A
.global k_signal_remove
.section .text.k_signal_remove,"ax",@progbits
k_signal_remove:
  tax
  lda #0
  tay
  jsr LIB6502+SYS_signal
  bcs .Lsignal_remove_error
  lda #0
  tax
  rts
.Lsignal_remove_error:
  ldx #$ff
  rts

; Signal catcher that we register with lib6502.  We simulate an interrupt
; context and jump to k_signal_handler.  The signal mask is in A.
.global _k_signal_catcher
.section .text._k_signal_catcher,"ax",@progbits
_k_signal_catcher:
  php
  ldx #0 ; Clear the high byte of the signal mask.
  jmp k_signal_handler

; Default signal handler if the application doesn't have one.
.global _k_no_signal_handler
.section .text._k_no_signal_handler,"ax",@progbits
_k_no_signal_handler:
  rti
