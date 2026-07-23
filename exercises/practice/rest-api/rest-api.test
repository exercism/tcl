#!/usr/bin/env tclsh
# generated: 2026-07-23T15:36:16Z
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "rest-api.tcl"


test rest-api-1 "user management: no users" -body {
    set db {users {}}
    set api [RestAPI new $db]
    $api get /users
} -returnCodes ok -match dictionary -result {users {}}
skip rest-api-2
test rest-api-2 "user management: add user" -body {
    set db {users {}}
    set api [RestAPI new $db]
    set payload {user Adam}
    $api post /add $payload
} -returnCodes ok -result {name Adam owes {} owed_by {} balance 0}
skip rest-api-3
test rest-api-3 "user management: get single user" -body {
    set db {users {
        {name Adam owes {} owed_by {} balance 0}
        {name Bob owes {} owed_by {} balance 0}
    }}
    set api [RestAPI new $db]
    set payload {users Bob}
    $api get /users $payload
} -returnCodes ok -match dictionary -result {users {
        {name Bob owes {} owed_by {} balance 0}
    }}
skip rest-api-4
test rest-api-4 "iou: both users have 0 balance" -body {
    set db {users {
        {name Adam owes {} owed_by {} balance 0}
        {name Bob owes {} owed_by {} balance 0}
    }}
    set api [RestAPI new $db]
    set payload {lender Adam borrower Bob amount 3}
    $api post /iou $payload
} -returnCodes ok -match dictionary -result {users {
        {name Adam owes {} owed_by {Bob 3} balance 3}
        {name Bob owes {Adam 3} owed_by {} balance -3}
    }}
skip rest-api-5
test rest-api-5 "iou: borrower has negative balance" -body {
    set db {users {
        {name Adam owes {} owed_by {} balance 0}
        {name Bob owes {Chuck 3} owed_by {} balance -3}
        {name Chuck owes {} owed_by {Bob 3} balance 3}
    }}
    set api [RestAPI new $db]
    set payload {lender Adam borrower Bob amount 3}
    $api post /iou $payload
} -returnCodes ok -match dictionary -result {users {
        {name Adam owes {} owed_by {Bob 3} balance 3}
        {name Bob owes {Adam 3 Chuck 3} owed_by {} balance -6}
    }}
skip rest-api-6
test rest-api-6 "iou: lender has negative balance" -body {
    set db {users {
        {name Adam owes {} owed_by {} balance 0}
        {name Bob owes {Chuck 3} owed_by {} balance -3}
        {name Chuck owes {} owed_by {Bob 3} balance 3}
    }}
    set api [RestAPI new $db]
    set payload {lender Bob borrower Adam amount 3}
    $api post /iou $payload
} -returnCodes ok -match dictionary -result {users {
        {name Adam owes {Bob 3} owed_by {} balance -3}
        {name Bob owes {Chuck 3} owed_by {Adam 3} balance 0}
    }}
skip rest-api-7
test rest-api-7 "iou: lender owes borrower" -body {
    set db {users {
        {name Adam owes {Bob 3} owed_by {} balance -3}
        {name Bob owes {} owed_by {Adam 3} balance 3}
    }}
    set api [RestAPI new $db]
    set payload {lender Adam borrower Bob amount 2}
    $api post /iou $payload
} -returnCodes ok -match dictionary -result {users {
        {name Adam owes {Bob 1} owed_by {} balance -1}
        {name Bob owes {} owed_by {Adam 1} balance 1}
    }}
skip rest-api-8
test rest-api-8 "iou: lender owes borrower less than new loan" -body {
    set db {users {
        {name Adam owes {Bob 3} owed_by {} balance -3}
        {name Bob owes {} owed_by {Adam 3} balance 3}
    }}
    set api [RestAPI new $db]
    set payload {lender Adam borrower Bob amount 4}
    $api post /iou $payload
} -returnCodes ok -match dictionary -result {users {
        {name Adam owes {} owed_by {Bob 1} balance 1}
        {name Bob owes {Adam 1} owed_by {} balance -1}
    }}
skip rest-api-9
test rest-api-9 "iou: lender owes borrower same as new loan" -body {
    set db {users {
        {name Adam owes {Bob 3} owed_by {} balance -3}
        {name Bob owes {} owed_by {Adam 3} balance 3}
    }}
    set api [RestAPI new $db]
    set payload {lender Adam borrower Bob amount 3}
    $api post /iou $payload
} -returnCodes ok -match dictionary -result {users {
        {name Adam owes {} owed_by {} balance 0}
        {name Bob owes {} owed_by {} balance 0}
    }}

cleanupTests
