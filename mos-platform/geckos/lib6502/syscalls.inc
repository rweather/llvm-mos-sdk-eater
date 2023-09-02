
; Copyright (c) 2023 Rhys Weatherley
;
; Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
; See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
; information.

.include "imag.inc"

; Offsets from the LIB6502 symbol to the system calls in lib6502.
#define SYS_fopen 0
#define SYS_fclose 3
#define SYS_fgetc 6
#define SYS_fputc 9
#define SYS_fread 12
#define SYS_fwrite 15
#define SYS_fseek 18
#define SYS_pipe 21
#define SYS_flock 24
#define SYS_fcntl 27
#define SYS_fcmd 30
#define SYS_stddup 33
#define SYS_dup 36
#define SYS_fopendir 39
#define SYS_freaddir 42
#define SYS_fgetattr 45
#define SYS_fsetattr 48
#define SYS_chdir 51
#define SYS_cwd 54
#define SYS_connect 57
#define SYS_listen 60
#define SYS_accept 63
#define SYS_malloc 66
#define SYS_mfree 69
#define SYS_realloc 72
#define SYS_exec 75
#define SYS_forkto 78
#define SYS_forkthread 81
#define SYS_term 84
#define SYS_kill 87
#define SYS_getpid 90
#define SYS_yield 93
#define SYS_semget 96
#define SYS_semfre 99
#define SYS_semgetnamed 102
#define SYS_psem 105
#define SYS_vsem 108
#define SYS_signal 111
#define SYS_sendsignal 114
#define SYS_send 117
#define SYS_receive 120
#define SYS_getenv 123
#define SYS_putenv 126
#define SYS_getenvp 129
#define SYS_getos 132
