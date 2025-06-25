# Installation

## Installing tclsh

The only tool you need is the TCL interpreter, `tclsh`.

For Windows, the best place to get Tcl is [the Tcl installer from Magicsplat][magicsplat].

For MacOS and Unix-like operating systems, `tclsh` will be already installed.
Typically the installed version will be 8.6.*something*.
To install the current stable 9.0 version:
 - with MacOS, use [Homebrew][brew].
 - for Linux, check your package manager.
 - or [download the source][download] and [build it][build].

For solving exercises using the Exercism web interface, the test runner (as of Feb 2023) uses Tcl version 8.7a4.

## Using the interactive tclsh shell

It's common to launch an interactive [`tclsh`][tclsh] session to test out commands while you're coding.
However, tclsh provides only a very basic REPL interpreter with no command line editing or command history.
For an enhanced experience, a program called `rlwrap` exists that adds readline functionality:

```bash
rlwrap tclsh
```

To install rlwrap:
 - with MacOS, use [Homebrew][brew].
 - for Linuxes, check your package manager.
 - or [download the source][rlwrap-download] and [build it][rlwrap-build].

It's so handy you'll want to always use it: add this to your ~/.bashrc

```bash
command -v rlwrap && alias tclsh='rlwrap tclsh'
```

## What version to use?

The current stable version is 9.0.
As indicated above, version 8.6 is still widely deployed.

You can test which version of `tclsh` you have installed by running the following command:

```bash
echo 'puts [info patchlevel]' | tclsh
```

[magicsplat]: https://www.magicsplat.com/tcl-installer/index.html
[brew]: https://brew.sh/
[download]: https://www.tcl-lang.org/software/tcltk/download.html
[build]: https://www.tcl-lang.org/doc/howto/compile.html
[tclsh]: https://www.tcl-lang.org/man/tcl8.6/UserCmd/tclsh.htm
[rlwrap-download]: https://github.com/hanslub42/rlwrap
[rlwrap-build]: https://github.com/hanslub42/rlwrap/blob/master/INSTALL
