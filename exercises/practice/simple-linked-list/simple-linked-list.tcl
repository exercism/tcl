oo::class create Node {
    variable datum
    variable next

    constructor {value} {
        throw {NOT_IMPLEMENTED} "Implement this class."
    }
}


oo::class create SimpleLinkedList {
    variable head

    constructor {{values {}}} {
        throw {NOT_IMPLEMENTED} "Implement this class."
    }
}
