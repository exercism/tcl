# a "permutations" function
lappend auto_path .
package require permutations
interp alias {} permutations {} ::permutations::permutationsOfSize {1 2 3 4 5} 5


oo::class create ZebraPuzzle {
    constructor {args} {
        throw {NOT_IMPLEMENTED} "Implement this class."
    }

    method drinksWater {} {
        throw {NOT_IMPLEMENTED} "Implement this method."
    }

    method ownsZebra {} {
        throw {NOT_IMPLEMENTED} "Implement this method."
    }
}
