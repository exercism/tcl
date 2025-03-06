proc deliveryDate {timestamp target} {
    set t [clock scan $timestamp -format {%Y-%m-%dT%T}]

    switch -regexp -matchvar m -- $target {
        {^NOW$}    { set t [now $t] }
        {^ASAP$}   { set t [asap $t] }
        {^EOW$}    { set t [eow $t] }
        {^(\d+)M$} { set t [month $t [lindex $m 1]] }
        {^Q(\d)$}  { set t [quarter $t [lindex $m 1]] }
        default    { error "Don't understand $target" }
    }

    return [clock format $t -format {%Y-%m-%dT%T}]
}

#########################################################
proc now {timeVal} {
    return [clock add $timeVal 2 hours]
}

proc asap {timeVal} {
    set hour [clock format $timeVal -format {%k}]
    # truncate time to midnight
    set midnight [clock scan [clock format $timeVal -format {%Y-%m-%d}] -format {%Y-%m-%d}]

    if {$hour < 13} {
        return [clock add $midnight 17 hours]
    } else {
        return [clock add $midnight 1 day 13 hours]
    }
}

proc eow {timeVal} {
    set dow [clock format $timeVal -format {%w}]
    set midnight [clock scan [clock format $timeVal -format {%Y-%m-%d}] -format {%Y-%m-%d}]

    if {$dow in {1 2 3}} {
        set days [expr {5 - $dow}]
        set hours 17
    } else {
        set days [expr {7 - $dow}]
        set hours 20
    }
    return [clock add $midnight $days days $hours hours]
}

proc month {timeVal targetMonth} {
    # %N is the month number with no leading zero
    lassign [clock format $timeVal -format {%Y %N}] year month
    if {$month >= $targetMonth} {
        incr year
    }
    set firstDay [clock scan "$year-$targetMonth-01" -format {%Y-%N-%d}]

    set dow [clock format $firstDay -format {%u}]
    if {$dow > 5} {
        # add one or two days
        set firstDay [clock add $firstDay [expr {8 - $dow}] days]
    }

    return [clock add $firstDay 8 hours]
}
proc quarter {timeVal targetQuarter} {
    set lastQuarterMonth [expr {3 * $targetQuarter}]
    lassign [clock format $timeVal -format {%Y %N}] year month
    if {$month > $lastQuarterMonth} {
        incr year
    }
    set lastQuarterMonthFirstDay [clock scan "$year-$lastQuarterMonth-01" -format {%Y-%N-%d}]
    set targetDay [clock add $lastQuarterMonthFirstDay 1 month -1 day]

    set dow [clock format $targetDay -format {%u}]
    if {$dow > 5} {
        # subtract one or two days
        set targetDay [clock add $targetDay [expr {5 - $dow}] days]
    }

    return [clock add $targetDay 8 hours]
}
