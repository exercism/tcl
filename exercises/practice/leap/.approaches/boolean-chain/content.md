# Chaining Boolean expressions

```tcl
expr {$year % 4 == 0 && ($year % 100 != 0 || $year % 400 == 0)}
```

The Boolean expression `$year % 4 == 0` checks the remainder from dividing `$year` by 4.
If a year is evenly divisible by 4, the remainder will be zero.
All leap years are divisible by 4, and this pattern is then repeated whether a year is not divisible by 100 and whether it is divisible by 400.

Parentheses are used to control the [order of precedence][order-of-precedence]:
logical AND `&&` has a higher precedence than logical OR `||`.

| year | divisible by 4 | not divisible by 100 | divisible by 400 |    result    |
| ---- | -------------- | -------------------  | ---------------- | ------------ |
| 2020 |           true |                 true |    not evaluated |         true |
| 2019 |          false |        not evaluated |    not evaluated |        false |
| 2000 |           true |                false |             true |         true |
| 1900 |           true |                false |            false |        false |

By situationally skipping some of the tests, we can efficiently calculate the result with fewer operations.

[order-of-precedence]: https://tcl.tk/man/tcl8.6/TclCmd/expr.htm#M6
