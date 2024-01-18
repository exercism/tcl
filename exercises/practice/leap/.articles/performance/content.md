# Performance

This article demonstrates the use of [the `time` command][time-command] to compare the various approaches:

* [Boolean chain][approach-boolean-chain]
* [Ternary operator][approach-ternary-operator]
* [`clock` command][approach-clock-command]

```tcl
proc leap_bool {year} {
    return [expr {$year % 4 == 0 && ($year % 100 != 0 || $year % 400 == 0)}]
}

proc leap_ternary {year} {
    return [expr {$year % 100 == 0 ? $year % 400 == 0 : $year % 4 == 0}]
}

proc leap_clock {year} {
    set timestamp [clock scan "$year-02-28" -format {%Y-%m-%d}]
    set next_day [clock add $timestamp 1 day]
    set day [clock format $next_day -format {%d}]
    return [expr {$day == 29}]
}

proc time_it {procname} {
    foreach year {2023 2024 1900 2000} {
        puts [format {%d - %d - %s} \
                $year \
                [$procname $year] \
                [time {$procname $year} 1000]]
    }
}

foreach procname {leap_bool  leap_ternary  leap_clock} {
    puts $procname
    time_it $procname
    puts ""
}
```

This outputs:

```none
leap_bool
2023 - 0 - 0.378 microseconds per iteration
2024 - 1 - 0.472 microseconds per iteration
1900 - 0 - 0.525 microseconds per iteration
2000 - 1 - 0.533 microseconds per iteration

leap_ternary
2023 - 0 - 0.428 microseconds per iteration
2024 - 1 - 0.425 microseconds per iteration
1900 - 0 - 0.425 microseconds per iteration
2000 - 1 - 0.434 microseconds per iteration

leap_clock
2023 - 0 - 65.716 microseconds per iteration
2024 - 1 - 70.092 microseconds per iteration
1900 - 0 - 59.396 microseconds per iteration
2000 - 1 - 72.496 microseconds per iteration```

## Observations

1. Boolean chain

   We can see that the non leap year is the quickest to return, only having to execute one comparison.
   Even 100 and 400, the most expensive years to compute, execute in under one microsecond.

1. Ternary operator

   All the test years take the same amount of time to run.
   That is expected since every year passed in has to perform two comparisons.

1. `clock` command

   Unsurprisingly, this is much more expensive to run than the purely arithmetic approaches.

[approach-boolean-chain]: /tracks/tcl/exercises/leap/approaches/boolean-chain
[approach-ternary-operator]: /tracks/tcl/exercises/leap/approaches/ternary-operator
[approach-clock-command]: /tracks/tcl/exercises/leap/approaches/clock-command
