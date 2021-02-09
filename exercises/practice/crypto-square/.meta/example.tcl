proc encrypt {plaintext} {
    if {$plaintext eq ""} {
        return ""
    }

    set text [regsub -all {[^[:alnum:]]} [string tolower $plaintext] ""]
    set size [expr {int(ceil(sqrt([string length $text])))}]
    set segments [regexp -all -inline ".{1,$size}" $text]

    # pad the last segment with spaces
    lset segments end [format {%-*s} $size [lindex $segments end]]

    set transposed {}
    for {set i 0} {$i < $size} {incr i} {
        set column [lmap seg $segments {string range $seg $i $i}]
        lappend transposed [join $column ""]
    }

    return [join $transposed]
}
