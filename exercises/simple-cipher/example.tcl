oo::class create SimpleCipher {

    constructor {{key ""}} {
        variable Key
        variable alphabet "abcdefghijklmnopqrstuvwxyz"

        if {$key ne ""} {
            set Key $key
        } else {
            # 100 random letters
            for {set i 0} {$i < 100} {incr i} {
                set idx [expr {int(26 * rand())}]
                append Key [string range $alphabet $idx $idx]
            }
        }
    }

    method key {} {
        my variable Key
        return $Key
    }

    method encode {phrase} {
        my _code $phrase "+"
    }

    method decode {phrase} {
        my _code $phrase "-"
    }

    method _code {phrase op} {
        my variable Key alphabet

        while {[string length $phrase] > [string length $Key]} {
            append Key $Key
        }

        set coded ""
        for {set i 0} {$i < [string length $phrase]} {incr i} {
            set char [string tolower [string range $phrase $i $i]]
            set idx [string first $char $alphabet]
            if {$idx == -1} {
                set enc $char
            } else {
                set keyChar [string range $Key $i $i]
                set keyIdx [string first $keyChar $alphabet]
                # using quotes so the operator is substituted first
                set encIdx [expr "($idx $op $keyIdx) % 26"]
                set enc [string range $alphabet $encIdx $encIdx]
            }
            append coded $enc
        }
        return $coded
    }
}
