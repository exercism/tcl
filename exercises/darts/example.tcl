proc score {x y} {
    set distance [::tcl::mathfunc::hypot $x $y]
    if {$distance > 10} then {return 0}
    if {$distance >  5} then {return 1}
    if {$distance >  1} then {return 5}
    return 10
}
