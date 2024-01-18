# Introduction

There are various idiomatic approaches to solve Leap.

## General guidance

The key to solving Leap is to know if the year is evenly divisible by `4`, `100` and `400`.
To determine that, you will use the [modulo operator][modulo-operator].

Recall that Tcl commands all look like `cmd arg arg ...`.
You can't just do `set z $x + $y` because `+` would be treated as just an argument, not an operation to add two numbers.
[The `expr` command][expr-command] is needed to perform arithmetic.
It essentially implements arithmetic as a domain-specific language, parsing its arguments as an arithmetic expression.

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

## Approach: Using the `clock` command

Add a day to February 28th in the given year and see if the new day is the 29th.

```tcl
set timestamp [clock scan "$year-02-28" -format {%Y-%m-%d}]
set next_day [clock add $timestamp 1 day]
set day [clock format $next_day -format {%d}]
expr {$day == 29}
```

For more information, see the [`clock` command approach][approach-clock-command].

## Which approach to use?

- The chain of Boolean expressions should be the most efficient, as it proceeds from the most likely to least likely conditions.
It has a maximum of three checks.
It is the most efficient approach when testing a year that is not evenly divisible by `100` and is not a leap year, since the most likely outcome is eliminated first.
- The ternary operator has a maximum of only two checks, but it starts from a less likely condition.
- Using the `clock` command to do datetime arithmetic will be slower than the other approaches, just because Tcl has much more work to do under the hood.

See [the Performance article][article-perf].

[modulo-operator]: https://tcl.tk/man/tcl8.6/TclCmd/expr.htm#M9
[expr-command]: https://tcl.tk/man/tcl8.6/TclCmd/expr.htm
[approach-boolean-chain]: /tracks/tcl/exercises/leap/approaches/boolean-chain
[approach-ternary-operator]: /tracks/tcl/exercises/leap/approaches/ternary-operator
[approach-clock-command]: /tracks/tcl/exercises/leap/approaches/clock-command
[article-perf]: /tracks/tcl/exercises/leap/articles/performance
