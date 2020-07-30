package require Thread

proc calculate {input} {

    set maxThreads 3    ;# an arbitrary number
    set threads {}

    # the list of input lines is shared with the threads:
    # first come, first served
    tsv::set sharedVar queue $input

    # the letter frequently will be populated using a dict
    tsv::set sharedVar count {}

    for {set i 0} {$i < $maxThreads} {incr i} {
        lappend threads [thread::create -joinable {

            proc doCount {} {
                while {[tsv::llength sharedVar queue] > 0} {
                    # Another thread may have grabbed the last line here.
                    # No problem though, tsv::lpop returns an empty string
                    # if the list is empty.
                    #
                    set chunk [tsv::lpop sharedVar queue]
                    foreach char [letters $chunk] {
                        incrCount $char
                    }
                }
                # queue is empty, this thread can go away
                thread::release
            }

            proc letters {str} {
                set alpha [regsub -all {[^[:alpha:]]} $str ""]
                return [split [string tolower $alpha] ""]
            }

            proc incrCount {letter} {
                # since we need to get and then set, have to lock
                tsv::lock sharedVar {
                    tsv::get sharedVar count aDict
                    dict incr aDict $letter
                    tsv::set sharedVar count $aDict
                }
            }

            # await further instructions...
            thread::wait
        }]
    }

    # launch each thread
    foreach thread $threads {
        thread::send -async $thread doCount
    }

    # and then collect them
    foreach thread $threads {
        thread::join $thread
    }

    return [tsv::get sharedVar count]
}
