lappend auto_path lib
package require permutations

interp alias {} permutations {} ::permutations::permutationsOfSize {1 2 3 4 5} 5

############################################################
# returns true if "first" is to the right of "second"
proc ::tcl::mathfunc::toTheRightOf {first second} {
    expr {$first == $second + 1}
}

# returns true if "first" is the neighbour of "second"
proc ::tcl::mathfunc::nextTo {first second} {
    expr {toTheRightOf($first, $second) || toTheRightOf($second, $first)}
}

############################################################
# algorithm taken from Kotlin example solution

# The clues, and the method that implements them:
#  1. There are five houses.
#  2. The Englishman lives in the red house. (SolveForNationality)
#  3. The Spaniard owns the dog. (SolveForPets)
#  4. The person in the green house drinks coffee. (SolveForBeverages)
#  5. The Ukrainian drinks tea. (SolveForBeverages)
#  6. The green house is immediately to the right of the ivory house. (SolveForColour)
#  7. The snail owner likes to go dancing. (SolveForPets)
#  8. The person in the yellow house is a painter. (SolveForHobbies)
#  9. The person in the middle house drinks milk. (SolveForBeverages)
#  10. The Norwegian lives in the first house. (SolveForNationality)
#  11. The person who enjoys reading lives in the house next to the person with the fox. (SolveForPets)
#  12. The painter's house is next to the house with the horse. (SolveForPets)
#  13. The person who plays football drinks orange juice. (SolveForHobbies)
#  14. The Japanese person plays chess. (SolveForHobbies)
#  15. The Norwegian lives next to the blue house. (SolveForNationality)

############################################################
oo::class create ZebraPuzzle {
    variable waterDrinker
    variable zebraOwner

    variable one two three four five
    variable red green ivory yellow blue
    variable english spanish ukranian norwegian japanese
    variable dog snails fox horse zebra
    variable dancing painting reading football chess
    variable coffee tea milk orangeJuice water

    variable nationalities
    variable FIRST MIDDLE

    constructor {args} {
        set FIRST 1
        set MIDDLE 3
        
        my Solve
    }

    method drinksWater {} {
        return $waterDrinker
    }

    method ownsZebra {} {
        return $zebraOwner
    }

    method Solve {} {
        foreach p [permutations] {
            my SolveForColour $p
        }
    }

    method SolveForColour {permutation} {
        lassign $permutation red green ivory yellow blue
        # clue 6
        if {toTheRightOf($green, $ivory)} {
            foreach p [permutations] {
                if {[my SolveForNationality $p]} then {return true}
            }
        }
        return false
    }

    method SolveForNationality {permutation} {
        lassign $permutation english spanish ukranian norwegian japanese
        # clues 2, 10, 15
        if {
            $english == $red
            && $norwegian == $FIRST
            && nextTo($norwegian, $blue)
        } {
            foreach p [permutations] {
                set nationality [dict create]
                dict set nationalities $english   EnglishMan
                dict set nationalities $spanish   Spaniard
                dict set nationalities $ukranian  Ukranian
                dict set nationalities $norwegian Norwegian
                dict set nationalities $japanese  Japanese

                if {[my SolveForBeverages $p]} then {return true}
            }
        }
        return false
    }

    method SolveForBeverages {permutation} {
        lassign $permutation coffee tea milk orangeJuice water
        # clues 4, 5, 9
        if {
            $coffee == $green
            && $ukranian == $tea
            && $milk == $MIDDLE
        } {
            foreach p [permutations] {
                if {[my SolveForHobbies $p]} then {return true}
            }
        }
        return false
    }

    method SolveForHobbies {permutation} {
        lassign $permutation dancing painting reading football chess
        # clues 8, 13, 14
        if {
            $painting == $yellow
            && $football == $orangeJuice
            && $japanese == $chess
        } {
            foreach p [permutations] {
                if {[my SolveForPets $p]} then {return true}
            }
        }
        return false
    }

    method SolveForPets {permutation} {
        lassign $permutation dog snails fox horse zebra
        # clues 3, 7, 11, 12
        if {
            $spanish == $dog
            && $dancing == $snails
            && nextTo($reading, $fox)
            && nextTo($painting, $horse)
        } {
            set waterDrinker [dict get $nationalities $water]
            set zebraOwner [dict get $nationalities $zebra]
            return true
        }
        return false
    }
}
