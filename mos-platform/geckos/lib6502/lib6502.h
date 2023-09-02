/*
 * Copyright (c) 2023 Rhys Weatherley
 *
 * Licensed under the Apache License, Version 2.0 with LLVM Exceptions,
 * See https://github.com/llvm-mos/llvm-mos-sdk/blob/main/LICENSE for license
 * information.
 */

#ifndef _LIB6502_H_
#define _LIB6502_H_

/*
 * See http://www.6502.org/users/andre/lib6502/lib6502.html
 * for the documentation of the lib6502 API.
 *
 * Function, type, and macro names are prefixed with "k_"/"K_" to
 * avoid conflicts with standard C and POSIX.  We may want to
 * use the standard names for standard purposes in the future,
 * wrapped around these definitions.
 */

#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Error codes */
#define K_E_OK 0
#define K_E_NOTIMP -1
#define K_E_CONFIG -2
#define K_E_ILLPAR -3
#define K_E_NOMEM -4
#define K_E_NOSTR -5
#define K_E_SFULL -6
#define K_E_SEMPTY -7
#define K_E_SLWM -8
#define K_E_SHWM -9
#define K_E_EOF -10
#define K_E_NUL -11
#define K_E_NODEV -12
#define K_E_DON -13
#define K_E_DOFF -14
#define K_E_NOTX -15
#define K_E_NOENV -16
#define K_E_NOSEM -17
#define K_E_SEMSET -18
#define K_E_NOIRQ -19
#define K_E_VERSION -20
#define K_E_NOTASK -21
#define K_E_INT -22
#define K_E_ILLSIG -23
#define K_E_TRYAGAIN -24
#define K_E_NOPAR -25
#define K_E_NOTHREAD -26
#define K_E_SYNTAX -27
#define K_E_NODRV -32
#define K_E_FNOPATH -33
#define K_E_FILLNAM -34
#define K_E_FNAMLEN -35
#define K_E_NOFIL -36
#define K_E_FWPROT -37
#define K_E_FILEXIST -38
#define K_E_FDISKFULL -39
#define K_E_FDNEMPTY -40
#define K_E_FLOCKED -41
#define K_E_FMEDIA -42
#define K_E_FLOGICAL -43
#define K_E_FINTERNAL -44
#define K_E_FILETYPE -45
#define K_E_DISKTYPE -46
#define K_E_ILLADDR -64
#define K_E_NOFILE -65
#define K_E_NOSEEK -66
#define K_E_NOREAD -67
#define K_E_NOWRITE -68
#define K_E_FVERSION -69
#define K_E_LASTERR -96

/* Values for the "blocking" parameter of file functions */
#define K_BLOCKING 1
#define K_NONBLOCKING 0

/* Standard file descriptors */
#define K_STDERR 255
#define K_STDOUT 254
#define K_STDIN 253
#define K_STDCIN 252
#define K_STDNUL 251

/* Mode values for k_fopen() */
#define K_OPEN_RD 0x00
#define K_OPEN_WR 0x01
#define K_OPEN_RW 0x02
#define K_OPEN_AP 0x03
#define K_OPEN_NOCREAT 0x20
#define K_OPEN_EXCL 0x40
#define K_OPEN_TRUNC 0x80

/* Whence values for k_fseek() */
#define K_SEEK_SET 0
#define K_SEEK_END 1
#define K_SEEK_CUR 2

/* Operations for k_fcntl() */
#define K_FC_PUSH 0
#define K_FC_PULL 1
#define K_FC_RCHECK 2
#define K_FC_WCHECK 3

/* Operations for k_fcmd() */
#define K_FC_RENAME 16
#define K_FC_DELETE 17
#define K_FC_MKDIR 18
#define K_FC_RMDIR 19
#define K_FC_FORMAT 20
#define K_FC_CHKDSK 21

/* Maximum filename string length */
#define K_MAX_FILENAME 128

/* File permission bits */
#define K_S_IRWXO   0000007
#define K_S_IROTH   0000004
#define K_S_IWOTH   0000002
#define K_S_IXOTH   0000001
#define K_S_IRWXG   0000070
#define K_S_IRGRP   0000040
#define K_S_IWGRP   0000020
#define K_S_IXGRP   0000010
#define K_S_IRWXU   0000700
#define K_S_IRUSR   0000400
#define K_S_IWUSR   0000200
#define K_S_IXUSR   0000100
#define K_S_ISVTX   0001000
#define K_S_ISGID   0002000
#define K_S_ISUID   0004000
#define K_S_IFMT    0170000
#define K_S_IFIFO   0010000
#define K_S_IFCHR   0020000
#define K_S_IFMNAME 0030000
#define K_S_IFDIR   0040000
#define K_S_IFMFREE 0050000
#define K_S_IFBLK   0060000
#define K_S_IFMSIZE 0070000
#define K_S_IFREG   0100000
#define K_S_IFLNK   0120000
#define K_S_IFSOCK  0140000

/* Bits in "k_dirent::valid", indicating which other fields are valid */
#define K_DIRENT_VALID_PERM 0x01
#define K_DIRENT_VALID_LENGTH 0x02
#define K_DIRENT_VALID_MTIME 0x04
#define K_DIRENT_VALID_OWNER 0x08
#define K_DIRENT_VALID_GROUP 0x10

/* Network protocols */
#define K_IPPROTO_TCP 0
#define K_IPPROTO_UDP 1

