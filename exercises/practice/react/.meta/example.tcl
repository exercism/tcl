oo::class create Cell {
    variable value
    variable listeners

    constructor {} {
        set listeners {}
    }

    method value {} {
        return $value
    }

    method setValue {aValue} {
        set value $aValue
    }

    method addListener {computeCell} {
        lappend listeners $computeCell
    }

    method recomputeListeners {} {
        foreach cell $listeners {
            $cell compute
        }
    }

    method fireListenerCallbacks {} {
        foreach cell $listeners {
            $cell fireCallbacks
        }
    }
}

############################################################
#
oo::class create InputCell {
    superclass Cell

    variable value ;# need to repeat instance var declarations

    constructor {aValue} {
        set value $aValue
        next ;# invoke parent constructor
    }

    method setValue {aValue} {
        next $aValue
        my recomputeListeners
        my fireListenerCallbacks
    }
}

############################################################
#
oo::class create ComputeCell {
    superclass Cell
    unexport setValue

    variable value ;# need to repeat instance var declarations
    variable listeners

    variable inputCells
    variable previousValue
    variable callbacks
    variable func

    constructor {listOfCells aFunc} {
        next
        set inputCells $listOfCells
        set func $aFunc

        foreach cell $listOfCells {
            $cell addListener [self]
        }
        my compute ;# sets value

        set previousValue $value
        set callbacks {}
    }

    method compute {} {
        my setValue [apply $func [lmap cell $inputCells {$cell value}]]
        my recomputeListeners
    }

    method addCallback {func} {
        set cb [Callback new [self] $func]
        lappend callbacks $cb
        return $cb
    }

    method fireCallbacks {} {
        if {$value != $previousValue} {
            set previousValue $value
            foreach cb $callbacks {
                $cb fire
            }
            my fireListenerCallbacks
        }
    }

    method removeCallback {aCallback} {
        set idx [lsearch -exact $callbacks $aCallback]
        if {$idx != -1} {
            set callbacks [lreplace $callbacks $idx $idx]
        }
    }
}

############################################################
#
oo::class create Callback {
    variable cell
    variable func
    variable value

    constructor {aCell aFunc} {
        set cell $aCell
        set func $aFunc
        set value {}
    }

    method value {} {
        return $value
    }

    method fire {} {
        set value [apply $func $cell]
    }
}
