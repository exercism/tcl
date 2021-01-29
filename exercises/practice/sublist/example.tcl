namespace eval Sublists {
    namespace export sublist

    proc sublist {list1 list2} {
        set dataDict [prepare $list1 $list2]

        dict with dataDict {
            # the dictionary's key-value pairs are now local variables
            #
            for {set i 0} {$i <= $longLen - $shortLen} {incr i} {
                set match true
                for {set j 0} {$j < $shortLen} {incr j} {
                    if {[lindex $shorter $j] != [lindex $longer $i+$j]} {
                        set match false
                        break
                    }
                }
                if {$match} {
                    return $trueResult
                }
            }
            return "unequal"
        }
    }

    proc prepare {list1 list2} {
        set len1 [llength $list1]
        set len2 [llength $list2]

        if {$len1 > $len2} {
            return [list longer $list1 longLen $len1 shorter $list2 shortLen $len2 trueResult "superlist"]
        } elseif {$len1 < $len2} {
            return [list longer $list2 longLen $len2 shorter $list1 shortLen $len1 trueResult "sublist"]
        } else {
            return [list longer $list1 longLen $len1 shorter $list2 shortLen $len2 trueResult "equal"]
        }
    }
}

namespace import Sublists::sublist
