platform(geckos COMPLETE HOSTED PARENT common)

if(NOT CMAKE_CROSSCOMPILING)
  return()
endif()

install(FILES
  chrin.h
  chrout.h
  lib6502/lib6502.h
TYPE INCLUDE)
install(FILES link.ld TYPE LIB)

add_platform_object_file(geckos-crt0-o crt0.o crt0.S)

add_platform_library(geckos-crt0
  call-main.c
)
merge_libraries(geckos-crt0
  common-init-stack
  common-copy-zp-data
  common-zero-bss
  common-exit-return
)

add_platform_library(geckos-c
  chrin.c
  chrin_no_wait.c
  chrout.c
  getchar.c
  putchar.c
  lib6502/k_accept.S
  lib6502/k_chdir.S
  lib6502/k_connect.S
  lib6502/k_cwd.S
  lib6502/k_dup.S
  lib6502/k_exec.S
  lib6502/k_fclose.S
  lib6502/k_fcmd.S
  lib6502/k_fcntl.S
  lib6502/k_fgetc.S
  lib6502/k_fopendir.S
  lib6502/k_fopen.S
  lib6502/k_forkthread.S
  lib6502/k_forkto.S
  lib6502/k_fputc.S
  lib6502/k_fread2.S
  lib6502/k_fread.c
  lib6502/k_freaddir.S
  lib6502/k_free.S
  lib6502/k_fseek2.S
  lib6502/k_fseek.c
  lib6502/k_fwrite2.S
  lib6502/k_fwrite.c
  lib6502/k_getenv.S
  lib6502/k_getenvp.S
  lib6502/k_getos.S
  lib6502/k_getpid.S
  lib6502/k_kill.S
  lib6502/k_listen.S
  lib6502/k_malloc.S
  lib6502/k_pipe.S
  lib6502/k_psem.S
  lib6502/k_putenv.S
  lib6502/k_realloc.S
  lib6502/k_semfre.S
  lib6502/k_semget.S
  lib6502/k_sendsignal.S
  lib6502/k_signal.S
  lib6502/k_stddup.S
  lib6502/k_term.S
  lib6502/k_vsem.S
  lib6502/k_yield.S
)

target_link_libraries(geckos-crt0 PRIVATE common-asminc)

target_include_directories(geckos-c SYSTEM BEFORE PUBLIC lib6502 .)
target_link_libraries(geckos-c PRIVATE common-asminc)
