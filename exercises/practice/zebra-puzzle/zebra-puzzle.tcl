# a "permutations" module
lappend auto_path lib
package require permutations

# and make a `permutations` command available with the
# required arguments.
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
