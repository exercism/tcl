#!/usr/bin/env tclsh
# generated: 2026-07-16T22:56:45Z
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "binary-search-tree.tcl"


test binary-search-tree-1 "data is retained" -body {
    set b [BinarySearchTree new]
    $b insert 4
    $b toDict
} -returnCodes ok -match dictionary -result {
  data 4
  left {}
  right {}
}

skip binary-search-tree-2
test binary-search-tree-2 "insert data at proper node: smaller number at left node" -body {
    set b [BinarySearchTree new]
    $b insert 4
    $b insert 2
    $b toDict
} -returnCodes ok -match dictionary -result {
  data 4
  left {
    data 2
    left {}
    right {}
  }
  right {}
}

skip binary-search-tree-3
test binary-search-tree-3 "insert data at proper node: same number at left node" -body {
    set b [BinarySearchTree new]
    $b insert 4
    $b insert 4
    $b toDict
} -returnCodes ok -match dictionary -result {
  data 4
  left {
    data 4
    left {}
    right {}
  }
  right {}
}

skip binary-search-tree-4
test binary-search-tree-4 "insert data at proper node: greater number at right node" -body {
    set b [BinarySearchTree new]
    $b insert 4
    $b insert 5
    $b toDict
} -returnCodes ok -match dictionary -result {
  data 4
  left {}
  right {
    data 5
    left {}
    right {}
  }
}

skip binary-search-tree-5
test binary-search-tree-5 "can create complex tree" -body {
    set b [BinarySearchTree new]
    foreach n {4 2 6 1 3 5 7} {
        $b insert $n
    }
    $b toDict
} -returnCodes ok -match dictionary -result {
  data 4
  left {
    data 2
    left {
      data 1
      left {}
      right {}
    }
    right {
      data 3
      left {}
      right {}
    }
  }
  right {
    data 6
    left {
      data 5
      left {}
      right {}
    }
    right {
      data 7
      left {}
      right {}
    }
  }
}

skip binary-search-tree-6
test binary-search-tree-6 "can sort data: can sort single number" -body {
    set b [BinarySearchTree new]
    $b insert 2
    $b sorted
} -returnCodes ok -result {2}

skip binary-search-tree-7
test binary-search-tree-7 "can sort data: can sort if second number is smaller than first" -body {
    set b [BinarySearchTree new]
    $b insert 2
    $b insert 1
    $b sorted
} -returnCodes ok -result {1 2}

skip binary-search-tree-8
test binary-search-tree-8 "can sort data: can sort if second number is same as first" -body {
    set b [BinarySearchTree new]
    $b insert 2
    $b insert 2
    $b sorted
} -returnCodes ok -result {2 2}

skip binary-search-tree-9
test binary-search-tree-9 "can sort data: can sort if second number is greater than first" -body {
    set b [BinarySearchTree new]
    $b insert 2
    $b insert 3
    $b sorted
} -returnCodes ok -result {2 3}

skip binary-search-tree-10
test binary-search-tree-10 "can sort data: can sort complex tree" -body {
    set b [BinarySearchTree new]
    foreach n {2 1 3 6 7 5} {
        $b insert $n
    }
    $b sorted
} -returnCodes ok -result {1 2 3 5 6 7}

skip binary-search-tree-extra-challenge
test binary-search-tree-extra-challenge "can iterate over sorted data" -body {
    set b [BinarySearchTree new]
    foreach n {4 2 6 1 3 5 7} {
        $b insert $n
    }
    $b map node {expr {[$node data] + 10}}
} -returnCodes ok -result {11 12 13 14 15 16 17}


cleanupTests
