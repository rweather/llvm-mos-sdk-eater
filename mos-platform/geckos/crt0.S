; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

; On entry from GeckOS/A65, A/Y points to a list of "argv" strings,
; separated by NUL's, and terminated with a final NUL.
;
; We need to save this pointer very early in the startup sequence,
; until it is time to call "_main".  A and Y may be overwritten
; by the initialization code in the meantime.
.global __lib6502_entry_point
.section .init.10,"axR",@progbits
__lib6502_entry_point:
  sta __lib6502_args
  sty __lib6502_args+1

.section .call_main,"axR",@progbits
  ; Reload the pointer that was saved by "__lib6502_entry_point"
  ; and call "_main" to convert the arguments into an "argv" array
  ; before calling the actual "main" function.
  lda __lib6502_args
  sta __rc2
  lda __lib6502_args+1
  sta __rc3
  jsr _main

.section .fini_rts,"axR",@progbits
  rts

; Make sure to search libraries for the after-main code to include.
.global __after_main

.section .noinit,"aw",@nobits
__lib6502_args:
  .fill 2
