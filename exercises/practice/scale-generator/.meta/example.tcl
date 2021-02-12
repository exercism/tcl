oo::class create Scale {
    variable notes

    constructor {tonic} {
        if {$tonic in {F Bb Eb Ab Db Gb d g c f bb eb}} {
            set notes {A Bb B C Db D Eb E F Gb G Ab}
        } else {
            set notes {A A# B C C# D D# E F F# G G#}
        }

        set idx [lsearch -exact $notes [string totitle $tonic]]
        if {$idx == -1} {error "incorrect tonic"}
        set notes [concat [lrange $notes $idx end] [lrange $notes 0 $idx-1]]
    }

    method chromatic {} {
        return $notes
    }

    method intervals {intervals} {
        set steps {m 1 M 2 A 3}
        set scale {}
        set i 0
        foreach interval [split $intervals ""] {
            if {![dict exists $steps $interval]} {error "incorrect interval"}
            lappend scale [lindex $notes $i]
            incr i [dict get $steps $interval]
        }
        return $scale
    }
}
