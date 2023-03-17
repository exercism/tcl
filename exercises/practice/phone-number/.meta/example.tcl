proc clean {phone} {
    # remove allowable characters
    set digits [regsub -all {[\s().+-]} $phone ""]

    if {[regexp {[[:alpha:]]} $digits]} {
        error "letters not permitted"
    }
    if {[regexp {\D} $digits]} {
        error "punctuations not permitted"
    }
    if {[string length $digits] < 10} {
        error "must not be fewer than 10 digits"
    }
    if {[string length $digits] > 11} {
        error "must not be greater than 11 digits"
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
