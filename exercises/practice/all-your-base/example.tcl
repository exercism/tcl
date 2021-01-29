proc rebase {inputBase digits outputBase} {
    if {$inputBase < 2} {
        error "input base must be >= 2"
    }
    if {$outputBase < 2} {
        error "output base must be >= 2"
    }

    set decimal 0
    foreach digit $digits {
        if {$digit < 0 || $digit >= $inputBase} {
            error "all digits must satisfy 0 <= d < input base"
        }

        set decimal [expr {$decimal * $inputBase + $digit}]
    }

    set outputDigits {}
    if {$decimal == 0} {
        lappend outputDigits 0
    } else {
        while {$decimal > 0} {
            unshift outputDigits [expr {$decimal % $outputBase}]
            set decimal [expr {$decimal / $outputBase}]
        }
    }
    return $outputDigits
}

proc unshift {varname value} {
    upvar 1 $varname list
    set list [linsert $list[set list {}] 0 $value]
    # .....................^^^^^^^^^^^^^
    # performance hack to forcibly unshare the object before setting it.
    # See "Unsharing Objects" in https://wiki.tcl-lang.org/page/K
}
