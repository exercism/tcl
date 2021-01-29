oo::class create InputCell {
    constructor {value} {
        throw {NOT_IMPLEMENTED} "Implement this class."
    }

    method setValue {aValue} {
        throw {NOT_IMPLEMENTED} "Implement this method."
    }

    method value {} {
        throw {NOT_IMPLEMENTED} "Implement this method."
    }
}

oo::class create ComputeCell {
    constructor {cells func} {
        # For more details about what a "func" is,
        # see the documentation for the [apply] command:
        # https://tcl.tk/man/tcl8.6/TclCmd/apply.htm

        throw {NOT_IMPLEMENTED} "Implement this class."
    }

    method value {} {
        throw {NOT_IMPLEMENTED} "Implement this method."
    }

    method addCallback {func} {
        throw {NOT_IMPLEMENTED} "Implement this method."
    }

    method removeCallback {callback} {
        throw {NOT_IMPLEMENTED} "Implement this method."
    }
}

oo::class create Callback {
    constructor {args} {
        throw {NOT_IMPLEMENTED} "Implement this class."
    }

    method value {} {
        throw {NOT_IMPLEMENTED} "Implement this method."
    }
}
