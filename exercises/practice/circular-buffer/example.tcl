# This class implements a circular buffer like a queue with a fixed capacity.
#
oo::class create CircularBuffer {
    variable capacity
    variable buffer

    constructor {size} {
        set capacity $size
        set buffer [list]
    }

    method clear {} {
        set buffer [list]
        return
    }

    method empty? {} {
        return [expr {[llength $buffer] == 0}]
    }

    method full? {} {
        return [expr {[llength $buffer] == $capacity}]
    }

    method read {} {
        if {[my empty?]} {
            error "buffer is empty"
        }
        # take the value from the head of the queue
        set buffer [lassign $buffer value]
        return $value
    }

    method overwrite {value} {
        my write $value true
        return
    }

    method write {value {force false}} {
        if {[my full?]} {
            if {$force} {
                # read the oldest value to free a cell
                my read
            } else {
                error "buffer is full"
            }
        }
        # add the value to the end of the queue
        lappend buffer $value
        return
    }
}
