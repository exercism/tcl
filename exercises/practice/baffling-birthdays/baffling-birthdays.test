#!/usr/bin/env tclsh
# generated: 2026-07-25T18:32:21Z
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "baffling-birthdays.tcl"


test baffling-birthdays-1 "shared birthday: one birthdate" -body {
    sharedBirthday {
        "2000-01-01"
    }
} -returnCodes ok -match boolean -result false

skip baffling-birthdays-2
test baffling-birthdays-2 "shared birthday: two birthdates with same year, month, and day" -body {
    sharedBirthday {
        "2000-01-01"
        "2000-01-01"
    }
} -returnCodes ok -match boolean -result true

skip baffling-birthdays-3
test baffling-birthdays-3 "shared birthday: two birthdates with same year and month, but different day" -body {
    sharedBirthday {
        "2012-05-09"
        "2012-05-17"
    }
} -returnCodes ok -match boolean -result false

skip baffling-birthdays-4
test baffling-birthdays-4 "shared birthday: two birthdates with same month and day, but different year" -body {
    sharedBirthday {
        "1999-10-23"
        "1988-10-23"
    }
} -returnCodes ok -match boolean -result true

skip baffling-birthdays-5
test baffling-birthdays-5 "shared birthday: two birthdates with same year, but different month and day" -body {
    sharedBirthday {
        "2007-12-19"
        "2007-04-27"
    }
} -returnCodes ok -match boolean -result false

skip baffling-birthdays-6
test baffling-birthdays-6 "shared birthday: two birthdates with different year, month, and day" -body {
    sharedBirthday {
        "1997-08-04"
        "1963-11-23"
    }
} -returnCodes ok -match boolean -result false

skip baffling-birthdays-7
test baffling-birthdays-7 "shared birthday: multiple birthdates without shared birthday" -body {
    sharedBirthday {
        "1966-07-29"
        "1977-02-12"
        "2001-12-25"
        "1980-11-10"
    }
} -returnCodes ok -match boolean -result false

skip baffling-birthdays-8
test baffling-birthdays-8 "shared birthday: multiple birthdates with one shared birthday" -body {
    sharedBirthday {
        "1966-07-29"
        "1977-02-12"
        "2001-07-29"
        "1980-11-10"
    }
} -returnCodes ok -match boolean -result true

skip baffling-birthdays-9
test baffling-birthdays-9 "shared birthday: multiple birthdates with more than one shared birthday" -body {
    sharedBirthday {
        "1966-07-29"
        "1977-02-12"
        "2001-12-25"
        "1980-07-29"
        "2019-02-12"
    }
} -returnCodes ok -match boolean -result true

skip baffling-birthdays-10
test baffling-birthdays-10 "random birthdates: generate requested number of birthdates" -body {
    set result true
    for {set count 1} {$count <= 100} {incr count} {
        set birthdates [randomBirthdates $count]

        set result [expr {$result && ([llength $birthdates] == $count)}]
    }
    set result
} -returnCodes ok -match boolean -result true

skip baffling-birthdays-11
test baffling-birthdays-11 "random birthdates: years are not leap years" -body {
    # it's a leap year if the 60th day of the year is the 29th day of the month
    proc isLeapYear {year} {
        set d [clock format [clock scan "$year-060" -format {%Y-%j}] -format %d]
        expr {$d eq "29"}
    }
    set result true
    foreach date [randomBirthdates 100] {
        set year [lindex [split $date "-"] 0]

        set result [expr {$result && ![isLeapYear $year]}]
    }
    set result
} -returnCodes ok -match boolean -result true

skip baffling-birthdays-12
test baffling-birthdays-12 "random birthdates: months are random" -body {
    set seen [dict create]
    foreach date [randomBirthdates 100] {
        set month [lindex [split $date "-"] 1]
        dict incr seen $month
    }
    set months [lsort [dict keys $seen]]
    expr {$months eq {01 02 03 04 05 06 07 08 09 10 11 12}}
} -returnCodes ok -match boolean -result true

skip baffling-birthdays-13
test baffling-birthdays-13 "random birthdates: days are random" -body {
    set seen [dict create]
    foreach date [randomBirthdates 300] {
        set day [lindex [split $date "-"] 2]
        dict incr seen $day
    }
    set days [lsort [dict keys $seen]]
    expr {
        [llength $days] == 31 &&
        [lindex $days 0] eq "01" &&
        [lindex $days end] eq "31"
    }
} -returnCodes ok -match boolean -result true

skip baffling-birthdays-14
test baffling-birthdays-14 "estimated probability of at least one shared birthday: for one person" -body {
    estimatedProbabilityOfSharedBirthday 1
} -returnCodes ok -match approxEqual -result 0.0

skip baffling-birthdays-15
test baffling-birthdays-15 "estimated probability of at least one shared birthday: among ten people" -body {
    estimatedProbabilityOfSharedBirthday 10
} -returnCodes ok -match approxEqual -result 11.694818

skip baffling-birthdays-16
test baffling-birthdays-16 "estimated probability of at least one shared birthday: among twenty-three people" -body {
    estimatedProbabilityOfSharedBirthday 23
} -returnCodes ok -match approxEqual -result 50.729723

skip baffling-birthdays-17
test baffling-birthdays-17 "estimated probability of at least one shared birthday: among seventy people" -body {
    estimatedProbabilityOfSharedBirthday 70
} -returnCodes ok -match approxEqual -result 99.915958


cleanupTests
