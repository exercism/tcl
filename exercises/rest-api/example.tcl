oo::class create RestAPI {
    variable db
    variable routes

    constructor {data} {
        set db {}
        foreach user [dict get $data users] {
            dict set db [dict get $user name] $user
        }

        set routes {
            GET {
                "/users"    GetUsers
            }
            POST {
                "/add"      AddUser
                "/iou"      IOU
            }
        }
    }

    # forwarded methods append their arguments to the handler
    #       method  handler
    forward get     my RequestHandler GET
    forward post    my RequestHandler POST


    method RequestHandler {method url {payload {}}} {
        if {![dict exists $routes $method]} {
            error "405: Method not allowed"
        }
        if {![dict exists $routes $method $url]} {
            error "404: Not found"
        }
        set handler [dict get $routes $method $url]
        my $handler $payload
    }
    
    method GetUsers {payload} {
        if {$payload ne "" && ![dict exists $payload users]} {
            error "400: Malformed request"
        }
        if {$payload eq ""} {
            set names [dict keys $db]
        } else {
            set names [dict get $payload users]
        }
        dict set out users [my GetNamedUsers $names]
        return $out
    }

    method GetNamedUsers {names} {
        set users {}
        foreach name $names {
            if {[dict exists $db $name]} {
                lappend users [dict get $db $name]
            }
        }
        return [lsort -index 1 $users]
    }

    method AddUser {payload} {
        if {![dict exists $payload user]} {
            error "400: Malformed request"
        }
        set name [dict get $payload user]
        set user [my GetNamedUsers [list $name]]
        if {$user ne ""} {
            error "400: User already exists"
        }
        set userDict [list name $name owes {} owed_by {} balance 0]
        dict lappend db users $userDict
        return $userDict
    }

    method IOU {payload} {
        foreach key {lender borrower amount} {
            if {![dict exists $payload $key]} {
                error "400: Malformed request"
            }
            set $key [dict get $payload $key]
        }
        if {![dict exists $db $lender]} {
            error "400: No such lender"
        }
        if {![dict exists $db $borrower]} {
            error "400: No such borrower"
        }

        my Loan $lender $borrower $amount
        return [list users [my GetNamedUsers [list $lender $borrower]]]
    }

    method Loan {from to amount} {
        set origAmount $amount
        set fromUser [dict get $db $from]
        set toUser   [dict get $db $to]

        set borrowerOwesLender true

        if {[dict exists [dict get $fromUser owes] $to]} {
            set borrowerOwesLender false
            if {$amount < [dict get $fromUser owes $to]} {
                dict update fromUser owes o {
                    dict incr o $to -$amount
                }
                dict update toUser owed_by o {
                    dict incr o $from -$amount
                }
            } else {
                if {$amount > [dict get $fromUser owes $to]} {
                    incr amount [expr {-1 * [dict get $fromUser owes $to]}]
                    set borrowerOwesLender true
                }
                dict unset fromUser owes $to
                dict unset toUser   owed_by $from
            }
        }
        if {$borrowerOwesLender} {
            dict update fromUser owed_by o {
                dict incr o $to $amount
            }
            dict update toUser owes o {
                dict incr o $from $amount
            }
        }
        dict incr fromUser balance $origAmount
        dict incr toUser   balance -$origAmount

        foreach key {owes owed_by} {
            dict set fromUser $key [lsort -index 0 -stride 2 [dict get $fromUser $key]]
            dict set toUser $key [lsort -index 0 -stride 2 [dict get $toUser $key]]
        }

        dict set db $from $fromUser
        dict set db $to   $toUser
    }
}
