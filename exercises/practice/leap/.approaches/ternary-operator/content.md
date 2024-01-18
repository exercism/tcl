# Ternary operator

```tcl
expr {$year % 100 == 0 ? $year % 400 == 0 : $year % 4 == 0}
```

A [conditional operator][ternary-operator], also known as a "ternary conditional operator", or just "ternary operator", is a very condensed "if-then-else" operator.
This structure uses a maximum of two checks to determine if a year is a leap year.

It starts by testing the outlier condition of the year being evenly divisible by `100`.
It does this by using the [remainder operator][remainder-operator]: `year % 100 == 0`.
If the year is evenly divisible by `100`, then the expression is `true`, and the ternary operator returns the result of testing if the year is evenly divisible by `400`.
If the year is _not_ evenly divisible by `100`, then the expression is `false`, and the ternary operator returns the result of testing if the year is evenly divisible by `4`.

| year | divisible by 4 | not divisible by 100 | divisible by 400 |    result    |
| ---- | -------------- | -------------------- | ---------------- | ------------ |
| 2020 |          false |        not evaluated |             true |         true |
| 2019 |          false |        not evaluated |            false |        false |
| 2000 |           true |                 true |    not evaluated |         true |
| 1900 |           true |                false |    not evaluated |        false |

Although it uses a maximum of two checks, the ternary operator tests an outlier condition first, making it less efficient than another approach that would first test if the year is evenly divisible by `4`, which is more likely than the year being evenly divisible by `100`.

[ternary-operator]: https://tcl.tk/man/tcl8.6/TclCmd/expr.htm#M21
[remainder-operator]: https://tcl.tk/man/tcl8.6/TclCmd/expr.htm#M9
