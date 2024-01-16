# Introduction

There are various idiomatic approaches to solve Leap.

## General guidance

The key to solving Leap is to know if the year is evenly divisible by `4`, `100` and `400`.
To determine that, you will use the [modulo operator][modulo-operator].

## Approach: Arithmetic expression: chain of Boolean expressions

```tcl
expr {$year % 4 == 0 && ($year % 100 != 0 || $year % 400 == 0)}
```

For more information, check the [Boolean chain approach][approach-boolean-chain].

## Approach: Arithmetic expression Ternary operator of Boolean expressions

```tcl
expr {$year % 100 == 0 ? $year % 400 == 0 : $year % 4 == 0}
```

For more information, check the [Ternary operator approach][approach-ternary-operator].

## Approach: `clock` command

TODO...

```tcl
set timestamp [clock scan "$year-02-28" -format {%Y-%m-%d} -timezone :UTC]
set next_day [clock add $timestamp 1 day -timezone :UTC]
set day [clock format $next_day -format {%d} -timezone :UTC]
expr {$day == 29}
```

Add a day to February 28th for the year and see if the new day is the 29th. For more information, see the [`clock` command approach][approach-clock-command].

## Which approach to use?

- The chain of Boolean expressions should be the most efficient, as it proceeds from the most likely to least likely conditions.
It has a maximum of three checks.
It is the most efficient approach when testing a year that is not evenly divisible by `100` and is not a leap year, since the most likely outcome is eliminated first.
- The ternary operator has a maximum of only two checks, but it starts from a less likely condition.
- Using the `clock` command to do datetime arithmetic will be slower than the other approaches, just because Tcl has much more work to do under the hood.

TODO performance

[modulo-operator]: https://tcl.tk/man/tcl8.6/TclCmd/expr.htm#M9
[approach-boolean-chain]: https://exercism.org/tracks/tcl/exercises/leap/approaches/boolean-chain
[approach-ternary-operator]: https://exercism.org/tracks/tcl/exercises/leap/approaches/ternary-operator
[approach-clock-command]: https://exercism.org/tracks/tcl/exercises/leap/approaches/clock-command
