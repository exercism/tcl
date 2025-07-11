# dummy

## Tcl-specific instructions

Tcl allows you to apply layers of "transformations" to open channels.
These transformations allow you to manipulate the incoming/outgoing data in any way.

References:

* The original [proposal][tip230] for channel transformations.
* The [`chan push`][chan] command documentation.
* The [`transchan`][transchan] documentation describing the API for channel transforms.

[tip230]: https://core.tcl-lang.org/tips/doc/trunk/tip/230.md
[transchan]: https://www.tcl-lang.org/man/tcl9.0/TclCmd/transchan.html
[chan]: https://www.tcl-lang.org/man/tcl9.0/TclCmd/chan.html#M33
