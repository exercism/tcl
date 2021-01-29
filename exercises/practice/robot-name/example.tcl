# TclOO does not provide class variables or static class methods.
# I'll use a Singleton class to manage the available robot names.

# ref https://wiki.tcl-lang.org/page/TclOO+Tricks
oo::class create singleton {
   superclass oo::class
   variable object
   method create {name args} {
      if {![info exists object]} {
         set object [next $name {*}$args]
      }
      return $object
   }
   method new args {
      if {![info exists object]} {
         set object [next {*}$args]
      }
      return $object
   }
}

# ref https://wiki.tcl-lang.org/page/Shuffling+a+list
proc shuffle {listVar} {
  upvar 1 $listVar in_list
  for {set idx_1 [expr {[llength $in_list] - 1}]} {$idx_1 > 0} {incr idx_1 -1} {
    set idx_2 [expr {int(($idx_1 + 1) * rand())}]
    set temp [lindex $in_list $idx_1]
    lset in_list $idx_1 [lindex $in_list $idx_2]
    lset in_list $idx_2 $temp
  }
}

############################################################
oo::class create RobotNames {
    self mixin singleton

    variable allNames
    variable available
    variable index

    constructor {} {
        # generate all possible names
        foreach a {A B C D E F G H I J K L M N O P Q R S T U V W X Y Z} {
            foreach b {A B C D E F G H I J K L M N O P Q R S T U V W X Y Z} {
                for {set c 0} {$c < 1000} {incr c} {
                    lappend available [format "%s%s%03d" $a $b $c]
                }
            }
        }
        shuffle available
        set index 0
    }

    method next {} {
        if {$index == [llength $available]} {
            error "no more names available"
        }
        set name [lindex $available $index]
        incr index
        return $name
    }
    
    method reset {} {
        set index 0
    }
}

proc resetRobotNames {} {
    [RobotNames new] reset
}

############################################################
oo::class create Robot {
    variable name
    variable allNames

    constructor {} {
        set allNames [RobotNames new]
        my getName
    }

    method getName {} {
        set name [$allNames next]
    }
    unexport getName ;# private

    method name {} {
        return $name
    }

    forward reset my getName
}
