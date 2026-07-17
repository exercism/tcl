#!/usr/bin/env tclsh
# generated: 2026-07-17T18:51:33Z
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "custom-set.tcl"


# Returns the elements of the set as a list
test custom-set-0.1 "sets with no elements" -body {
    set s [Set new {}]
    $s toList
} -returnCodes ok -match unorderedLists -result {}

skip custom-set-0.2
test custom-set-0.2 "sets with elements" -body {
    set s [Set new {1 2 3 4}]
    $s toList
} -returnCodes ok -match unorderedLists -result {4 3 1 2}

# Size of a set
skip custom-set-0.3
test custom-set-0.3 "size of sets with no elements" -body {
    set s [Set new {}]
    $s size
} -returnCodes ok -result 0

skip custom-set-0.4
test custom-set-0.4 "size of sets with elements" -body {
    set s [Set new {3 2 1}]
    $s size
} -returnCodes ok -result 3

skip custom-set-1
test custom-set-1 "Returns true if the set contains no elements: sets with no elements are empty" -body {
    set s [Set new {}]
    $s isEmpty
} -returnCodes ok -match boolean -result true

skip custom-set-2
test custom-set-2 "Returns true if the set contains no elements: sets with elements are not empty" -body {
    set s [Set new {1}]
    $s isEmpty
} -returnCodes ok -match boolean -result false

skip custom-set-3
test custom-set-3 "Sets can report if they contain an element: nothing is contained in an empty set" -body {
    set s [Set new {}]
    $s contains 1
} -returnCodes ok -match boolean -result false

skip custom-set-4
test custom-set-4 "Sets can report if they contain an element: when the element is in the set" -body {
    set s [Set new {1 2 3}]
    $s contains 1
} -returnCodes ok -match boolean -result true

skip custom-set-5
test custom-set-5 "Sets can report if they contain an element: when the element is not in the set" -body {
    set s [Set new {1 2 3}]
    $s contains 4
} -returnCodes ok -match boolean -result false

skip custom-set-6
test custom-set-6 "A set is a subset if all of its elements are contained in the other set: empty set is a subset of another empty set" -body {
    set s1 [Set new {}]
    set s2 [Set new {}]
    $s1 subsetOf $s2
} -returnCodes ok -match boolean -result true

skip custom-set-7
test custom-set-7 "A set is a subset if all of its elements are contained in the other set: empty set is a subset of non-empty set" -body {
    set s1 [Set new {}]
    set s2 [Set new {1}]
    $s1 subsetOf $s2
} -returnCodes ok -match boolean -result true

skip custom-set-8
test custom-set-8 "A set is a subset if all of its elements are contained in the other set: non-empty set is not a subset of empty set" -body {
    set s1 [Set new {1}]
    set s2 [Set new {}]
    $s1 subsetOf $s2
} -returnCodes ok -match boolean -result false

skip custom-set-9
test custom-set-9 "A set is a subset if all of its elements are contained in the other set: set is a subset of set with exact same elements" -body {
    set s1 [Set new {1 2 3}]
    set s2 [Set new {1 2 3}]
    $s1 subsetOf $s2
} -returnCodes ok -match boolean -result true

skip custom-set-10
test custom-set-10 "A set is a subset if all of its elements are contained in the other set: set is a subset of larger set with same elements" -body {
    set s1 [Set new {1 2 3}]
    set s2 [Set new {4 1 2 3}]
    $s1 subsetOf $s2
} -returnCodes ok -match boolean -result true

skip custom-set-11
test custom-set-11 "A set is a subset if all of its elements are contained in the other set: set is not a subset of set that does not contain its elements" -body {
    set s1 [Set new {1 2 3}]
    set s2 [Set new {4 1 3}]
    $s1 subsetOf $s2
} -returnCodes ok -match boolean -result false

skip custom-set-12
test custom-set-12 "Sets are disjoint if they share no elements: the empty set is disjoint with itself" -body {
    set s1 [Set new {}]
    set s2 [Set new {}]
    $s1 disjoint $s2
} -returnCodes ok -match boolean -result true

skip custom-set-13
test custom-set-13 "Sets are disjoint if they share no elements: empty set is disjoint with non-empty set" -body {
    set s1 [Set new {}]
    set s2 [Set new {1}]
    $s1 disjoint $s2
} -returnCodes ok -match boolean -result true

