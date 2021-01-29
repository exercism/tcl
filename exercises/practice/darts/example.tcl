proc score {x y} {
    set distance [expr {hypot($x, $y)}]
    if {$distance <=  1} then {return 10}
    if {$distance <=  5} then {return 5}
    if {$distance <= 10} then {return 1} else {return 0}
}
