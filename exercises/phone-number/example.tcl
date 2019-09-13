proc clean {phone} {
    # remove "good" non-digits before checking for "bad" ones
    set digits [regsub -all {[\s().+-]} $phone ""]

    if {[regexp {[[:alpha:]]} $digits]} {
        error "letters not permitted"
    }
    if {[regexp {\D} $digits]} {
        error "punctuations not permitted"
    }
    if {[string length $digits] < 10} {
        error "incorrect number of digits"
    }
    if {[string length $digits] > 11} {
        error "more than 11 digits"
    }
    if {[string length $digits] == 11 && ![string match 1* $digits]} {
        error "11 digits must start with 1"
    }

    regexp {^1?(\d{3})(\d{3})(\d{4})$} $digits -> area exchange number

    foreach var {area exchange} {
        switch -glob -- [set $var] {
            0* {error "$var code cannot start with zero"}
            1* {error "$var code cannot start with one"}
        }
    }

    return [string cat $area $exchange $number]
}
