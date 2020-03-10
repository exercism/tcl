proc treeFromTraversals {preorder inorder} {
    validateTraversals $preorder $inorder

    if {[llength $preorder] == 0} {
        return {}
    }

    set rootValue [lindex $preorder 0]
    set idx [lsearch -exact $inorder $rootValue]

    set leftInorder  [lrange $inorder 0 $idx-1]
    set rightInorder [lrange $inorder $idx+1 end]

    set leftPreorder  [lrange $preorder 1 [llength $leftInorder]]
    set rightPreorder [lrange $preorder [llength $leftInorder]+1 end]

    set procname [lindex [info level 0] 0]
    set tree [dict create]

    dict set tree v $rootValue
    dict set tree l [$procname $leftPreorder $leftInorder]
    dict set tree r [$procname $rightPreorder $rightInorder]

    return $tree
}

proc validateTraversals {preorder inorder} {
    if {[llength $preorder] != [llength $inorder]} {
        error "traversals must have the same length"
    }

    set preElems [lsort $preorder]
    set inElems  [lsort $inorder]

    if {$preElems ne $inElems} {
        error "traversals must contain the same elements"
    }

    if {$preElems ne [lsort -uniq $preElems]} {
        error "traversals must contain unique elements"
    }
}
