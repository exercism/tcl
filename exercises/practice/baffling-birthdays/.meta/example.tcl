# Determine if a list of YYYY-MM-DD birthdates contains
# any shared birthdays.

proc sharedBirthday {birthdays} {
    set seen [dict create]
    foreach birthday $birthdays {
        set monthDay [string range $birthday 5 end]
        dict incr seen $monthDay
        if {[dict get $seen $monthDay] > 1} {
            return true
        }
    }
    return false
}

# Generate a list of $count random dates in YYYY-MM-DD form.
# Do not include leap years.

proc randomBirthdates {count} {
    set birthdates {}
    for {set i 0} {$i < $count} {incr i} {
        lappend birthdates [randomDate]
    }
    return $birthdates
}

proc randomDate {} {
    set year [randomYear]
    set yearDay [expr {int(rand() * 365) + 1}]
    set time [clock scan "$year-$yearDay" -format {%Y-%j}]
    return [clock format $time -format {%Y-%m-%d}]
}

proc randomYear {} {
    set now [clock format [clock seconds] -format %Y]
    set year [expr {1900 + int(rand() * ($now - 1900))}]
    if {[isLeapYear $year]} {
        tailcall randomYear
    }
    return $year
}

proc isLeapYear {year} {
    expr {$year % 4 == 0 && ($year % 100 != 0 || $year % 400 == 0)}
}

# Estimate the probability that 2 people in a group of given size
# have the same birthday.

proc estimatedProbabilityOfSharedBirthday {size} {
    set shared 0
    set iterations 10000

    # have to have at least 2 people to share a birthday
    if {$size > 1} {
        for {set i $iterations} {$i > 0} {incr i -1} {
            if {[sharedBirthday [randomBirthdates $size]]} {
                incr shared
            }
        }
    }

    return [expr {100.0 * $shared / $iterations}]
}
