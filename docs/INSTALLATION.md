# Installation

## Installing tclsh

The only tool you need is the TCL interpreter, `tclsh`.

For Windows, the best place to get Tcl is [the ActiveTcl product from
ActiveState](https://www.activestate.com/products/activetcl/)

For MacOS and Unix-like operating systems, `tclsh` will be already
installed. Typically the installed version will be 8.5.*something*.
To install the current stable 8.6 version:
 - with MacOS, use [Homebrew](https://brew.sh/)
 - for Linux, check your package manager
 - or [download the source](https://www.tcl-lang.org/software/tcltk/download.html)
  and [build it](https://www.tcl-lang.org/doc/howto/compile.html).

For solving exercises using the Exercism web interface, the test runner
(as of Feb 2023) uses Tcl version 8.7a4.

## Using the interactive tclsh shell

It's common to launch an interactive 
[`tclsh`](https://www.tcl-lang.org/man/tcl8.6/UserCmd/tclsh.htm) 
session to test out commands while you're coding. However, tclsh provides
only a very basic REPL interpreter with no command line editing or command
history. For an enhanced experience, a program called `rlwrap` exists that adds readline
functionality:
```bash
rlwrap tclsh
```
To install:
 - with MacOS, use [Homebrew](https://brew.sh/)
 - for Linuxes, check your package manager
 - or [download the source](https://github.com/hanslub42/rlwrap)
  and [build it](https://github.com/hanslub42/rlwrap/blob/master/INSTALL).

It's so handy you'll want to always use it: add this to your ~/.bashrc
```bash
command -v rlwrap && alias tclsh='rlwrap tclsh'
```

## What version to use?

The current stable version is 8.6.
As indicated above, version 8.5 is still widely deployed, but it's no longer receiving patches.
Version 8.7 is still pre-release, but it's very stable.

You can test which version of `tclsh` you have installed
by running the following command:

```bash
echo 'puts [info patchlevel]' | tclsh
```
