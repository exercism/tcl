#!/usr/bin/env tclsh

set alphabet [split "abcdefghijklmnopqrstuvwxyz" ""]

proc isPangram {text} {
    set text [string tolower $text]
    foreach {letter} $::alphabet {
        if {[string first $letter $text] < 0} {
            return 0
        }
    }
    return 1
}
