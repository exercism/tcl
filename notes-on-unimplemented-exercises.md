# Notes on unimplemented exercises

[Unimplemented exercises in Tcl][unimplemented] on the Exercism Track maintenance tool.

## Foregone exercises

* [micro-blog][micro-blog]
    - Default builds of tclsh cannot handle emojis
    - see [Unicode and UTF-8][tcl-unicode] in the Tcl wiki, particularly the discussion on AndroWish

## Merely unimplemented

* [ledger][ledger]
    - a tedious-to-create refactoring exercise
* [lens-person][lens-person]
    - Tcl does not have immutable data
    - but this exercise could be about ways to access deeply nested dictionaries
* [paasio][paasio]
    - probably need to use the [`transchan`][transchan] command
* [sgf-parsing][sgf-parsing]
* [tree-building][tree-building]
    - a tedious-to-create refactoring exercise


[unimplemented]: https://tracks.exercism.io/tcl/main/unimplemented
[lens-person]: https://github.com/exercism/problem-specifications/tree/master/exercises/lens-person
[micro-blog]: https://github.com/exercism/problem-specifications/tree/master/exercises/micro-blog
[tcl-unicode]: https://wiki.tcl-lang.org/page/Unicode+and+UTF-tree-building
[ledger]: https://github.com/exercism/problem-specifications/tree/master/exercises/ledger
[paasio]: https://github.com/exercism/problem-specifications/tree/master/exercises/paasio
[sgf-parsing]: https://github.com/exercism/problem-specifications/tree/master/exercises/sgf-parsing
[tree-building]: https://github.com/exercism/problem-specifications/tree/master/exercises/tree-building
[transchan]: https://www.tcl-lang.org/man/tcl8.6/TclCmd/transchan.htm