skip custom-set-14
test custom-set-14 "Sets are disjoint if they share no elements: non-empty set is disjoint with empty set" -body {
    set s1 [Set new {1}]
    set s2 [Set new {}]
    $s1 disjoint $s2
} -returnCodes ok -match boolean -result true

skip custom-set-15
test custom-set-15 "Sets are disjoint if they share no elements: sets are not disjoint if they share an element" -body {
    set s1 [Set new {1 2}]
    set s2 [Set new {2 3}]
    $s1 disjoint $s2
} -returnCodes ok -match boolean -result false

skip custom-set-16
test custom-set-16 "Sets are disjoint if they share no elements: sets are disjoint if they share no elements" -body {
    set s1 [Set new {1 2}]
    set s2 [Set new {3 4}]
    $s1 disjoint $s2
} -returnCodes ok -match boolean -result true

skip custom-set-17
test custom-set-17 "Sets with the same elements are equal: empty sets are equal" -body {
    set s1 [Set new {}]
    set s2 [Set new {}]
    $s1 equals $s2
} -returnCodes ok -match boolean -result true

skip custom-set-18
test custom-set-18 "Sets with the same elements are equal: empty set is not equal to non-empty set" -body {
    set s1 [Set new {}]
    set s2 [Set new {1 2 3}]
    $s1 equals $s2
} -returnCodes ok -match boolean -result false

skip custom-set-19
test custom-set-19 "Sets with the same elements are equal: non-empty set is not equal to empty set" -body {
    set s1 [Set new {1 2 3}]
    set s2 [Set new {}]
    $s1 equals $s2
} -returnCodes ok -match boolean -result false

skip custom-set-20
test custom-set-20 "Sets with the same elements are equal: sets with the same elements are equal" -body {
    set s1 [Set new {1 2}]
    set s2 [Set new {2 1}]
    $s1 equals $s2
} -returnCodes ok -match boolean -result true

skip custom-set-21
test custom-set-21 "Sets with the same elements are equal: sets with different elements are not equal" -body {
    set s1 [Set new {1 2 3}]
    set s2 [Set new {1 2 4}]
    $s1 equals $s2
} -returnCodes ok -match boolean -result false

skip custom-set-22
test custom-set-22 "Sets with the same elements are equal: set is not equal to larger set with same elements" -body {
    set s1 [Set new {1 2 3}]
    set s2 [Set new {1 2 3 4}]
    $s1 equals $s2
} -returnCodes ok -match boolean -result false

skip custom-set-23
test custom-set-23 "Sets with the same elements are equal: set is equal to a set constructed from an array with duplicates" -body {
    set s1 [Set new {1}]
    set s2 [Set new {1 1}]
    $s1 equals $s2
} -returnCodes ok -match boolean -result true

skip custom-set-24
test custom-set-24 "Unique elements can be added to a set: add to empty set" -body {
    set s [Set new {}]
    $s add 3
    $s toList
} -returnCodes ok -match unorderedLists -result {3}

skip custom-set-25
test custom-set-25 "Unique elements can be added to a set: add to non-empty set" -body {
    set s [Set new {1 2 4}]
    $s add 3
    $s toList
} -returnCodes ok -match unorderedLists -result {1 2 3 4}

skip custom-set-26
test custom-set-26 "Unique elements can be added to a set: adding an existing element does not change the set" -body {
    set s [Set new {1 2 3}]
    $s add 3
    $s toList
} -returnCodes ok -match unorderedLists -result {1 2 3}

skip custom-set-27
test custom-set-27 "Intersection returns a set of all shared elements: intersection of two empty sets is an empty set" -body {
    set s1 [Set new {}]
    set s2 [Set new {}]
    set s3 [$s1 intersection $s2]
    $s3 toList
} -returnCodes ok -match unorderedLists -result {}

skip custom-set-28
test custom-set-28 "Intersection returns a set of all shared elements: intersection of an empty set and non-empty set is an empty set" -body {
    set s1 [Set new {}]
    set s2 [Set new {3 2 5}]
    set s3 [$s1 intersection $s2]
    $s3 toList
} -returnCodes ok -match unorderedLists -result {}