/* Signals as bitmasks */
#define K_SIGUSR1 0x01
#define K_SIGUSR2 0x02
#define K_SIGUSR3 0x04
#define K_SIGUSR4 0x08
#define K_SIGBRK 0x10
#define K_SIGKILL 0x20
#define K_SIGCHLD 0x40
#define K_SIGINTABLE 0x80

/* Special process identifier for "this task" */
#define K_MYTASK 255

/* File modification time */
struct k_file_time
{
  uint8_t year; /* minus 1990 */
  uint8_t month;
  uint8_t day;
  uint8_t hr;
  uint8_t min;
  uint8_t sec;
};

/* Directory entry returned by k_freaddir() */
struct k_dirent
{
  uint16_t valid;
  uint16_t perm;
  uint16_t owner;
  uint16_t group;
  uint32_t length;
  struct k_file_time mtime;
  char name[K_MAX_FILENAME];
};

/* Socket address for network connections */
struct k_sockaddr_in
{
  uint8_t len;
  uint8_t ipaddr[4];
  uint16_t port;

} __attribute__((packed));

/* Port for listening connections */
struct k_listen_port
{
  uint8_t len;
  uint16_t port;

} __attribute__((packed));

/* Structure to pass to k_forkto().  Must be immediately followed
 * in memory by the command-line arguments for the new process. */
struct k_forkto_info
{
  uint8_t fd_stdin;
  uint8_t fd_stdout;
  uint8_t fd_stderr;
};

/* The functions return >= 0 on success or < 0 on error (see codes above).
 * While fd parameters are int, they are usually truncated to uint8_t
 * within the calls.  The high byte of the fd is ignored. */

/* Some operations from the lib6502 documentation are not listed here
 * because they are not implemented by GeckOS/A65 at present. */

/* File operations */
__attribute__((leaf)) int k_fopen(const char *filename, uint8_t mode);
__attribute__((leaf)) int k_fclose(int fd);
__attribute__((leaf)) int k_fgetc(int fd, uint8_t blocking);
__attribute__((leaf)) int k_fputc(int fd, uint8_t c, uint8_t blocking);
int k_fread(int fd, void *data, size_t len, uint8_t blocking);
int k_fwrite(int fd, const void *data, size_t len, uint8_t blocking);
int k_fseek(int fd, int32_t offset, uint8_t whence);
__attribute__((leaf)) int k_pipe(int pipefd[2]);
__attribute__((leaf)) int k_fcntl(int fd, uint8_t fop);
__attribute__((leaf)) int k_fcmd(const char *filename, uint8_t fop);
__attribute__((leaf)) int k_stddup(int oldfd, int newfd);
__attribute__((leaf)) int k_dup(int fd);

/* Directory operations */
__attribute__((leaf)) int k_fopendir(const char *path);
__attribute__((leaf)) int k_freaddir(int fd, struct k_dirent *dirent);
__attribute__((leaf)) int k_chdir(const char *path);
__attribute__((leaf)) int k_cwd(char *path, uint8_t size);

/* Network operations */
__attribute__((leaf)) int k_connect(const struct k_sockaddr_in *addr, uint8_t protocol);
__attribute__((leaf)) int k_listen_open(const struct k_listen_port *port, uint8_t protocol);
__attribute__((leaf)) int k_listen_close(int fd);
__attribute__((leaf)) int k_accept(int fd, struct k_sockadr_in *addr, uint8_t blocking);

/* Memory management */
__attribute__((leaf)) void *k_malloc(size_t size);
__attribute__((leaf)) int k_free(void *block);
__attribute__((leaf)) void *k_realloc(void *block, size_t size);

/* Process management */
__attribute__((leaf)) int k_exec(const char *args);
__attribute__((leaf)) int k_forkto(const struct k_forkto_info *info);
__attribute__((leaf)) int k_forkthread(void (*start)(void));
__attribute__((leaf,noreturn)) void k_term(uint8_t exit_status);
__attribute__((leaf)) int k_kill(int pid, uint8_t exit_status);
__attribute__((leaf)) int k_getpid(void);
__attribute__((leaf)) void k_yield(void);

/* Semaphores */
__attribute__((leaf)) int k_semget(uint8_t blocking);
__attribute__((leaf)) int k_semfre(int sem);
__attribute__((leaf)) int k_psem(int sem, uint8_t blocking);
__attribute__((leaf)) int k_vsem(int sem);

/* Signal handling.
 *
 * Use k_signal() to register for a specific signal.  All signals will be
 * delivered to k_signal_handler() which the user's application must supply
 * if it is interested in signals.  Marked as interrupt context because
 * signals can occur at any time.  Use k_signal_remove() to remove the
 * registration for a specific signal.
 */
__attribute__((leaf)) int k_signal(int sig);
__attribute__((leaf)) int k_signal_remove(int sig);
__attribute__((leaf)) int k_sendsignal(int pid, int sig);
__attribute__((interrupt)) void k_signal_handler(int sigmask);

/* Environment handling */
__attribute__((leaf)) char *k_getenv(const char *name);
__attribute__((leaf)) int k_putenv(const char *name);
__attribute__((leaf)) const char *k_getenvp(void);
__attribute__((leaf)) const char *k_getos(void);

#ifdef __cplusplus
}
#endif

#endif /* not _LIB6502_H_ */
