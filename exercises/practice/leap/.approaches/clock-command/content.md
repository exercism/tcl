# Using the `clock` command

Using [the `clock` command][tcl-clock] approach may be considered a "cheat" for this exercise.

```tcl
set timestamp [clock scan "$year-02-28" -format {%Y-%m-%d}]
set next_day [clock add $timestamp 1 day]
set day [clock format $next_day -format {%d}]
expr {$day == 29}
```

By adding a day to February 28th for the year, you can see if the new day is the 29th or the 1st.
If it is the 29th, then the year is a leap year.

Reference: [`clock` manual page](https://tcl.tk/man/tcl8.6/TclCmd/clock.htm)

~~~~exercism/note
[Under the hood][tcl-src-leap], Tcl does have an internal helper function to test for leap years.

[tcl-src-leap]: https://github.com/tcltk/tcl/blob/37176a333aa886595daaddbdf14ae7cacd1f06b0/generic/tclClock.c#L1561
~~~~

[tcl-clock]: https://tcl.tk/man/tcl8.6/TclCmd/clock.htm
