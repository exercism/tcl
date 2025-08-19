namespace eval ::IntergalacticTransmission {
    namespace export transmit decode

    proc transmit {bytes} {
        set bits [bytesToBits $bytes]
        set encoded {}

        while {[llength $bits] >= 7} {
            set chunk [lrange $bits 0 6]
            set bits  [lrange $bits 7 end]
            lappend encoded [bitsToByte [concat $chunk [parity $chunk]]]
        }

        if {[llength $bits] > 0} {
            while {[llength $bits] < 7} {
                lappend bits 0
            }
            lappend encoded [bitsToByte [concat $bits [parity $bits]]]
        }

        return $encoded
    }

    proc decode {bytes} {
        set decodedBits {}
        foreach byte $bytes {
            set bits [bytesToBits $byte]
            if {[parity [lrange $bits 0 6]] != [lindex $bits end]} {
                error "wrong parity"
            }
            lappend decodedBits {*}[lrange $bits 0 6]
        }

        set decoded {}
        while {[llength $decodedBits] >= 8} {
            lappend decoded [bitsToByte [lrange $decodedBits 0 7]]
            set decodedBits [lrange $decodedBits 8 end]
        }
        # any remaining bits are the padding bits
        # that were added for the transmission

        return $decoded
    }

    proc bytesToBits {bytes} {
        set bits {}
        foreach byte $bytes {
            lappend bits {*}[split [format %08b $byte] ""]
        }
        return $bits
    }

    proc parity {bits} {
        set sum 0
        foreach bit $bits {
            incr sum $bit
        }
        return [expr {$sum & 1}]
    }

    proc bitsToByte {bits} {
        return [format "0x%02x" "0b[join $bits ""]"]
    }
}

interp alias {} transmitSequence {} ::IntergalacticTransmission::transmit
interp alias {} decodeMessage    {} ::IntergalacticTransmission::decode