skip custom-set-29
test custom-set-29 "Intersection returns a set of all shared elements: intersection of a non-empty set and an empty set is an empty set" -body {
    set s1 [Set new {1 2 3 4}]
    set s2 [Set new {}]
    set s3 [$s1 intersection $s2]
    $s3 toList
} -returnCodes ok -match unorderedLists -result {}

skip custom-set-30
test custom-set-30 "Intersection returns a set of all shared elements: intersection of two sets with no shared elements is an empty set" -body {
    set s1 [Set new {1 2 3}]
    set s2 [Set new {4 5 6}]
    set s3 [$s1 intersection $s2]
    $s3 toList
} -returnCodes ok -match unorderedLists -result {}

skip custom-set-31
test custom-set-31 "Intersection returns a set of all shared elements: intersection of two sets with shared elements is a set of the shared elements" -body {
    set s1 [Set new {1 2 3 4}]
    set s2 [Set new {3 2 5}]
    set s3 [$s1 intersection $s2]
    $s3 toList
} -returnCodes ok -match unorderedLists -result {2 3}

skip custom-set-32
test custom-set-32 "Difference (or Complement) of a set is a set of all elements that are only in the first set: difference of two empty sets is an empty set" -body {
    set s1 [Set new {}]
    set s2 [Set new {}]
    set s3 [$s1 difference $s2]
    $s3 toList
} -returnCodes ok -match unorderedLists -result {}

skip custom-set-33
test custom-set-33 "Difference (or Complement) of a set is a set of all elements that are only in the first set: difference of empty set and non-empty set is an empty set" -body {
    set s1 [Set new {}]
    set s2 [Set new {3 2 5}]
    set s3 [$s1 difference $s2]
    $s3 toList
} -returnCodes ok -match unorderedLists -result {}

skip custom-set-34
test custom-set-34 "Difference (or Complement) of a set is a set of all elements that are only in the first set: difference of a non-empty set and an empty set is the non-empty set" -body {
    set s1 [Set new {1 2 3 4}]
    set s2 [Set new {}]
    set s3 [$s1 difference $s2]
    $s3 toList
} -returnCodes ok -match unorderedLists -result {1 2 3 4}

skip custom-set-35
test custom-set-35 "Difference (or Complement) of a set is a set of all elements that are only in the first set: difference of two non-empty sets is a set of elements that are only in the first set" -body {
    set s1 [Set new {3 2 1}]
    set s2 [Set new {2 4}]
    set s3 [$s1 difference $s2]
    $s3 toList
} -returnCodes ok -match unorderedLists -result {1 3}

skip custom-set-36
test custom-set-36 "Difference (or Complement) of a set is a set of all elements that are only in the first set: difference removes all duplicates in the first set" -body {
    set s1 [Set new {1 1}]
    set s2 [Set new {1}]
    set s3 [$s1 difference $s2]
    $s3 toList
} -returnCodes ok -match unorderedLists -result {}

skip custom-set-37
test custom-set-37 "Union returns a set of all elements in either set: union of empty sets is an empty set" -body {
    set s1 [Set new {}]
    set s2 [Set new {}]
    set s3 [$s1 union $s2]
    $s3 toList
} -returnCodes ok -match unorderedLists -result {}

skip custom-set-38
test custom-set-38 "Union returns a set of all elements in either set: union of an empty set and non-empty set is the non-empty set" -body {
    set s1 [Set new {}]
    set s2 [Set new {2}]
    set s3 [$s1 union $s2]
    $s3 toList
} -returnCodes ok -match unorderedLists -result {2}

skip custom-set-39
test custom-set-39 "Union returns a set of all elements in either set: union of a non-empty set and empty set is the non-empty set" -body {
    set s1 [Set new {1 3}]
    set s2 [Set new {}]
    set s3 [$s1 union $s2]
    $s3 toList
} -returnCodes ok -match unorderedLists -result {1 3}

skip custom-set-40
test custom-set-40 "Union returns a set of all elements in either set: union of non-empty sets contains all unique elements" -body {
    set s1 [Set new {1 3}]
    set s2 [Set new {2 3}]
    set s3 [$s1 union $s2]
    $s3 toList
} -returnCodes ok -match unorderedLists -result {3 2 1}


cleanupTests
