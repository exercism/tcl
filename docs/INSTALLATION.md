## Installing tclsh

The only tool you need is the TCL interpreter, `tclsh`.

You will need `tclsh8.4` or greater for the test framework, `tcltest`, to
ship along with it. You can test which version of `tclsh` you have installed
by running the following command:

```bash
tclsh <<< 'puts [info patchlevel]'
```
