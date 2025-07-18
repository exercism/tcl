# Instructions append

## Tcl notes about Unicode

In version 8.1, Tcl strings were able to handle Unicode characters seamlessly.
At the time, that was quite groundbreaking.
However, as more and more Unicode characters were created, Tcl's ability to handle them fell behind.

Tcl's internal implementation could only handle 16-bit Unicode characters, which only covers the first 65,526 characters.
[This Tcl wiki page][tcl-unicode], particularly the discussion about the "AndroWish" language, gives the reasons.

Tcl 9.0 is the first version that can [handle the full Unicode character set][tip-497].
Consequently, this exercise is only (easily) solved with Tcl version 9.0.

[tcl-unicode]: https://wiki.tcl-lang.org/page/Unicode+and+UTF-8
[tip-497]: https://core.tcl-lang.org/tips/doc/trunk/tip/497.md
