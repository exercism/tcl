oo::class create AffineCipher {
    variable mapping

    constructor {a b} {
        set alphabet {a b c d e f g h i j k l m n o p q r s t u v w x y z}
        set m [llength $alphabet]

        # coprime check
        if {gcd($a, $m) != 1} {
            error "a and m must be coprime."
        }

        set mapping {}
        for {set x 0} {$x < $m} {incr x} {
            set idx [expr {($a * $x + $b) % $m}]
            lappend mapping [lindex $alphabet $x] [lindex $alphabet $idx]
        }
    }

    method encode {phrase} {
        set coded [my encipher $phrase $mapping]
        return [my grouped $coded]
    }

    method decode {phrase} {
        set coded [my encipher $phrase [lreverse $mapping]]
        return $coded
    }

    method encipher {phrase map} {
        set input [regsub -all {[^[:alnum:]]} $phrase {}]
        return [string map $map [string tolower $input]]
    }
    unexport encipher ;# private

    method grouped {text {size 5}} {
        return [join [regexp -inline -all ".{1,$size}" $text] " "]
    }
    unexport grouped ;# private
}

############################################################
proc ::tcl::mathfunc::gcd {x y} {
    if {$y == 0} {
        return $x
    }
    set thisproc [lindex [info level 0] 0]
    tailcall $thisproc $y [expr {$x % $y}]
}

############################################################
proc affine_encode {phrase a b} {
    [AffineCipher new $a $b] encode $phrase
}

proc affine_decode {phrase a b} {
    [AffineCipher new $a $b] decode $phrase
}
