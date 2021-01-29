namespace eval grains {
    namespace export square total

    # This turns the namespace name "grains" into
    # the _command_ "grains", with subcommands
    # "square" and "total":
    namespace ensemble create

    proc square {sq} {
        if {$sq < 1 || $sq > 64} {
            error "square must be between 1 and 64"
        }
        return [expr {1 << ($sq - 1)}]
    }

    proc total {} {
        return [expr {(1 << 64) - 1}]
    }
}
