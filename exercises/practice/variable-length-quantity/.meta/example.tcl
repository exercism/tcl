#!tclsh

set SHIFT_AMT 7
set MSB  0b10000000
set MASK 0b01111111

proc encode {numbers} {
    set bytes {}
    foreach num [lreverse $numbers] {
        set msb 0
        while 1 {
            set byte [expr {($num & $::MASK) | $msb}]
            set bytes [concat $byte $bytes]
            set msb $::MSB
            set num [expr {$num >> $::SHIFT_AMT}]
            if {$num == 0} then break
        }
    }
    return [lmap byte $bytes {format {0x%02X} $byte}]
}

proc decode {bytes} {
    if {([lindex $bytes end] & $::MSB) != 0} {
        error "incomplete sequence"
    }
    set numbers {}
    set num 0
    foreach byte $bytes {
        set num [expr {($num << $::SHIFT_AMT) + ($byte & $::MASK)}]
        if {($byte & $::MSB) == 0} {
            lappend numbers $num
            set num 0
        }
    }
    return [lmap num $numbers {format {0x%X} $num}]
}
