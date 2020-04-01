oo::class create Robot {
    constructor {} {
        throw {NOT_IMPLEMENTED} "Implement this class"
    }

    method name {} {
        throw {NOT_IMPLEMENTED} "Implement me"
    }

    method reset {} {
        throw {NOT_IMPLEMENTED} "Implement me"
    }
}

proc resetRobotNames {} {
    throw {NOT_IMPLEMENTED} {
        This procedure should reset the available and/or used robot names
    }
}
