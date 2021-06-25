# Tcl Packages

This is the first exercise to include a pre-written package.
Note the presence of the file `pkgIndex.tcl` and the inclusion of the current directory in the `auto_path` variable.
These allow the `package require` command to be able to find the package's source file.

This is not a particularly well-written package: it's just some code that was borrowed from various sources.
The `interp alias` call is meant to hide the warts and make the permutations package easier to use.

References:
* [`auto_path`](http://www.tcl-lang.org/man/tcl8.6/TclCmd/tclvars.htm)
* [`package`](http://www.tcl-lang.org/man/tcl8.6/TclCmd/package.htm)
* [`pkg_mkIndex`](http://www.tcl-lang.org/man/tcl8.6/TclCmd/pkgMkIndex.htm)
