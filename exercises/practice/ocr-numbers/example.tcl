namespace eval OCR {
    namespace export convert

    # a dictionary mapping the joined OCR string to the number
    variable digitStrings {
        " _ | ||_|   "  0
        "     |  |   "  1
        " _  _||_    "  2
        " _  _| _|   "  3
        "   |_|  |   "  4
        " _ |_  _|   "  5
        " _ |_ |_|   "  6
        " _   |  |   "  7
        " _ |_||_|   "  8
        " _ |_| _|   "  9
    }

    proc convert {rows} {
        validate $rows
        set numbers {}
        for {set i 0} {$i < [llength $rows]} {incr i 4} {
            lappend numbers [convertRow [lrange $rows $i $i+3]]
        }
        return [join $numbers ","]
    }

    proc validate {rows} {
        if {[llength $rows] % 4 != 0} {
            error "Number of input lines is not a multiple of four"
        }
        foreach row $rows {
            if {[string length $row] % 3 != 0} {
                error "Number of input columns is not a multiple of three"
            }
        }
    }

    proc convertRow {lines} {
        set len [string length [lindex $lines 0]]
        set digits ""
        for {set i 0} {$i < $len} {incr i 3} {
            set dstr [join [lmap line $lines {string range $line $i $i+2}] ""]
            append digits [convertDigit $dstr]
        }
        return $digits
    }

    proc convertDigit {digitString} {
        variable digitStrings
        if {[dict exists $digitStrings $digitString]} {
            return [dict get $digitStrings $digitString]
        } else {
            return "?"
        }
    }
}

namespace import OCR::convert
