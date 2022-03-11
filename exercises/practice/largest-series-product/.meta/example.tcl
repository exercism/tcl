namespace import ::tcl::mathop::\*
namespace import ::tcl::mathfunc::max

proc largestSeriesProduct {digits span} {
    set len [string length $digits]

    if {$len < $span} {
        error "span must be smaller than string length"
    }
    if {$span < 0} {
        error "span must not be negative"
    }
    if {[regexp {\D} $digits]} {
        error "digits input must only contain digits"
    }

    set prod {}
    for {set i 0} {$i <= $len - $span} {incr i} {
        set j [expr {$i + $span - 1}]
        set series [split [string range $digits $i $j] ""]
        # with no arguments, tcl::mathop::* returns 1 "the multiplicative identity"
        lappend prod [* {*}$series]
    }
    return [max {*}$prod]
}
