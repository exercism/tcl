proc nucleotideCounts {strand} {
    set counts {A 0 C 0 G 0 T 0}
    foreach char [split $strand ""] {
        if {![dict exists $counts $char]} {
            error "Invalid nucleotide in strand"
        }
        dict incr counts $char
    }
    return $counts
}
