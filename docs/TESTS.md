# Running the tests

To run the tests for an exercise, run the `<exercise>.test` script in the exercise directory:

```bash
tclsh <exercise>.test
```

For most exercises, all but the first test will be "skipped".
This allows you, the developer, to engage in Test-Driven Development: coding only as much as needed to pass each test one-by-one.
To override the skip commands, set the `RUN_ALL` environment variable to a valid Tcl true value \[1\] prior to running the test suite:

```bash
RUN_ALL=yes tclsh <exercise>.test
```

\[1\]: Tcl true/false values are documented in the man page for the C library function [Tcl_GetBoolean][bool].

[bool]: https://www.tcl-lang.org/man/tcl8.6/TclLib/GetInt.htm
