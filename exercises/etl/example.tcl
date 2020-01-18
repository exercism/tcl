proc transform {legacy} {
    try {
        set old [dict create {*}$legacy]
    } on error {} {
        error "invalid input"
    }

    set new [dict create]
    dict for {score letters} $old {
        foreach letter $letters {
            dict set new [string tolower $letter] $score
        }
    }
    return $new
}
