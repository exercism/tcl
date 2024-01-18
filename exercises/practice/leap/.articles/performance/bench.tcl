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

set output {
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
2000 - 1 - 72.496 microseconds per iteration
}
