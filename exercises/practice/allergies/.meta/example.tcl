namespace eval Allergies {
    variable allergens {
        eggs
        peanuts
        shellfish
        strawberries
        tomatoes
        chocolate
        pollen
        cats
    }

    namespace export allergicTo listAllergies

    proc allergicTo {allergen score} {
        variable allergens
        set idx [lsearch -exact $allergens $allergen]
        expr {$idx != -1 && ($score & (1 << $idx)) > 0}
    }

    proc listAllergies {score} {
        variable allergens
        filter allergen $allergens {allergicTo $allergen $score}
    }
}

proc filter {elemVar list condition} {
    upvar 1 $elemVar elem
    lmap elem $list {
        if {[uplevel 1 $condition]} {
            set elem
        } else {
            continue
        }
    }
}

namespace import Allergies::*
