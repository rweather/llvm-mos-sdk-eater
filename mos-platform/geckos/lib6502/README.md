
lib6502 wrappers for llvm-mos
=============================

This directory contains wrappers for the lib6502 standard library
to make the functions accessible to applications built with llvm-mos.

These wrappers are a from-scratch implementation based on the
[lib6502 API documentation](http://www.6502.org/users/andre/lib6502/lib6502.html) rather than the original code.

License Warning
---------------

While the wrappers are licensed under the normal LLVM license,
lib6502 itself is under the GNU General Public License Version 2.
This may mean that any program you make that links against
lib6502 and runs on GeckOS/A65 may also need to be GPL-licensed.
It is not clear if there is a "linking exception" for this.

How it works
------------

When an application is built for lib6502-using operating systems like
[GeckOS/A65 V2.0](http://www.6502.org/users/andre/osa/index.html),
the operating system exports a symbol called `LIB6502` to the
application.  This points at a table of jump instructions to the
various lib6502 system calls.

For example, the entry point to `fopen` is at offset 0, the entry point
for `fclose` is at offset 3, and so on.

The SDK port wraps the entry points with assembly code shims that
convert from llvm-mos's calling conventions into the calling
conventions that are used by lib6502.

Naming
------

The [lib6502 API](http://www.6502.org/users/andre/lib6502/lib6502.html)
uses function names like `fopen`, `dup`, etc which are very POSIX-like.
But they may conflict with how llvm-mos will want to use those
functions in the future.  For example, a proper stdio-compatible
version of `fopen`, which lib6502's version isn't.

To address this, all function, type, and constant names in the wrappers
are prefixed with `k_` or `K_` where "k" means "kernel".  Higher level C
libraries can then use these functions to implement standard C API's.

More information
----------------

* [lib6502 standard library](http://www.6502.org/users/andre/lib6502/lib6502.html)
* [GeckOS/A65 V2.0](http://www.6502.org/users/andre/osa/index.html)
