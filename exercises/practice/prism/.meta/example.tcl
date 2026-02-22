#!/usr/bin/env tclsh

############################################################
# add some math functions to use in `expr` expressions
proc ::tcl::mathfunc::deg2rad {degrees} {
    set pi [expr {4 * atan(1)}]
    expr {(fmod($degrees, 360) / 180) * $pi}
}

proc ::tcl::mathfunc::approxEqual {a b {epsilon 0.0000001}} {
    expr {abs($a - $b) <= $epsilon}
}

proc ::tcl::mathfunc::roundTo {n pts} {
    set f [expr {10.0 ** $pts}]
    expr {round($n * $f) / $f}
}

############################################################
oo::class create Point {
    variable x y

    constructor {_x _y} {
        set x $_x
        set y $_y
    }

    method x {} {return $x}
    method y {} {return $y}
    method toString {} {return "($x,$y)"}

    # If you have a starting point $P_1(x_1, y_1)$ and an angle
    # $\theta$, the slope ($m$) of the line is the tangent of that
    # angle:$$m = \tan(\theta)$$
    # The equation for any other point $(x, # y)$ on that line is:
    # $$y - y_1 = m(x - x_1)$$
    #
    method isInline {line} {
        set deltaX [expr {$x - [[$line point] x]}]
        set deltaY [expr {$y - [[$line point] y]}]

        if {$deltaX == 0 && $deltaY == 0} {
            return false
        } elseif {[$line isVertical]} {
            expr {$deltaX == 0}
        } else {
            expr {approxEqual($deltaY, [$line slope] * $deltaX, 0.06)}
        }
    }
}

############################################################
oo::class create Line {
    variable point deg theta

    constructor {p angle} {
        set point $p
        set deg [expr {fmod($angle, 360)}]
        set theta [expr {deg2rad($angle)}]
    }

    method point {} {return $point}
    method angle {} {return $deg}
    method toString {} {return "Line{[$point toString] $deg}"}

    method isVertical {} {
        expr {approxEqual(abs(fmod($deg, 180)), 90, 0.002)}
    }

    method slope {} {
        expr {tan($theta)}
    }

    method nextPrism {prisms} {
        set min [expr {(1 << 63) - 1}] ;# "max int"
        set next ""

        foreach p $prisms {
            set deltaX [expr {[[$p point] x] - [[my point] x]}]
            set deltaY [expr {[[$p point] y] - [[my point] y]}]
            set projection [expr {$deltaX * cos($theta) + $deltaY * sin($theta)}]
            if {$projection > 0 && $projection < $min} {
                set min $projection
                set next $p
            }
        }

        return $next
    }
}

############################################################
oo::class create Prism {
    variable name point refraction

    construct {input} {
        set name [dict get $input id]
        set point [Point new [dict get $input x] [dict get $input y]]
        set refraction [dict get $input angle]
    }

    method point {} {return $point}
    method name {} {return $name}
    method toString {} {return "Prism#$name{[$point toString] $refraction}"}

    method refract {angle} {
        expr {roundTo(fmod($angle + $refraction, 360), 3)}
    }
}

############################################################
proc findSequence {input} {
    set sp [Point new [dict get $input start x] [dict get $input start y]]
    set line [Line new $sp [dict get $input start angle]]

    set prisms [lmap p [dict get $input prisms] {Prism new $p}]

    set result [list]

    while {true} {
        set inlinePrisms [lmap p $prisms {expr {
            [[$p point] isInline $line] ? $p : [continue]
        }}]

        set prism [$line nextPrism $inlinePrisms]
        if {$prism == ""} then break

        lappend result [$prism name]

        set line [Line new [$prism point] [$prism refract [$line angle]]]
    }

    return $result
}
