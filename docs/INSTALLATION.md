## Installing tclsh

The only tool you need is the TCL interpreter, `tclsh`.

You will need `tclsh8.4` or greater for the test framework, `tcltest`, to
ship along with it. You can test which version of `tclsh` you have installed
by running the following command:

```bash
tclsh <<< 'puts [info patchlevel]'
```

For Windows, the best place to get Tcl is [the ActiveTcl product from
ActiveState](https://www.activestate.com/products/activetcl/)

For MacOS and Unix-like operating systems, `tclsh` will be already
installed. Typically the installed version will be 8.5.*something*.
To install the current stable 8.6 version:
 - with MacOS, use [Homebrew](https://brew.sh/)
 - for Linux, check your package manager
 - or [download the source](https://www.tcl-lang.org/software/tcltk/download.html)
  and [build it](https://www.tcl-lang.org/doc/howto/compile.html).
