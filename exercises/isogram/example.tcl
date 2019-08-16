proc isIsogram {input} {
    set letters [regexp -all -inline {[[:alpha:]]} [string tolower $input]]
    set uniq [lsort -unique $letters]
    return [expr {[llength $letters] == [llength $uniq]}]
}
