proc meetup {year month week weekday} {

    for {set d 1} {$d <= 31} {incr d} {
        try {
            # this throws an exception in Tcl 9 for invalid date
            # on Tcl 8.6, no exception but Jan 32 == Feb 1
            set time [clock scan "$year-$month-$d" -format "%Y-%m-%d"]
        } on error {} break

        # use the C locale to ensure English weekday names
        # %e returns day without leading zero
        # %N returns month without leading zero
        set info [clock format $time -format "%A %e %N" -locale C]
        lassign $info dayofweek day mon

        # the wanted day of the week
        if {$weekday ne $dayofweek} then continue

        # for months with < 31 days, applies for Tcl < 9.0
        if {$month != $mon} then break

        set meetupDay $day
        incr n

        if {
            ($week eq "first"  && $n == 1) ||
            ($week eq "second" && $n == 2) ||
            ($week eq "third"  && $n == 3) ||
            ($week eq "fourth" && $n == 4) ||
            ($week eq "teenth" && 13 <= $day && $day <= 19)
        } {
            break
        }
    }

    return [format "%4d-%02d-%02d" $year $month $meetupDay]
}
