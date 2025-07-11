oo::class create PlatformIO {
    variable stats

    constructor {} {
        set stats {reads 0 readBytes 0 writes 0 writeBytes 0}
    }

    method open {args} {
        set handle [::open {*}$args]
        ::chan push $handle [self object]
        return $handle
    }

    method socket {args} {
        set sock [::socket {*}$args]
        ::chan push $sock [self object]
        return $sock
    }

    method stats {} {
        return $stats
    }

    # subcommands required by channel transforms

    method initialize {handle mode} {
        return {initialize finalize read write}
    }

    method finalize {handle} {
        return ;# nothing to do
    }

    method read {handle buffer} {
        dict incr stats reads
        dict incr stats readBytes [string length $buffer]
        return $buffer
    }

    method write {handle buffer} {
        dict incr stats writes
        dict incr stats writeBytes [string length $buffer]
        return $buffer
    }
}
